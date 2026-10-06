// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bx_active_top_banner_ads_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BxActiveTopBannerAdsResponse _$BxActiveTopBannerAdsResponseFromJson(
  Map<String, dynamic> json,
) => BxActiveTopBannerAdsResponse(
  code: (json['code'] as num).toInt(),
  data: json['data'] == null
      ? null
      : BxActiveTopBannerAdsData.fromJson(json['data'] as Map<String, dynamic>),
  msg: json['msg'] as String,
);

Map<String, dynamic> _$BxActiveTopBannerAdsResponseToJson(
  BxActiveTopBannerAdsResponse instance,
) => <String, dynamic>{
  'code': instance.code,
  'data': instance.data,
  'msg': instance.msg,
};

BxActiveTopBannerAdsData _$BxActiveTopBannerAdsDataFromJson(
  Map<String, dynamic> json,
) => BxActiveTopBannerAdsData(
  list: (json['list'] as List<dynamic>)
      .map((e) => BxActiveTopBannerAd.fromJson(e as Map<String, dynamic>))
      .toList(),
  total: (json['total'] as num).toInt(),
  totalPage: (json['totalPage'] as num).toInt(),
  page: (json['page'] as num).toInt(),
  pageSize: (json['pageSize'] as num).toInt(),
);

Map<String, dynamic> _$BxActiveTopBannerAdsDataToJson(
  BxActiveTopBannerAdsData instance,
) => <String, dynamic>{
  'list': instance.list,
  'total': instance.total,
  'totalPage': instance.totalPage,
  'page': instance.page,
  'pageSize': instance.pageSize,
};

BxActiveTopBannerAd _$BxActiveTopBannerAdFromJson(Map<String, dynamic> json) =>
    BxActiveTopBannerAd(
      id: (json['id'] as num?)?.toInt(),
      adCode: json['adCode'] as String?,
      bannerImageUrl: json['bannerImageURL'] as String?,
      overlayTitle: json['overlayTitle'] as String?,
      overlaySubtitle: json['overlaySubtitle'] as String?,
      ctaLabel: json['ctaLabel'] as String?,
      redirectType: json['redirectType'] as String?,
      targetCountryId: (json['targetCountryId'] as num?)?.toInt(),
      targetAgentId: (json['targetAgentId'] as num?)?.toInt(),
      targetPackageId: (json['targetPackageId'] as num?)?.toInt(),
      createdAt: json['createdAt'] as String?,
    );

Map<String, dynamic> _$BxActiveTopBannerAdToJson(
  BxActiveTopBannerAd instance,
) => <String, dynamic>{
  'id': instance.id,
  'adCode': instance.adCode,
  'bannerImageURL': instance.bannerImageUrl,
  'overlayTitle': instance.overlayTitle,
  'overlaySubtitle': instance.overlaySubtitle,
  'ctaLabel': instance.ctaLabel,
  'redirectType': instance.redirectType,
  'targetCountryId': instance.targetCountryId,
  'targetAgentId': instance.targetAgentId,
  'targetPackageId': instance.targetPackageId,
  'createdAt': instance.createdAt,
};
