// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bx_get_destinations_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BxGetDestinationsResponse _$BxGetDestinationsResponseFromJson(
  Map<String, dynamic> json,
) => BxGetDestinationsResponse(
  code: (json['code'] as num).toInt(),
  data: json['data'] == null
      ? null
      : BxGetDestinationsData.fromJson(json['data'] as Map<String, dynamic>),
  msg: json['msg'] as String,
);

Map<String, dynamic> _$BxGetDestinationsResponseToJson(
  BxGetDestinationsResponse instance,
) => <String, dynamic>{
  'code': instance.code,
  'data': instance.data,
  'msg': instance.msg,
};

BxGetDestinationsData _$BxGetDestinationsDataFromJson(
  Map<String, dynamic> json,
) => BxGetDestinationsData(
  list: (json['list'] as List<dynamic>)
      .map((e) => BxGetDestination.fromJson(e as Map<String, dynamic>))
      .toList(),
  total: (json['total'] as num).toInt(),
  totalPage: (json['totalPage'] as num).toInt(),
  page: (json['page'] as num).toInt(),
  pageSize: (json['pageSize'] as num).toInt(),
);

Map<String, dynamic> _$BxGetDestinationsDataToJson(
  BxGetDestinationsData instance,
) => <String, dynamic>{
  'list': instance.list,
  'total': instance.total,
  'totalPage': instance.totalPage,
  'page': instance.page,
  'pageSize': instance.pageSize,
};

BxGetDestination _$BxGetDestinationFromJson(Map<String, dynamic> json) =>
    BxGetDestination(
      id: (json['countryId'] as num?)?.toInt(),
      name: json['countryName'] as String?,
      code: json['countryCode'] as String?,
      packageCount: (json['packageCount'] as num?)?.toInt(),
      minDisplayPrice: (json['minDisplayPrice'] as num?)?.toInt(),
    );

Map<String, dynamic> _$BxGetDestinationToJson(BxGetDestination instance) =>
    <String, dynamic>{
      'countryId': instance.id,
      'countryName': instance.name,
      'countryCode': instance.code,
      'packageCount': instance.packageCount,
      'minDisplayPrice': instance.minDisplayPrice,
    };
