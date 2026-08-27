// Copyright (c) 2026 Tayara. All rights reserved.
//
// File: lib/domain/model/response/bx_package_response.dart
// Architecture: Domain Layer - Package Detail Response Models
// Purpose: Models for package detail and reviews API responses

import 'package:json_annotation/json_annotation.dart';

part 'bx_package_response.g.dart';

@JsonSerializable()
class BxPackageDetailResponse {
  @JsonKey(name: 'code')
  final int? code;

  @JsonKey(name: 'msg')
  final String? message;

  @JsonKey(name: 'data')
  final BxPackageDetailData? data;

  BxPackageDetailResponse({this.code, this.message, this.data});

  factory BxPackageDetailResponse.fromJson(Map<String, dynamic> json) =>
      _$BxPackageDetailResponseFromJson(json);

  Map<String, dynamic> toJson() => _$BxPackageDetailResponseToJson(this);
}

@JsonSerializable()
class BxPackageDetailData {
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

  @JsonKey(name: 'description')
  final String? description;

  @JsonKey(name: 'galleryImages')
  final List<String>? galleryImages;

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
  final int? displayPrice;

  @JsonKey(name: 'estimatedPrice')
  final int? estimatedPrice;

  @JsonKey(name: 'discountPercent')
  final int? discountPercent;

  @JsonKey(name: 'availableSeats')
  final int? availableSeats;

  @JsonKey(name: 'nextDepartureDate')
  final String? nextDepartureDate;

  @JsonKey(name: 'status')
  final String? status;

  @JsonKey(name: 'statusTour')
  final String? statusTour;

  @JsonKey(name: 'timeDisplay')
  final String? timeDisplay;

  @JsonKey(name: 'destination')
  final String? destination;

  @JsonKey(name: 'originalPrice')
  final int? originalPrice;

  @JsonKey(name: 'promoTag')
  final String? promoTag;

  @JsonKey(name: 'hotels')
  final List<BxPackageHotel>? hotels;

  @JsonKey(name: 'activities')
  final List<BxPackageActivity>? activities;

  @JsonKey(name: 'addons')
  final List<BxPackageAddon>? addons;

  @JsonKey(name: 'availability')
  final List<BxPackageAvailability>? availability;

  @JsonKey(name: 'requiredFields')
  final List<BxPackageRequiredField>? requiredFields;

  @JsonKey(name: 'documentRequirements')
  final List<BxPackageDocumentRequirement>? documentRequirements;

  @JsonKey(name: 'itineraryDays')
  final List<BxItineraryDay>? itineraryDays;

  @JsonKey(name: 'includes')
  final List<BxPackageInclusion>? includes;

  @JsonKey(name: 'excludes')
  final List<BxPackageExclusion>? excludes;

  @JsonKey(name: 'highlights')
  final List<BxPackageHighlight>? highlights;

  BxPackageDetailData({
    this.id,
    this.packageCode,
    this.agentId,
    this.name,
    this.coverImageURL,
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
    this.statusTour,
    this.timeDisplay,
    this.destination,
    this.originalPrice,
    this.promoTag,
    this.hotels,
    this.activities,
    this.addons,
    this.availability,
    this.requiredFields,
    this.documentRequirements,
    this.itineraryDays,
    this.includes,
    this.excludes,
    this.highlights,
  });

  factory BxPackageDetailData.fromJson(Map<String, dynamic> json) =>
      _$BxPackageDetailDataFromJson(json);

  Map<String, dynamic> toJson() => _$BxPackageDetailDataToJson(this);
}

@JsonSerializable()
class BxPackageHotel {
  @JsonKey(name: 'id')
  final int? id;

  @JsonKey(name: 'name')
  final String? name;

  @JsonKey(name: 'rating')
  final String? rating;

  @JsonKey(name: 'location')
  final String? location;

  BxPackageHotel({this.id, this.name, this.rating, this.location});

  factory BxPackageHotel.fromJson(Map<String, dynamic> json) =>
      _$BxPackageHotelFromJson(json);

  Map<String, dynamic> toJson() => _$BxPackageHotelToJson(this);
}

@JsonSerializable()
class BxPackageActivity {
  @JsonKey(name: 'id')
  final int? id;

  @JsonKey(name: 'name')
  final String? name;

  @JsonKey(name: 'description')
  final String? description;

  @JsonKey(name: 'duration')
  final String? duration;

  BxPackageActivity({this.id, this.name, this.description, this.duration});

  factory BxPackageActivity.fromJson(Map<String, dynamic> json) =>
      _$BxPackageActivityFromJson(json);

  Map<String, dynamic> toJson() => _$BxPackageActivityToJson(this);
}

@JsonSerializable()
class BxPackageAddon {
  @JsonKey(name: 'id')
  final int? id;

  @JsonKey(name: 'name')
  final String? name;

  @JsonKey(name: 'description')
  final String? description;

  @JsonKey(name: 'price')
  final int? price;

  BxPackageAddon({this.id, this.name, this.description, this.price});

  factory BxPackageAddon.fromJson(Map<String, dynamic> json) =>
      _$BxPackageAddonFromJson(json);

  Map<String, dynamic> toJson() => _$BxPackageAddonToJson(this);
}

@JsonSerializable()
class BxPackageAvailability {
  @JsonKey(name: 'id')
  final int? id;

  @JsonKey(name: 'startDate')
  final String? startDate;

  @JsonKey(name: 'endDate')
  final String? endDate;

  @JsonKey(name: 'seats')
  final int? seats;

  @JsonKey(name: 'price')
  final int? price;

  BxPackageAvailability({
    this.id,
    this.startDate,
    this.endDate,
    this.seats,
    this.price,
  });

  factory BxPackageAvailability.fromJson(Map<String, dynamic> json) =>
      _$BxPackageAvailabilityFromJson(json);

  Map<String, dynamic> toJson() => _$BxPackageAvailabilityToJson(this);
}

@JsonSerializable()
class BxPackageRequiredField {
  @JsonKey(name: 'id')
  final int? id;

  @JsonKey(name: 'fieldName')
  final String? fieldName;

  @JsonKey(name: 'fieldType')
  final String? fieldType;

  @JsonKey(name: 'isRequired')
  final bool? isRequired;

  BxPackageRequiredField({
    this.id,
    this.fieldName,
    this.fieldType,
    this.isRequired,
  });

  factory BxPackageRequiredField.fromJson(Map<String, dynamic> json) =>
      _$BxPackageRequiredFieldFromJson(json);

  Map<String, dynamic> toJson() => _$BxPackageRequiredFieldToJson(this);
}

@JsonSerializable()
class BxPackageDocumentRequirement {
  @JsonKey(name: 'id')
  final int? id;

  @JsonKey(name: 'documentType')
  final String? documentType;

  @JsonKey(name: 'description')
  final String? description;

  BxPackageDocumentRequirement({this.id, this.documentType, this.description});

  factory BxPackageDocumentRequirement.fromJson(Map<String, dynamic> json) =>
      _$BxPackageDocumentRequirementFromJson(json);

  Map<String, dynamic> toJson() => _$BxPackageDocumentRequirementToJson(this);
}

@JsonSerializable()
class BxItineraryDay {
  @JsonKey(name: 'id')
  final int? id;

  @JsonKey(name: 'dayNumber')
  final int? dayNumber;

  @JsonKey(name: 'title')
  final String? title;

  @JsonKey(name: 'description')
  final String? description;

  @JsonKey(name: 'items')
  final List<BxItineraryItem>? items;

  BxItineraryDay({
    this.id,
    this.dayNumber,
    this.title,
    this.description,
    this.items,
  });

  factory BxItineraryDay.fromJson(Map<String, dynamic> json) =>
      _$BxItineraryDayFromJson(json);

  Map<String, dynamic> toJson() => _$BxItineraryDayToJson(this);
}

@JsonSerializable()
class BxItineraryItem {
  @JsonKey(name: 'id')
  final int? id;

  @JsonKey(name: 'title')
  final String? title;

  @JsonKey(name: 'description')
  final String? description;

  @JsonKey(name: 'sortOrder')
  final int? sortOrder;

  BxItineraryItem({this.id, this.title, this.description, this.sortOrder});

  factory BxItineraryItem.fromJson(Map<String, dynamic> json) =>
      _$BxItineraryItemFromJson(json);

  Map<String, dynamic> toJson() => _$BxItineraryItemToJson(this);
}

@JsonSerializable()
class BxPackageInclusion {
  @JsonKey(name: 'id')
  final int? id;

  @JsonKey(name: 'text')
  final String? text;

  @JsonKey(name: 'sortOrder')
  final int? sortOrder;

  BxPackageInclusion({this.id, this.text, this.sortOrder});

  factory BxPackageInclusion.fromJson(Map<String, dynamic> json) =>
      _$BxPackageInclusionFromJson(json);

  Map<String, dynamic> toJson() => _$BxPackageInclusionToJson(this);
}

@JsonSerializable()
class BxPackageExclusion {
  @JsonKey(name: 'id')
  final int? id;

  @JsonKey(name: 'text')
  final String? text;

  @JsonKey(name: 'sortOrder')
  final int? sortOrder;

  BxPackageExclusion({this.id, this.text, this.sortOrder});

  factory BxPackageExclusion.fromJson(Map<String, dynamic> json) =>
      _$BxPackageExclusionFromJson(json);

  Map<String, dynamic> toJson() => _$BxPackageExclusionToJson(this);
}

@JsonSerializable()
class BxPackageHighlight {
  @JsonKey(name: 'id')
  final int? id;

  @JsonKey(name: 'text')
  final String? text;

  @JsonKey(name: 'sortOrder')
  final int? sortOrder;

  BxPackageHighlight({this.id, this.text, this.sortOrder});

  factory BxPackageHighlight.fromJson(Map<String, dynamic> json) =>
      _$BxPackageHighlightFromJson(json);

  Map<String, dynamic> toJson() => _$BxPackageHighlightToJson(this);
}

// ── Package Reviews ─────────────────────────────────────────────────────────

@JsonSerializable()
class BxPackageReviewsResponse {
  @JsonKey(name: 'code')
  final int? code;

  @JsonKey(name: 'msg')
  final String? message;

  @JsonKey(name: 'data')
  final BxPackageReviewsData? data;

  BxPackageReviewsResponse({this.code, this.message, this.data});

  factory BxPackageReviewsResponse.fromJson(Map<String, dynamic> json) =>
      _$BxPackageReviewsResponseFromJson(json);

  Map<String, dynamic> toJson() => _$BxPackageReviewsResponseToJson(this);
}

@JsonSerializable()
class BxPackageReviewItem {
  @JsonKey(name: 'id')
  final int? id;

  @JsonKey(name: 'bookingId')
  final int? bookingId;

  @JsonKey(name: 'userId')
  final int? userId;

  @JsonKey(name: 'rating')
  final int? rating;

  @JsonKey(name: 'reviewText')
  final String? reviewText;

  @JsonKey(name: 'reviewStatus')
  final String? reviewStatus;

  @JsonKey(name: 'createdAt')
  final String? createdAt;

  BxPackageReviewItem({
    this.id,
    this.bookingId,
    this.userId,
    this.rating,
    this.reviewText,
    this.reviewStatus,
    this.createdAt,
  });

  factory BxPackageReviewItem.fromJson(Map<String, dynamic> json) =>
      _$BxPackageReviewItemFromJson(json);

  Map<String, dynamic> toJson() => _$BxPackageReviewItemToJson(this);
}

// ── Package Reviews Data ─────────────────────────────────────────────────────

@JsonSerializable()
class BxPackageReviewsData {
  @JsonKey(name: 'list')
  final List<BxPackageReviewItem>? list;

  @JsonKey(name: 'total')
  final int? total;

  @JsonKey(name: 'totalPage')
  final int? totalPage;

  @JsonKey(name: 'page')
  final int? page;

  @JsonKey(name: 'pageSize')
  final int? pageSize;

  BxPackageReviewsData({
    this.list,
    this.total,
    this.totalPage,
    this.page,
    this.pageSize,
  });

  factory BxPackageReviewsData.fromJson(Map<String, dynamic> json) =>
      _$BxPackageReviewsDataFromJson(json);

  Map<String, dynamic> toJson() => _$BxPackageReviewsDataToJson(this);
}
