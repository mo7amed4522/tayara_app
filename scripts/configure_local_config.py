#!/usr/bin/env python3
"""Generate the ignored Xcode settings required by the local .env file."""

from pathlib import Path


ROOT = Path(__file__).resolve().parents[1]
ENV_FILE = ROOT / ".env"
LOCAL_XCCONFIG = ROOT / "ios" / "Flutter" / "Local.xcconfig"


def read_env() -> dict[str, str]:
    if not ENV_FILE.is_file():
        raise SystemExit("Missing .env. Copy .env.example to .env and fill it in.")

    values: dict[str, str] = {}
    for line in ENV_FILE.read_text(encoding="utf-8").splitlines():
        line = line.strip()
        if not line or line.startswith("#") or "=" not in line:
            continue
        key, value = line.split("=", 1)
        values[key.strip()] = value.strip().strip("\"'")
    return values


def main() -> None:
    reversed_client_id = read_env().get("GOOGLE_REVERSED_CLIENT_ID", "")
    if not reversed_client_id:
        raise SystemExit("Missing GOOGLE_REVERSED_CLIENT_ID in .env.")

    LOCAL_XCCONFIG.write_text(
        f"GOOGLE_REVERSED_CLIENT_ID = {reversed_client_id}\n",
        encoding="utf-8",
    )
    print("Generated ios/Flutter/Local.xcconfig from .env.")


if __name__ == "__main__":
    main()
