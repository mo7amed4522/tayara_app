// Copyright (c) 2026 Tayara. All rights reserved.
//
// File: lib/domain/model/response/bx_agent_response.dart
// Architecture: Domain Layer - Agent Response Models
// Purpose: Models for agent detail API responses

import 'package:json_annotation/json_annotation.dart';

part 'bx_agent_response.g.dart';

@JsonSerializable()
class BxCustomerAgentDetailResponse {
  @JsonKey(name: 'code')
  final int? code;

  @JsonKey(name: 'msg')
  final String? message;

  @JsonKey(name: 'data')
  final BxCustomerAgentDetailData? data;

  BxCustomerAgentDetailResponse({this.code, this.message, this.data});

  factory BxCustomerAgentDetailResponse.fromJson(Map<String, dynamic> json) =>
      _$BxCustomerAgentDetailResponseFromJson(json);

  Map<String, dynamic> toJson() => _$BxCustomerAgentDetailResponseToJson(this);
}

@JsonSerializable()
class BxCustomerAgentDetailData {
  @JsonKey(name: 'agent')
  final BxCustomerAgentProfile? agent;

  @JsonKey(name: 'packages')
  final List<BxCustomerAgentPackageCard>? packages;

  @JsonKey(name: 'packagesTotal')
  final int? packagesTotal;

  @JsonKey(name: 'reviews')
  final List<BxCustomerAgentReviewItem>? reviews;

  @JsonKey(name: 'reviewAvgRating')
  final double? reviewAvgRating;

  @JsonKey(name: 'reviewTotal')
  final int? reviewTotal;

  @JsonKey(name: 'topDestination')
  final String? topDestination;

  BxCustomerAgentDetailData({
    this.agent,
    this.packages,
    this.packagesTotal,
    this.reviews,
    this.reviewAvgRating,
    this.reviewTotal,
    this.topDestination,
  });

  factory BxCustomerAgentDetailData.fromJson(Map<String, dynamic> json) =>
      _$BxCustomerAgentDetailDataFromJson(json);

  Map<String, dynamic> toJson() => _$BxCustomerAgentDetailDataToJson(this);
}

@JsonSerializable()
class BxCustomerAgentProfile {
  @JsonKey(name: 'id')
  final int? id;

  @JsonKey(name: 'companyName')
  final String? companyName;

  @JsonKey(name: 'headerImg')
  final String? headerImg;

  @JsonKey(name: 'phone')
  final String? phone;

  @JsonKey(name: 'phoneCountryCode')
  final String? phoneCountryCode;

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

  @JsonKey(name: 'averageRating')
  final double? averageRating;

  @JsonKey(name: 'reviewCount')
  final int? reviewCount;

  @JsonKey(name: 'trustedTravelersCount')
  final int? trustedTravelersCount;

  @JsonKey(name: 'statusLabel')
  final String? statusLabel;

  @JsonKey(name: 'shortDescription')
  final String? shortDescription;

  @JsonKey(name: 'longDescription')
  final String? longDescription;

  @JsonKey(name: 'backgroundImage')
  final String? backgroundImage;

  BxCustomerAgentProfile({
    this.id,
    this.companyName,
    this.headerImg,
    this.phone,
    this.phoneCountryCode,
    this.businessEmail,
    this.country,
    this.companyAddress,
    this.licenseNumber,
    this.status,
    this.averageRating,
    this.reviewCount,
    this.trustedTravelersCount,
    this.statusLabel,
    this.shortDescription,
    this.longDescription,
    this.backgroundImage,
  });

  factory BxCustomerAgentProfile.fromJson(Map<String, dynamic> json) =>
      _$BxCustomerAgentProfileFromJson(json);

  Map<String, dynamic> toJson() => _$BxCustomerAgentProfileToJson(this);
}

@JsonSerializable()
class BxCustomerAgentPackageCard {
  @JsonKey(name: 'id')
  final int? id;

  @JsonKey(name: 'packageCode')
  final String? packageCode;

  @JsonKey(name: 'agentId')
  final int? agentId;

  @JsonKey(name: 'name')
  final String? name;

  @JsonKey(name: 'coverImageURL')
  final String? coverImageURL;

  @JsonKey(name: 'category')
  final String? category;

  @JsonKey(name: 'daysDuration')
  final int? daysDuration;

  @JsonKey(name: 'displayPrice')
  final int? displayPrice;

  @JsonKey(name: 'discountPercent')
  final int? discountPercent;

  @JsonKey(name: 'salePrice')
  final int? salePrice;

  @JsonKey(name: 'rating')
  final double? rating;

  @JsonKey(name: 'reviewCount')
  final int? reviewCount;

  @JsonKey(name: 'seatsLeft')
  final int? seatsLeft;

  @JsonKey(name: 'departureDate')
  final String? departureDate;

  @JsonKey(name: 'status')
  final String? status;

  @JsonKey(name: 'agentName')
  final String? agentName;

  @JsonKey(name: 'agentLogo')
  final String? agentLogo;

  BxCustomerAgentPackageCard({
    this.id,
    this.packageCode,
    this.agentId,
    this.name,
    this.coverImageURL,
    this.category,
    this.daysDuration,
    this.displayPrice,
    this.discountPercent,
    this.salePrice,
    this.rating,
    this.reviewCount,
    this.seatsLeft,
    this.departureDate,
    this.status,
    this.agentName,
    this.agentLogo,
  });

  factory BxCustomerAgentPackageCard.fromJson(Map<String, dynamic> json) =>
      _$BxCustomerAgentPackageCardFromJson(json);

  Map<String, dynamic> toJson() => _$BxCustomerAgentPackageCardToJson(this);
}

@JsonSerializable()
class BxCustomerAgentReviewItem {
  @JsonKey(name: 'id')
  final int? id;

  @JsonKey(name: 'userName')
  final String? userName;

  @JsonKey(name: 'userAvatar')
  final String? userAvatar;

  @JsonKey(name: 'rating')
  final int? rating;

  @JsonKey(name: 'reviewText')
  final String? reviewText;

  @JsonKey(name: 'createdAt')
  final String? createdAt;

  BxCustomerAgentReviewItem({
    this.id,
    this.userName,
    this.userAvatar,
    this.rating,
    this.reviewText,
    this.createdAt,
  });

  factory BxCustomerAgentReviewItem.fromJson(Map<String, dynamic> json) =>
      _$BxCustomerAgentReviewItemFromJson(json);

  Map<String, dynamic> toJson() => _$BxCustomerAgentReviewItemToJson(this);
}
