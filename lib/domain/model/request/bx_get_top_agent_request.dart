// File: lib/domain/model/request/bx_get_top_agent_request.dart
// Architecture: Domain Layer - Request Model
// Purpose: Model for fetching top agents with a limit

import 'package:json_annotation/json_annotation.dart';

part 'bx_get_top_agent_request.g.dart';

@JsonSerializable()
class BxGetTopAgentRequest {
  @JsonKey(name: 'limit')
  final int limit;

  BxGetTopAgentRequest({required this.limit});

  factory BxGetTopAgentRequest.fromJson(Map<String, dynamic> json) =>
      _$BxGetTopAgentRequestFromJson(json);

  Map<String, dynamic> toJson() => _$BxGetTopAgentRequestToJson(this);
}
