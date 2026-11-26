# Support chat — Kafka push + real-time notifications

What was built: an out-of-chat notification path for support chat that decides **per message and
per recipient** whether the existing SSE frame was enough or a device push is needed, records the
result in the notification module (`model/engage`), and delivers it in real time to an open app.

Nothing here duplicates the engage module: device tokens come from `model/engage`, the
notification log and templates come from `model/engage`, and delivery reuses
`service/engage/dispatch/fcm.go`.

---

## 1. Flow

```
 customer/staff POST /messages
        │
        ├── persist message (MySQL)  ← source of truth, never rolled back
        └── publish  tayara.support.chat.messages.v1
                 │
      ┌──────────┴────────────┐
      │                       │
 tayara-support-fanout   tayara-support-push      (separate consumer groups)
      │                       │
 SSE to this instance    for each recipient:
                             1. presence (service/support/presence.go)
                                  online + known → skip (SSE already delivered)
                             2. render engage notification template
                             3. write engage_notification row (idempotent code)  ← always
                             4. SSE `notification.created` to the actor          ← always
                             5. no device token? stop here (in-app only)
                             6. Redis collapse window (best effort)
                             7. FCM to every device token
                                  support_push_token  (all actors)
                                  engage_device_token (customers)
                             8. append support_push_dispatch row + log line
```

Rules kept from the original plan:

* presence is only ever read through `service/support/presence.go`;
* a push failure never fails the sender's request and never blocks the consumer;
* Redis being down means "unknown presence" and no collapsing — never a lost message;
* the message row is committed before anything is pushed.

---

## 2. Where device tokens come from

`service/support/push/tokens.go` merges two registries:

| Source | Actors | Registered by |
| --- | --- | --- |
| `support_push_token` (append-only) | customer, support, quality, admin | `POST /api/v1/support/push-tokens` |
| `engage_device_token` (`is_active = true`) | **customer only** | existing `POST /api/v1/engage/devices` |

`engage_device_token.user_id` is a `bx_user_profile.id`, which is exactly a support customer's
`Actor.ID`. Staff ids are `sys_admin_profile` ids, and the two id spaces can collide, so staff
tokens are never looked up in `engage_device_token` — a wrong match would push one person's
support chat to another person. Staff use `/api/v1/support/push-tokens`.

Both sources are deduplicated by token value; a token is revoked once (append-only row) when FCM
reports it invalid.

A device token is optional. Every recipient that is not known-online gets the
`engage_notification` row and the real-time `notification.created` frame whether or not a token
exists; only the FCM call (and therefore the collapse window and the `support_push_dispatch` row)
needs a token. A user with no registered device still sees the notification in the app.

---

## 3. The notification template (what it looks like)

Pushes are rendered through the engage module, so the template is an ordinary
`engage_notification_template` row:

| Column | Value for support chat |
| --- | --- |
| `event_type` | `support.chat.message` |
| `channel` | `push` |
| `subject` | templates for the title, e.g. `Tayara · {{title}}` |
| `body` | template for the body, e.g. `New reply — {{body}}` |
| `is_active` | `true` |

`{{title}}` and `{{body}}` expand to the generated ticket subject and role-prefixed preview, so a
template can wrap them without losing the content. An empty column keeps the generated value; no
active template means the generated value is used as-is.

Seeded default (no-op, safe):

```json
{
  "eventType": "support.chat.message",
  "channel": "push",
  "subject": "{{title}}",
  "body": "{{body}}",
  "isActive": true
}
```

Generated values before the template:

* **title** — the ticket subject, sanitized and truncated to `support.push.max-title-bytes` (60).
* **body** — `Customer: …` / `Support: …` + `SanitizeChatText(preview)`, truncated to
  `support.push.max-preview-bytes` (140); an attachment-only message becomes `📎 Attachment`.
* **data** — `event_type, conversation_id, ticket_id, message_uuid, seq`.

Resulting FCM payload:

```json
{
  "token": "<device token>",
  "notification": { "title": "Tayara · Where is my refund?", "body": "New reply — Customer: hello" },
  "data": {
    "event_type": "message.created",
    "conversation_id": "12",
    "ticket_id": "7",
    "message_uuid": "0192f3…",
    "seq": "41"
  }
}
```

Staff rooted in `support.push.silent-for-roles` get a **data-only** (silent) message when presence
is *unknown*; customers always get a visible notification, and a definitively offline user always
gets a visible one.

Every push also writes an `engage_notification` row (`channel = push`, status
`pending → sent|failed`) whose code is deterministic:

```
NT- + upper(sha256(message_uuid + "|" + "<actor_type>:<actor_id>")[:24])
```

The unique index on `notification_code` makes the log idempotent under Kafka redelivery. The
`support_push_dispatch` table stays the per-(message, recipient, device) attempt ledger.

---

## 4. Real-time notifications

`GET /api/v1/support/notifications/stream` (SSE, X-token or S-token) is the in-app half of the same
pipeline. Frames:

```
event: connected
data: {"ok":true}

event: notification.created
data: {"notification_id":31,"title":"Where is my refund?","body":"Customer: hello",
       "data":{"conversation_id":"12","ticket_id":"7","message_uuid":"0192f3…","seq":"41"},
       "silent":false}
```

A recipient already connected to a conversation stream is skipped by the push path — that SSE
frame *is* their delivery. The notification stream covers an app that is open but not subscribed
to the conversation, and keeps the notification list current without polling.

---

## 5. HTTP surface added

| Method | Path | Purpose |
| --- | --- | --- |
| `POST` | `/api/v1/support/push-tokens` | register/refresh a device token for the caller |
| `DELETE` | `/api/v1/support/push-tokens/:platform` | append revocation rows |
| `GET` | `/api/v1/support/notifications/stream` | real-time `notification.created` frames |

`POST /api/v1/engage/devices` keeps working unchanged and its tokens are pushed to as well.

---

## 6. Config and toggles

```yaml
support:
  push:
    enabled: false                 # config.yaml; release configs set true
    collapse-window-seconds: 30
    max-preview-bytes: 140
    max-title-bytes: 60
    silent-for-roles: [support, quality]
    retry:
      max-attempts: 3
    fcm:
      credentials-file: ""         # documentation only; the SDK reads GOOGLE_APPLICATION_CREDENTIALS
      project-id: ""
```

Runtime override: `base_system_setting` key `support.push_enabled` (section `support`), checked on
every dispatch. The consumer goroutine starts only when YAML `support.push.enabled` **and**
`support.kafka.enabled` are true at boot.

---

## 7. Failure handling

* `support_push_dispatch` is append-only: one row per attempt (`attempt_key =
  idempotency_key:attempt`), failures never updated.
* Bounded in-process retry (capped backoff from `support.kafka.retry`), then one `failed` row.
* A sweeper (`PushServices.RetryFailed`, every 2 minutes) retries failed rows whose attempt budget
  is not exhausted, appending a new row per attempt.
* An FCM-invalid token is revoked (append-only) and never retried.
* Every outcome logs:
  `support push dispatched uuid=… recipient=… channel=fcm ok=…`.

---

## 8. Files

New:

```
config/support_push.go
constants/support_push.go
model/support/support_push_token.go
model/support/support_push_dispatch.go
model/support/request/support_push.go
service/support/push/{consumer,consumer_seam,dispatcher,helpers,notifier,payload,recipients,service,tokens}.go
service/support/pushgate.go
api/v1/support/push.go
service/support/push/*_test.go
docs/support-push-notifications.md
```

Changed:

```
service/engage/notification.go        Render / Record / SetStatusByCode
service/engage/dispatch/fcm.go        DataMessage, SendDataMessage, IsInvalidToken (existing Send untouched)
service/support/presence.go           IsOnline, ClaimPushWindow
service/support/stream/hub.go         per-actor subscriptions
service/support/kafka/consumer.go     NewPushReader, ConsumeWithReader
service/support/{enter,settings}.go   service group, runtime setting allowlist
api/v1/support/{enter.go,push.go}     PushApi
router/support/{enter,support}.go     push + notification routes
initialize/{support,timer,gorm_biz}.go
source/support/init.go                setting seed + append-only triggers
source/engage/init.go                 support chat template seed
config*.yaml                          support.push block
docs/*                                regenerated swagger
```

---

## 9. Verification

Covered by tests (`SQLite in-memory`, faked sender/presence/collapse, no FCM/Redis/Kafka):

* offline recipient → one visible push, `sent` dispatch row;
* online recipient → no push (SSE delivered it);
* unknown presence + staff role → silent push, customer → visible push;
* Kafka redelivery → single push and single notification row;
* collapse window → `collapsed` row, no send;
* invalid token → appended revocation, `failed` row;
* reassignment between publish and consume wins;
* engage device token is used for a customer, and the template wraps title/body.

Not verified here: a live FCM send, a live broker, a live Redis and a real device token. Those
need credentials (`GOOGLE_APPLICATION_CREDENTIALS`), a broker, Redis and `support.push.enabled:
true`.
