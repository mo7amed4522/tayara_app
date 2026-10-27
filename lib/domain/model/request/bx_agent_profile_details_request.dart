// File: lib/domain/model/request/bx_agent_profile_details_request.dart
// Architecture: Domain Layer - Request Model
// Purpose: Model for fetching agent profile details with paginated packages/reviews

import 'package:json_annotation/json_annotation.dart';

part 'bx_agent_profile_details_request.g.dart';

@JsonSerializable()
class BxAgentProfileDetailsRequest {
  @JsonKey(name: 'agentId')
  final int agentId;

  @JsonKey(name: 'page')
  final int page;

  @JsonKey(name: 'pageSize')
  final int pageSize;

  BxAgentProfileDetailsRequest({
    required this.agentId,
    required this.page,
    required this.pageSize,
  });

  factory BxAgentProfileDetailsRequest.fromJson(Map<String, dynamic> json) =>
      _$BxAgentProfileDetailsRequestFromJson(json);

  Map<String, dynamic> toJson() => _$BxAgentProfileDetailsRequestToJson(this);
}
