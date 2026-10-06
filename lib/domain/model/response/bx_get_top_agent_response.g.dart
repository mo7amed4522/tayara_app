// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bx_get_top_agent_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BxGetTopAgentResponse _$BxGetTopAgentResponseFromJson(
  Map<String, dynamic> json,
) => BxGetTopAgentResponse(
  code: (json['code'] as num).toInt(),
  data: (json['data'] as List<dynamic>?)
      ?.map((e) => BxGetTopAgent.fromJson(e as Map<String, dynamic>))
      .toList(),
  msg: json['msg'] as String,
);

Map<String, dynamic> _$BxGetTopAgentResponseToJson(
  BxGetTopAgentResponse instance,
) => <String, dynamic>{
  'code': instance.code,
  'data': instance.data,
  'msg': instance.msg,
};

BxGetTopAgent _$BxGetTopAgentFromJson(Map<String, dynamic> json) =>
    BxGetTopAgent(
      id: (json['id'] as num?)?.toInt(),
      companyName: json['companyName'] as String?,
      responsibleName: json['responsibleName'] as String?,
      headerImg: json['headerImg'] as String?,
      phoneCountryCode: json['phoneCountryCode'] as String?,
      phone: json['phone'] as String?,
      businessEmail: json['businessEmail'] as String?,
      country: json['country'] as String?,
      companyAddress: json['companyAddress'] as String?,
      licenseNumber: json['licenseNumber'] as String?,
      status: json['status'] as String?,
      planId: (json['planId'] as num?)?.toInt(),
      shortDescription: json['shortDescription'] as String?,
      longDescription: json['longDescription'] as String?,
      backgroundImage: json['backgroundImage'] as String?,
      trustedTravelersCount: (json['trustedTravelersCount'] as num?)?.toInt(),
      commissionPercent: json['commissionPercent'] as num?,
      slaHours: (json['slaHours'] as num?)?.toInt(),
      approvedBy: (json['approvedBy'] as num?)?.toInt(),
      rejectedReason: json['rejectedReason'] as String?,
      approvedAt: json['approvedAt'] as String?,
      lastLoginAt: json['lastLoginAt'] as String?,
      createdAt: json['CreatedAt'] as String?,
      updatedAt: json['UpdatedAt'] as String?,
      averageRating: (json['averageRating'] as num?)?.toDouble(),
      reviewCount: (json['reviewCount'] as num?)?.toInt(),
    );

Map<String, dynamic> _$BxGetTopAgentToJson(BxGetTopAgent instance) =>
    <String, dynamic>{
      'id': instance.id,
      'companyName': instance.companyName,
      'responsibleName': instance.responsibleName,
      'headerImg': instance.headerImg,
      'phoneCountryCode': instance.phoneCountryCode,
      'phone': instance.phone,
      'businessEmail': instance.businessEmail,
      'country': instance.country,
      'companyAddress': instance.companyAddress,
      'licenseNumber': instance.licenseNumber,
      'status': instance.status,
      'planId': instance.planId,
      'shortDescription': instance.shortDescription,
      'longDescription': instance.longDescription,
      'backgroundImage': instance.backgroundImage,
      'trustedTravelersCount': instance.trustedTravelersCount,
      'commissionPercent': instance.commissionPercent,
      'slaHours': instance.slaHours,
      'approvedBy': instance.approvedBy,
      'rejectedReason': instance.rejectedReason,
      'approvedAt': instance.approvedAt,
      'lastLoginAt': instance.lastLoginAt,
      'CreatedAt': instance.createdAt,
      'UpdatedAt': instance.updatedAt,
      'averageRating': instance.averageRating,
      'reviewCount': instance.reviewCount,
    };
