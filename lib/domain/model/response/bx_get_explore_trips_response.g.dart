// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bx_get_explore_trips_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BxGetExploreTripsResponse _$BxGetExploreTripsResponseFromJson(
  Map<String, dynamic> json,
) => BxGetExploreTripsResponse(
  code: (json['code'] as num).toInt(),
  data: json['data'] == null
      ? null
      : BxGetExploreTripsData.fromJson(json['data'] as Map<String, dynamic>),
  msg: json['msg'] as String,
);

Map<String, dynamic> _$BxGetExploreTripsResponseToJson(
  BxGetExploreTripsResponse instance,
) => <String, dynamic>{
  'code': instance.code,
  'data': instance.data,
  'msg': instance.msg,
};

BxGetExploreTripsData _$BxGetExploreTripsDataFromJson(
  Map<String, dynamic> json,
) => BxGetExploreTripsData(
  list: (json['list'] as List<dynamic>)
      .map((e) => BxGetExploreTrip.fromJson(e as Map<String, dynamic>))
      .toList(),
  total: (json['total'] as num).toInt(),
  totalPage: (json['totalPage'] as num).toInt(),
  page: (json['page'] as num).toInt(),
  pageSize: (json['pageSize'] as num).toInt(),
);

Map<String, dynamic> _$BxGetExploreTripsDataToJson(
  BxGetExploreTripsData instance,
) => <String, dynamic>{
  'list': instance.list,
  'total': instance.total,
  'totalPage': instance.totalPage,
  'page': instance.page,
  'pageSize': instance.pageSize,
};

BxGetExploreTrip _$BxGetExploreTripFromJson(Map<String, dynamic> json) =>
    BxGetExploreTrip(
      id: (json['id'] as num?)?.toInt(),
      packageCode: json['packageCode'] as String?,
      agentId: (json['agentId'] as num?)?.toInt(),
      companyName: json['companyName'] as String?,
      name: json['name'] as String?,
      coverImageUrl: json['coverImageURL'] as String?,
      category: json['category'] as String?,
      daysDuration: (json['daysDuration'] as num?)?.toInt(),
      displayPrice: json['displayPrice'] as num?,
      discountPercent: json['discountPercent'] as num?,
      rating: (json['rating'] as num?)?.toDouble(),
      reviewCount: (json['reviewCount'] as num?)?.toInt(),
      status: json['status'] as String?,
    );

Map<String, dynamic> _$BxGetExploreTripToJson(BxGetExploreTrip instance) =>
    <String, dynamic>{
      'id': instance.id,
      'packageCode': instance.packageCode,
      'agentId': instance.agentId,
      'companyName': instance.companyName,
      'name': instance.name,
      'coverImageURL': instance.coverImageUrl,
      'category': instance.category,
      'daysDuration': instance.daysDuration,
      'displayPrice': instance.displayPrice,
      'discountPercent': instance.discountPercent,
      'rating': instance.rating,
      'reviewCount': instance.reviewCount,
      'status': instance.status,
    };
