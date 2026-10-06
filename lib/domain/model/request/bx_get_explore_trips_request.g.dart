// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bx_get_explore_trips_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BxGetExploreTripsRequest _$BxGetExploreTripsRequestFromJson(
  Map<String, dynamic> json,
) => BxGetExploreTripsRequest(
  page: (json['page'] as num).toInt(),
  pageSize: (json['pageSize'] as num).toInt(),
  category: json['category'] as String?,
);

Map<String, dynamic> _$BxGetExploreTripsRequestToJson(
  BxGetExploreTripsRequest instance,
) => <String, dynamic>{
  'page': instance.page,
  'pageSize': instance.pageSize,
  'category': instance.category,
};
