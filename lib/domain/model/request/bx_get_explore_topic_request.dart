// File: lib/domain/model/request/bx_get_explore_topic_request.dart
// Architecture: Domain Layer - Request Model
// Purpose: Model for fetching explore topics with pagination

import 'package:json_annotation/json_annotation.dart';

part 'bx_get_explore_topic_request.g.dart';

@JsonSerializable()
class BxGetExploreTopicRequest {
  @JsonKey(name: 'page')
  final int page;

  @JsonKey(name: 'pageSize')
  final int pageSize;

  BxGetExploreTopicRequest({required this.page, required this.pageSize});

  factory BxGetExploreTopicRequest.fromJson(Map<String, dynamic> json) =>
      _$BxGetExploreTopicRequestFromJson(json);

  Map<String, dynamic> toJson() => _$BxGetExploreTopicRequestToJson(this);
}
