// File: lib/domain/model/response/bx_get_recommended_for_customer_response.dart
// Architecture: Domain Layer - Response Model
// Purpose: Model for the recommended-for-customer packages response

import 'package:json_annotation/json_annotation.dart';

part 'bx_get_recommended_for_customer_response.g.dart';

@JsonSerializable()
class BxGetRecommendedForCustomerResponse {
  @JsonKey(name: 'code')
  final int code;

  @JsonKey(name: 'data')
  final List<BxRecommendedForCustomerPackage>? data;

  @JsonKey(name: 'msg')
  final String? msg;

  BxGetRecommendedForCustomerResponse({
    required this.code,
    this.data,
    this.msg,
  });

  factory BxGetRecommendedForCustomerResponse.fromJson(
    Map<String, dynamic> json,
  ) => _$BxGetRecommendedForCustomerResponseFromJson(json);

  Map<String, dynamic> toJson() =>
      _$BxGetRecommendedForCustomerResponseToJson(this);
}

@JsonSerializable()
class BxRecommendedForCustomerPackage {
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
  final BxRecommendedGalleryImages? galleryImages;

  @JsonKey(name: 'destinationCountryId')
  final int? destinationCountryId;

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

  @JsonKey(name: 'rating')
  final double? rating;

  @JsonKey(name: 'reviewCount')
  final int? reviewCount;

  @JsonKey(name: 'viewCount')
  final int? viewCount;

  @JsonKey(name: 'wishlisted')
  final bool? wishlisted;

  BxRecommendedForCustomerPackage({
    this.id,
    this.packageCode,
    this.agentId,
    this.type,
    this.name,
    this.coverImageUrl,
    this.description,
    this.galleryImages,
    this.destinationCountryId,
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
    this.rating,
    this.reviewCount,
    this.viewCount,
    this.wishlisted,
  });

  factory BxRecommendedForCustomerPackage.fromJson(Map<String, dynamic> json) =>
      _$BxRecommendedForCustomerPackageFromJson(json);

  Map<String, dynamic> toJson() =>
      _$BxRecommendedForCustomerPackageToJson(this);
}

@JsonSerializable()
class BxRecommendedGalleryImages {
  @JsonKey(name: 'images')
  final List<String>? images;

  BxRecommendedGalleryImages({this.images});

  factory BxRecommendedGalleryImages.fromJson(Map<String, dynamic> json) =>
      _$BxRecommendedGalleryImagesFromJson(json);

  Map<String, dynamic> toJson() => _$BxRecommendedGalleryImagesToJson(this);
}
