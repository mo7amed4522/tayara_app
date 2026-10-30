// File: lib/domain/model/response/bx_get_package_detail_response.dart
// Architecture: Domain Layer - Response Model
// Purpose: Model for the package detail response

import 'package:json_annotation/json_annotation.dart';

part 'bx_get_package_detail_response.g.dart';

@JsonSerializable()
class BxGetPackageDetailResponse {
  @JsonKey(name: 'code')
  final int code;

  @JsonKey(name: 'data')
  final BxGetPackageDetailData? data;

  @JsonKey(name: 'msg')
  final String msg;

  BxGetPackageDetailResponse({
    required this.code,
    this.data,
    required this.msg,
  });

  factory BxGetPackageDetailResponse.fromJson(Map<String, dynamic> json) =>
      _$BxGetPackageDetailResponseFromJson(json);

  Map<String, dynamic> toJson() => _$BxGetPackageDetailResponseToJson(this);
}

@JsonSerializable()
class BxGetPackageDetailData {
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
  final BxPackageGalleryImages? galleryImages;

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
  final int? originalPrice;

  @JsonKey(name: 'promoTag')
  final String? promoTag;

  @JsonKey(name: 'CreatedAt')
  final String? createdAt;

  @JsonKey(name: 'UpdatedAt')
  final String? updatedAt;

  @JsonKey(name: 'availability')
  final List<BxPackageAvailability> availability;

  @JsonKey(name: 'hotels')
  final List<BxPackageHotel> hotels;

  @JsonKey(name: 'activities')
  final List<BxPackageActivity> activities;

  @JsonKey(name: 'addons')
  final List<BxPackageAddon> addons;

  @JsonKey(name: 'requiredFields')
  final List<BxPackageRequiredField> requiredFields;

  @JsonKey(name: 'documentRequirements')
  final List<BxPackageDocumentRequirement> documentRequirements;

  @JsonKey(name: 'itineraryDays')
  final List<BxPackageItineraryDay> itineraryDays;

  @JsonKey(name: 'includes')
  final List<BxPackageInclude> includes;

  @JsonKey(name: 'excludes')
  final List<BxPackageExclude> excludes;

  @JsonKey(name: 'highlights')
  final List<BxPackageHighlight> highlights;

  BxGetPackageDetailData({
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
    this.availability = const [],
    this.hotels = const [],
    this.activities = const [],
    this.addons = const [],
    this.requiredFields = const [],
    this.documentRequirements = const [],
    this.itineraryDays = const [],
    this.includes = const [],
    this.excludes = const [],
    this.highlights = const [],
  });

  factory BxGetPackageDetailData.fromJson(Map<String, dynamic> json) =>
      _$BxGetPackageDetailDataFromJson(json);

  Map<String, dynamic> toJson() => _$BxGetPackageDetailDataToJson(this);
}

@JsonSerializable()
class BxPackageGalleryImages {
  @JsonKey(name: 'images')
  final List<String> images;

  BxPackageGalleryImages({required this.images});

  factory BxPackageGalleryImages.fromJson(Map<String, dynamic> json) =>
      _$BxPackageGalleryImagesFromJson(json);

  Map<String, dynamic> toJson() => _$BxPackageGalleryImagesToJson(this);
}

@JsonSerializable()
class BxPackageAvailability {
  @JsonKey(name: 'id')
  final int? id;

  @JsonKey(name: 'packageId')
  final int? packageId;

  @JsonKey(name: 'startDate')
  final String? startDate;

  @JsonKey(name: 'endDate')
  final String? endDate;

  @JsonKey(name: 'isFixedGroup')
  final bool? isFixedGroup;

  @JsonKey(name: 'maxSeats')
  final int? maxSeats;

  @JsonKey(name: 'notes')
  final String? notes;

  @JsonKey(name: 'CreatedAt')
  final String? createdAt;

  @JsonKey(name: 'UpdatedAt')
  final String? updatedAt;

  BxPackageAvailability({
    this.id,
    this.packageId,
    this.startDate,
    this.endDate,
    this.isFixedGroup,
    this.maxSeats,
    this.notes,
    this.createdAt,
    this.updatedAt,
  });

  factory BxPackageAvailability.fromJson(Map<String, dynamic> json) =>
      _$BxPackageAvailabilityFromJson(json);

  Map<String, dynamic> toJson() => _$BxPackageAvailabilityToJson(this);
}

@JsonSerializable()
class BxPackageHotel {
  @JsonKey(name: 'id')
  final int? id;

  @JsonKey(name: 'packageId')
  final int? packageId;

  @JsonKey(name: 'hotelStars')
  final int? hotelStars;

  @JsonKey(name: 'roomType')
  final String? roomType;

  @JsonKey(name: 'optionName')
  final String? optionName;

  @JsonKey(name: 'pricePerNightEst')
  final int? pricePerNightEst;

  @JsonKey(name: 'includeInPackage')
  final bool? includeInPackage;

  @JsonKey(name: 'nights')
  final int? nights;

  @JsonKey(name: 'sortOrder')
  final int? sortOrder;

  @JsonKey(name: 'CreatedAt')
  final String? createdAt;

  @JsonKey(name: 'UpdatedAt')
  final String? updatedAt;

  BxPackageHotel({
    this.id,
    this.packageId,
    this.hotelStars,
    this.roomType,
    this.optionName,
    this.pricePerNightEst,
    this.includeInPackage,
    this.nights,
    this.sortOrder,
    this.createdAt,
    this.updatedAt,
  });

  factory BxPackageHotel.fromJson(Map<String, dynamic> json) =>
      _$BxPackageHotelFromJson(json);

  Map<String, dynamic> toJson() => _$BxPackageHotelToJson(this);
}

@JsonSerializable()
class BxPackageActivity {
  @JsonKey(name: 'id')
  final int? id;

  @JsonKey(name: 'packageId')
  final int? packageId;

  @JsonKey(name: 'title')
  final String? title;

  @JsonKey(name: 'imageURL')
  final String? imageUrl;

  @JsonKey(name: 'estimatedCost')
  final int? estimatedCost;

  @JsonKey(name: 'includeInPackage')
  final bool? includeInPackage;

  @JsonKey(name: 'sortOrder')
  final int? sortOrder;

  @JsonKey(name: 'CreatedAt')
  final String? createdAt;

  @JsonKey(name: 'UpdatedAt')
  final String? updatedAt;

  BxPackageActivity({
    this.id,
    this.packageId,
    this.title,
    this.imageUrl,
    this.estimatedCost,
    this.includeInPackage,
    this.sortOrder,
    this.createdAt,
    this.updatedAt,
  });

  factory BxPackageActivity.fromJson(Map<String, dynamic> json) =>
      _$BxPackageActivityFromJson(json);

  Map<String, dynamic> toJson() => _$BxPackageActivityToJson(this);
}

@JsonSerializable()
class BxPackageAddon {
  @JsonKey(name: 'id')
  final int? id;

  @JsonKey(name: 'packageId')
  final int? packageId;

  @JsonKey(name: 'addonType')
  final String? addonType;

  @JsonKey(name: 'estimatedPrice')
  final int? estimatedPrice;

  @JsonKey(name: 'priceModel')
  final String? priceModel;

  @JsonKey(name: 'includeInPackage')
  final bool? includeInPackage;

  @JsonKey(name: 'active')
  final bool? active;

  @JsonKey(name: 'CreatedAt')
  final String? createdAt;

  @JsonKey(name: 'UpdatedAt')
  final String? updatedAt;

  BxPackageAddon({
    this.id,
    this.packageId,
    this.addonType,
    this.estimatedPrice,
    this.priceModel,
    this.includeInPackage,
    this.active,
    this.createdAt,
    this.updatedAt,
  });

  factory BxPackageAddon.fromJson(Map<String, dynamic> json) =>
      _$BxPackageAddonFromJson(json);

  Map<String, dynamic> toJson() => _$BxPackageAddonToJson(this);
}

@JsonSerializable()
class BxPackageRequiredField {
  @JsonKey(name: 'id')
  final int? id;

  @JsonKey(name: 'packageId')
  final int? packageId;

  @JsonKey(name: 'fieldCode')
  final String? fieldCode;

  @JsonKey(name: 'isAgentSelectable')
  final bool? isAgentSelectable;

  @JsonKey(name: 'isAdminLocked')
  final bool? isAdminLocked;

  @JsonKey(name: 'isRequired')
  final bool? isRequired;

  @JsonKey(name: 'sortOrder')
  final int? sortOrder;

  @JsonKey(name: 'CreatedAt')
  final String? createdAt;

  @JsonKey(name: 'UpdatedAt')
  final String? updatedAt;

  BxPackageRequiredField({
    this.id,
    this.packageId,
    this.fieldCode,
    this.isAgentSelectable,
    this.isAdminLocked,
    this.isRequired,
    this.sortOrder,
    this.createdAt,
    this.updatedAt,
  });

  factory BxPackageRequiredField.fromJson(Map<String, dynamic> json) =>
      _$BxPackageRequiredFieldFromJson(json);

  Map<String, dynamic> toJson() => _$BxPackageRequiredFieldToJson(this);
}

@JsonSerializable()
class BxPackageDocumentRequirement {
  @JsonKey(name: 'id')
  final int? id;

  @JsonKey(name: 'packageId')
  final int? packageId;

  @JsonKey(name: 'documentTypeId')
  final int? documentTypeId;

  @JsonKey(name: 'isRequired')
  final bool? isRequired;

  @JsonKey(name: 'isOptional')
  final bool? isOptional;

  @JsonKey(name: 'requiredAfter')
  final String? requiredAfter;

  @JsonKey(name: 'isLocked')
  final bool? isLocked;

  @JsonKey(name: 'notes')
  final String? notes;

  @JsonKey(name: 'CreatedAt')
  final String? createdAt;

  @JsonKey(name: 'UpdatedAt')
  final String? updatedAt;

  BxPackageDocumentRequirement({
    this.id,
    this.packageId,
    this.documentTypeId,
    this.isRequired,
    this.isOptional,
    this.requiredAfter,
    this.isLocked,
    this.notes,
    this.createdAt,
    this.updatedAt,
  });

  factory BxPackageDocumentRequirement.fromJson(Map<String, dynamic> json) =>
      _$BxPackageDocumentRequirementFromJson(json);

  Map<String, dynamic> toJson() => _$BxPackageDocumentRequirementToJson(this);
}

@JsonSerializable()
class BxPackageItineraryDay {
  @JsonKey(name: 'id')
  final int? id;

  @JsonKey(name: 'packageId')
  final int? packageId;

  @JsonKey(name: 'dayNumber')
  final int? dayNumber;

  @JsonKey(name: 'title')
  final String? title;

  @JsonKey(name: 'description')
  final String? description;

  @JsonKey(name: 'sortOrder')
  final int? sortOrder;

  @JsonKey(name: 'items')
  final List<BxPackageItineraryItem> items;

  @JsonKey(name: 'CreatedAt')
  final String? createdAt;

  @JsonKey(name: 'UpdatedAt')
  final String? updatedAt;

  BxPackageItineraryDay({
    this.id,
    this.packageId,
    this.dayNumber,
    this.title,
    this.description,
    this.sortOrder,
    this.items = const [],
    this.createdAt,
    this.updatedAt,
  });

  factory BxPackageItineraryDay.fromJson(Map<String, dynamic> json) =>
      _$BxPackageItineraryDayFromJson(json);

  Map<String, dynamic> toJson() => _$BxPackageItineraryDayToJson(this);
}

@JsonSerializable()
class BxPackageItineraryItem {
  @JsonKey(name: 'id')
  final int? id;

  @JsonKey(name: 'itineraryDayId')
  final int? itineraryDayId;

  @JsonKey(name: 'time')
  final String? time;

  @JsonKey(name: 'title')
  final String? title;

  @JsonKey(name: 'description')
  final String? description;

  @JsonKey(name: 'sortOrder')
  final int? sortOrder;

  @JsonKey(name: 'CreatedAt')
  final String? createdAt;

  @JsonKey(name: 'UpdatedAt')
  final String? updatedAt;

  BxPackageItineraryItem({
    this.id,
    this.itineraryDayId,
    this.time,
    this.title,
    this.description,
    this.sortOrder,
    this.createdAt,
    this.updatedAt,
  });

  factory BxPackageItineraryItem.fromJson(Map<String, dynamic> json) =>
      _$BxPackageItineraryItemFromJson(json);

  Map<String, dynamic> toJson() => _$BxPackageItineraryItemToJson(this);
}

@JsonSerializable()
class BxPackageInclude {
  @JsonKey(name: 'id')
  final int? id;

  @JsonKey(name: 'packageId')
  final int? packageId;

  @JsonKey(name: 'category')
  final String? category;

  @JsonKey(name: 'itemText')
  final String? itemText;

  @JsonKey(name: 'sortOrder')
  final int? sortOrder;

  @JsonKey(name: 'CreatedAt')
  final String? createdAt;

  @JsonKey(name: 'UpdatedAt')
  final String? updatedAt;

  BxPackageInclude({
    this.id,
    this.packageId,
    this.category,
    this.itemText,
    this.sortOrder,
    this.createdAt,
    this.updatedAt,
  });

  factory BxPackageInclude.fromJson(Map<String, dynamic> json) =>
      _$BxPackageIncludeFromJson(json);

  Map<String, dynamic> toJson() => _$BxPackageIncludeToJson(this);
}

@JsonSerializable()
class BxPackageExclude {
  @JsonKey(name: 'id')
  final int? id;

  @JsonKey(name: 'packageId')
  final int? packageId;

  @JsonKey(name: 'itemText')
  final String? itemText;

  @JsonKey(name: 'sortOrder')
  final int? sortOrder;

  @JsonKey(name: 'CreatedAt')
  final String? createdAt;

  @JsonKey(name: 'UpdatedAt')
  final String? updatedAt;

  BxPackageExclude({
    this.id,
    this.packageId,
    this.itemText,
    this.sortOrder,
    this.createdAt,
    this.updatedAt,
  });

  factory BxPackageExclude.fromJson(Map<String, dynamic> json) =>
      _$BxPackageExcludeFromJson(json);

  Map<String, dynamic> toJson() => _$BxPackageExcludeToJson(this);
}

@JsonSerializable()
class BxPackageHighlight {
  @JsonKey(name: 'id')
  final int? id;

  @JsonKey(name: 'packageId')
  final int? packageId;

  @JsonKey(name: 'name')
  final String? name;

  @JsonKey(name: 'iconURL')
  final String? iconUrl;

  @JsonKey(name: 'sortOrder')
  final int? sortOrder;

  @JsonKey(name: 'CreatedAt')
  final String? createdAt;

  @JsonKey(name: 'UpdatedAt')
  final String? updatedAt;

  BxPackageHighlight({
    this.id,
    this.packageId,
    this.name,
    this.iconUrl,
    this.sortOrder,
    this.createdAt,
    this.updatedAt,
  });

  factory BxPackageHighlight.fromJson(Map<String, dynamic> json) =>
      _$BxPackageHighlightFromJson(json);

  Map<String, dynamic> toJson() => _$BxPackageHighlightToJson(this);
}
