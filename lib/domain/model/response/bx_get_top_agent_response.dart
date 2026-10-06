// File: lib/domain/model/response/bx_get_top_agent_response.dart
// Architecture: Domain Layer - Response Model
// Purpose: Model for the top agents list response

import 'package:json_annotation/json_annotation.dart';

part 'bx_get_top_agent_response.g.dart';

@JsonSerializable()
class BxGetTopAgentResponse {
  @JsonKey(name: 'code')
  final int code;

  @JsonKey(name: 'data')
  final List<BxGetTopAgent>? data;

  @JsonKey(name: 'msg')
  final String msg;

  BxGetTopAgentResponse({required this.code, this.data, required this.msg});

  factory BxGetTopAgentResponse.fromJson(Map<String, dynamic> json) =>
      _$BxGetTopAgentResponseFromJson(json);

  Map<String, dynamic> toJson() => _$BxGetTopAgentResponseToJson(this);
}

@JsonSerializable()
class BxGetTopAgent {
  @JsonKey(name: 'id')
  final int? id;

  @JsonKey(name: 'companyName')
  final String? companyName;

  @JsonKey(name: 'responsibleName')
  final String? responsibleName;

  @JsonKey(name: 'headerImg')
  final String? headerImg;

  @JsonKey(name: 'phoneCountryCode')
  final String? phoneCountryCode;

  @JsonKey(name: 'phone')
  final String? phone;

  @JsonKey(name: 'businessEmail')
  final String? businessEmail;

  @JsonKey(name: 'country')
  final String? country;

  @JsonKey(name: 'companyAddress')
  final String? companyAddress;

  @JsonKey(name: 'licenseNumber')
  final String? licenseNumber;

  @JsonKey(name: 'status')
  final String? status;

  @JsonKey(name: 'planId')
  final int? planId;

  @JsonKey(name: 'shortDescription')
  final String? shortDescription;

  @JsonKey(name: 'longDescription')
  final String? longDescription;

  @JsonKey(name: 'backgroundImage')
  final String? backgroundImage;

  @JsonKey(name: 'trustedTravelersCount')
  final int? trustedTravelersCount;

  @JsonKey(name: 'commissionPercent')
  final num? commissionPercent;

  @JsonKey(name: 'slaHours')
  final int? slaHours;

  @JsonKey(name: 'approvedBy')
  final int? approvedBy;

  @JsonKey(name: 'rejectedReason')
  final String? rejectedReason;

  @JsonKey(name: 'approvedAt')
  final String? approvedAt;

  @JsonKey(name: 'lastLoginAt')
  final String? lastLoginAt;

  @JsonKey(name: 'CreatedAt')
  final String? createdAt;

  @JsonKey(name: 'UpdatedAt')
  final String? updatedAt;

  @JsonKey(name: 'averageRating')
  final double? averageRating;

  @JsonKey(name: 'reviewCount')
  final int? reviewCount;

  BxGetTopAgent({
    this.id,
    this.companyName,
    this.responsibleName,
    this.headerImg,
    this.phoneCountryCode,
    this.phone,
    this.businessEmail,
    this.country,
    this.companyAddress,
    this.licenseNumber,
    this.status,
    this.planId,
    this.shortDescription,
    this.longDescription,
    this.backgroundImage,
    this.trustedTravelersCount,
    this.commissionPercent,
    this.slaHours,
    this.approvedBy,
    this.rejectedReason,
    this.approvedAt,
    this.lastLoginAt,
    this.createdAt,
    this.updatedAt,
    this.averageRating,
    this.reviewCount,
  });

  factory BxGetTopAgent.fromJson(Map<String, dynamic> json) =>
      _$BxGetTopAgentFromJson(json);

  Map<String, dynamic> toJson() => _$BxGetTopAgentToJson(this);
}
