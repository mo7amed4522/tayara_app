// File: lib/domain/model/response/bx_get_explore_topic_response.dart
// Architecture: Domain Layer - Response Model
// Purpose: Model for the explore topics list response

import 'package:json_annotation/json_annotation.dart';

part 'bx_get_explore_topic_response.g.dart';

@JsonSerializable()
class BxGetExploreTopicResponse {
  @JsonKey(name: 'code')
  final int code;

  @JsonKey(name: 'data')
  final BxGetExploreTopicData? data;

  @JsonKey(name: 'msg')
  final String msg;

  BxGetExploreTopicResponse({required this.code, this.data, required this.msg});

  factory BxGetExploreTopicResponse.fromJson(Map<String, dynamic> json) =>
      _$BxGetExploreTopicResponseFromJson(json);

  Map<String, dynamic> toJson() => _$BxGetExploreTopicResponseToJson(this);
}

@JsonSerializable()
class BxGetExploreTopicData {
  @JsonKey(name: 'total')
  final int total;

  @JsonKey(name: 'page')
  final int page;

  @JsonKey(name: 'pageSize')
  final int pageSize;

  @JsonKey(name: 'totalPage')
  final int totalPage;

  @JsonKey(name: 'data')
  final List<BxExploreTopic> list;

  BxGetExploreTopicData({
    required this.total,
    required this.page,
    required this.pageSize,
    required this.totalPage,
    required this.list,
  });

  factory BxGetExploreTopicData.fromJson(Map<String, dynamic> json) =>
      _$BxGetExploreTopicDataFromJson(json);

  Map<String, dynamic> toJson() => _$BxGetExploreTopicDataToJson(this);
}

@JsonSerializable()
class BxExploreTopic {
  @JsonKey(name: 'id')
  final int? id;

  @JsonKey(name: 'code')
  final String? code;

  @JsonKey(name: 'name')
  final String? name;

  @JsonKey(name: 'nameAr')
  final String? nameAr;

  @JsonKey(name: 'description')
  final String? description;

  @JsonKey(name: 'imageUrl')
  final String? imageUrl;

  @JsonKey(name: 'iconUrl')
  final String? iconUrl;

  @JsonKey(name: 'packageCount')
  final int? packageCount;

  BxExploreTopic({
    this.id,
    this.code,
    this.name,
    this.nameAr,
    this.description,
    this.imageUrl,
    this.iconUrl,
    this.packageCount,
  });

  factory BxExploreTopic.fromJson(Map<String, dynamic> json) =>
      _$BxExploreTopicFromJson(json);

  Map<String, dynamic> toJson() => _$BxExploreTopicToJson(this);
}
