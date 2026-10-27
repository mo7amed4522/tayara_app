// File: lib/domain/model/response/bx_agent_profile_details_response.dart
// Architecture: Domain Layer - Response Model
// Purpose: Model for agent profile details response (agent info, packages,
//          reviews, pagination metadata, top destination)

import 'package:json_annotation/json_annotation.dart';

part 'bx_agent_profile_details_response.g.dart';

@JsonSerializable()
class BxAgentProfileDetailsResponse {
  @JsonKey(name: 'code')
  final int code;

  @JsonKey(name: 'data')
  final BxAgentProfileDetailsData? data;

  @JsonKey(name: 'msg')
  final String msg;

  BxAgentProfileDetailsResponse({
    required this.code,
    this.data,
    required this.msg,
  });

  factory BxAgentProfileDetailsResponse.fromJson(Map<String, dynamic> json) =>
      _$BxAgentProfileDetailsResponseFromJson(json);

  Map<String, dynamic> toJson() => _$BxAgentProfileDetailsResponseToJson(this);
}

@JsonSerializable()
class BxAgentProfileDetailsData {
  @JsonKey(name: 'agent')
  final BxAgentProfileAgent? agent;

  @JsonKey(name: 'packages')
  final List<BxAgentProfilePackage> packages;

  @JsonKey(name: 'packagesTotal')
  final int packagesTotal;

  @JsonKey(name: 'reviews')
  final List<BxAgentProfileReview> reviews;

  @JsonKey(name: 'reviewAvgRating')
  final double? reviewAvgRating;

  @JsonKey(name: 'reviewTotal')
  final int reviewTotal;

  @JsonKey(name: 'topDestination')
  final String? topDestination;

  BxAgentProfileDetailsData({
    this.agent,
    required this.packages,
    required this.packagesTotal,
    required this.reviews,
    this.reviewAvgRating,
    required this.reviewTotal,
    this.topDestination,
  });

  factory BxAgentProfileDetailsData.fromJson(Map<String, dynamic> json) =>
      _$BxAgentProfileDetailsDataFromJson(json);

  Map<String, dynamic> toJson() => _$BxAgentProfileDetailsDataToJson(this);
}

// ─── Agent ────────────────────────────────────────────────────────────────────

@JsonSerializable()
class BxAgentProfileAgent {
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

  @JsonKey(name: 'countryId')
  final int? countryId;

  @JsonKey(name: 'cityId')
  final int? cityId;

  @JsonKey(name: 'country')
  final String? country;

  @JsonKey(name: 'city')
  final String? city;

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
  final int? commissionPercent;

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

  @JsonKey(name: 'trustedCount')
  final int? trustedCount;

  @JsonKey(name: 'statusLabel')
  final String? statusLabel;

  BxAgentProfileAgent({
    this.id,
    this.companyName,
    this.responsibleName,
    this.headerImg,
    this.phoneCountryCode,
    this.phone,
    this.businessEmail,
    this.countryId,
    this.cityId,
    this.country,
    this.city,
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
    this.trustedCount,
    this.statusLabel,
  });

  factory BxAgentProfileAgent.fromJson(Map<String, dynamic> json) =>
      _$BxAgentProfileAgentFromJson(json);

  Map<String, dynamic> toJson() => _$BxAgentProfileAgentToJson(this);
}

// ─── Package ──────────────────────────────────────────────────────────────────

@JsonSerializable()
class BxAgentProfilePackage {
  @JsonKey(name: 'id')
  final int? id;

  @JsonKey(name: 'packageCode')
  final String? packageCode;

  @JsonKey(name: 'agentId')
  final int? agentId;

  @JsonKey(name: 'type')
  final String? type;

  @JsonKey(name: 'name')
  final String? name;

  @JsonKey(name: 'coverImageURL')
  final String? coverImageUrl;

  @JsonKey(name: 'description')
  final String? description;

  @JsonKey(name: 'galleryImages')
  final BxAgentProfileGalleryImages? galleryImages;

  @JsonKey(name: 'destinationCountryId')
  final int? destinationCountryId;

  @JsonKey(name: 'cityId')
  final int? cityId;

  @JsonKey(name: 'location')
  final String? location;

  @JsonKey(name: 'category')
  final String? category;

  @JsonKey(name: 'daysDuration')
  final int? daysDuration;

  @JsonKey(name: 'availabilityType')
  final String? availabilityType;

  @JsonKey(name: 'displayPrice')
  final num? displayPrice;

  @JsonKey(name: 'estimatedPrice')
  final num? estimatedPrice;

  @JsonKey(name: 'discountPercent')
  final num? discountPercent;

  @JsonKey(name: 'availableSeats')
  final int? availableSeats;

  @JsonKey(name: 'nextDepartureDate')
  final String? nextDepartureDate;

  @JsonKey(name: 'status')
  final String? status;

  @JsonKey(name: 'flagIssueType')
  final String? flagIssueType;

  @JsonKey(name: 'flagDetails')
  final String? flagDetails;

  @JsonKey(name: 'adminNote')
  final String? adminNote;

  @JsonKey(name: 'submittedAt')
  final String? submittedAt;

  @JsonKey(name: 'approvedBy')
  final int? approvedBy;

  @JsonKey(name: 'approvedAt')
  final String? approvedAt;

  @JsonKey(name: 'statusTour')
  final String? statusTour;

  @JsonKey(name: 'timeDisplay')
  final String? timeDisplay;

  @JsonKey(name: 'destination')
  final String? destination;

  @JsonKey(name: 'originalPrice')
  final num? originalPrice;

  @JsonKey(name: 'promoTag')
  final String? promoTag;

  @JsonKey(name: 'CreatedAt')
  final String? createdAt;

  @JsonKey(name: 'UpdatedAt')
  final String? updatedAt;

  @JsonKey(name: 'agentName')
  final String? agentName;

  @JsonKey(name: 'agentLogo')
  final String? agentLogo;

  @JsonKey(name: 'salePrice')
  final num? salePrice;

  @JsonKey(name: 'rating')
  final double? rating;

  @JsonKey(name: 'reviewCount')
  final int? reviewCount;

  @JsonKey(name: 'seatsLeft')
  final int? seatsLeft;

  @JsonKey(name: 'departureDate')
  final String? departureDate;

  @JsonKey(name: 'nextDepartureAt')
  final String? nextDepartureAt;

  BxAgentProfilePackage({
    this.id,
    this.packageCode,
    this.agentId,
    this.type,
    this.name,
    this.coverImageUrl,
    this.description,
    this.galleryImages,
    this.destinationCountryId,
    this.cityId,
    this.location,
    this.category,
    this.daysDuration,
    this.availabilityType,
    this.displayPrice,
    this.estimatedPrice,
    this.discountPercent,
    this.availableSeats,
    this.nextDepartureDate,
    this.status,
    this.flagIssueType,
    this.flagDetails,
    this.adminNote,
    this.submittedAt,
    this.approvedBy,
    this.approvedAt,
    this.statusTour,
    this.timeDisplay,
    this.destination,
    this.originalPrice,
    this.promoTag,
    this.createdAt,
    this.updatedAt,
    this.agentName,
    this.agentLogo,
    this.salePrice,
    this.rating,
    this.reviewCount,
    this.seatsLeft,
    this.departureDate,
    this.nextDepartureAt,
  });

  factory BxAgentProfilePackage.fromJson(Map<String, dynamic> json) =>
      _$BxAgentProfilePackageFromJson(json);

  Map<String, dynamic> toJson() => _$BxAgentProfilePackageToJson(this);
}

@JsonSerializable()
class BxAgentProfileGalleryImages {
  @JsonKey(name: 'images')
  final List<String> images;

  BxAgentProfileGalleryImages({required this.images});

  factory BxAgentProfileGalleryImages.fromJson(Map<String, dynamic> json) =>
      _$BxAgentProfileGalleryImagesFromJson(json);

  Map<String, dynamic> toJson() => _$BxAgentProfileGalleryImagesToJson(this);
}

// ─── Review ───────────────────────────────────────────────────────────────────

@JsonSerializable()
class BxAgentProfileReview {
  @JsonKey(name: 'id')
  final int? id;

  @JsonKey(name: 'userName')
  final String? userName;

  @JsonKey(name: 'userAvatar')
  final String? userAvatar;

  @JsonKey(name: 'rating')
  final double? rating;

  @JsonKey(name: 'reviewText')
  final String? reviewText;

  @JsonKey(name: 'createdAt')
  final String? createdAt;

  BxAgentProfileReview({
    this.id,
    this.userName,
    this.userAvatar,
    this.rating,
    this.reviewText,
    this.createdAt,
  });

  factory BxAgentProfileReview.fromJson(Map<String, dynamic> json) =>
      _$BxAgentProfileReviewFromJson(json);

  Map<String, dynamic> toJson() => _$BxAgentProfileReviewToJson(this);
}
