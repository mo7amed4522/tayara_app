// File: lib/domain/model/response/bx_get_top_deals_response.dart
// Architecture: Domain Layer - Response Model
// Purpose: Model for the top deals list response

import 'package:json_annotation/json_annotation.dart';

part 'bx_get_top_deals_response.g.dart';

@JsonSerializable()
class BxGetTopDealsResponse {
  @JsonKey(name: 'code')
  final int code;

  @JsonKey(name: 'data')
  final BxGetTopDealsData? data;

  @JsonKey(name: 'msg')
  final String msg;

  BxGetTopDealsResponse({required this.code, this.data, required this.msg});

  factory BxGetTopDealsResponse.fromJson(Map<String, dynamic> json) =>
      _$BxGetTopDealsResponseFromJson(json);

  Map<String, dynamic> toJson() => _$BxGetTopDealsResponseToJson(this);
}

@JsonSerializable()
class BxGetTopDealsData {
  @JsonKey(name: 'list')
  final List<BxGetTopDeal> list;

  @JsonKey(name: 'total')
  final int total;

  @JsonKey(name: 'totalPage')
  final int totalPage;

  @JsonKey(name: 'page')
  final int page;

  @JsonKey(name: 'pageSize')
  final int pageSize;

  BxGetTopDealsData({
    required this.list,
    required this.total,
    required this.totalPage,
    required this.page,
    required this.pageSize,
  });

  factory BxGetTopDealsData.fromJson(Map<String, dynamic> json) =>
      _$BxGetTopDealsDataFromJson(json);

  Map<String, dynamic> toJson() => _$BxGetTopDealsDataToJson(this);
}

@JsonSerializable()
class BxGetTopDeal {
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
  final BxGalleryImages? galleryImages;

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

  @JsonKey(name: 'discountPercent')
  final num? discountPercent;

  @JsonKey(name: 'viewCount')
  final int? viewCount;

  BxGetTopDeal({
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
    this.discountPercent,
    this.viewCount,
  });

  factory BxGetTopDeal.fromJson(Map<String, dynamic> json) =>
      _$BxGetTopDealFromJson(json);

  Map<String, dynamic> toJson() => _$BxGetTopDealToJson(this);
}

@JsonSerializable()
class BxGalleryImages {
  @JsonKey(name: 'images')
  final List<String>? images;

  BxGalleryImages({this.images});

  factory BxGalleryImages.fromJson(Map<String, dynamic> json) =>
      _$BxGalleryImagesFromJson(json);

  Map<String, dynamic> toJson() => _$BxGalleryImagesToJson(this);
}
