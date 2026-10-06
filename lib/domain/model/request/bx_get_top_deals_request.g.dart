// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bx_get_top_deals_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BxGetTopDealsRequest _$BxGetTopDealsRequestFromJson(
  Map<String, dynamic> json,
) => BxGetTopDealsRequest(
  page: (json['page'] as num).toInt(),
  pageSize: (json['pageSize'] as num).toInt(),
);

Map<String, dynamic> _$BxGetTopDealsRequestToJson(
  BxGetTopDealsRequest instance,
) => <String, dynamic>{'page': instance.page, 'pageSize': instance.pageSize};
