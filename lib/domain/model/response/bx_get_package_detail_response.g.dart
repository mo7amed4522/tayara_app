// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bx_get_package_detail_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BxGetPackageDetailResponse _$BxGetPackageDetailResponseFromJson(
  Map<String, dynamic> json,
) => BxGetPackageDetailResponse(
  code: (json['code'] as num).toInt(),
  data: json['data'] == null
      ? null
      : BxGetPackageDetailData.fromJson(json['data'] as Map<String, dynamic>),
  msg: json['msg'] as String,
);

Map<String, dynamic> _$BxGetPackageDetailResponseToJson(
  BxGetPackageDetailResponse instance,
) => <String, dynamic>{
  'code': instance.code,
  'data': instance.data,
  'msg': instance.msg,
};

BxGetPackageDetailData _$BxGetPackageDetailDataFromJson(
  Map<String, dynamic> json,
) => BxGetPackageDetailData(
  id: (json['id'] as num?)?.toInt(),
  packageCode: json['packageCode'] as String?,
  agentId: (json['agentId'] as num?)?.toInt(),
  type: json['type'] as String?,
  name: json['name'] as String?,
  coverImageUrl: json['coverImageURL'] as String?,
  description: json['description'] as String?,
  galleryImages: json['galleryImages'] == null
      ? null
      : BxPackageGalleryImages.fromJson(
          json['galleryImages'] as Map<String, dynamic>,
        ),
  destinationCountryId: (json['destinationCountryId'] as num?)?.toInt(),
  cityId: (json['cityId'] as num?)?.toInt(),
  location: json['location'] as String?,
  category: json['category'] as String?,
  daysDuration: (json['daysDuration'] as num?)?.toInt(),
  availabilityType: json['availabilityType'] as String?,
  displayPrice: (json['displayPrice'] as num?)?.toInt(),
  estimatedPrice: (json['estimatedPrice'] as num?)?.toInt(),
  discountPercent: (json['discountPercent'] as num?)?.toInt(),
  availableSeats: (json['availableSeats'] as num?)?.toInt(),
  nextDepartureDate: json['nextDepartureDate'] as String?,
  status: json['status'] as String?,
  flagIssueType: json['flagIssueType'] as String?,
  flagDetails: json['flagDetails'] as String?,
  adminNote: json['adminNote'] as String?,
  submittedAt: json['submittedAt'] as String?,
  approvedBy: (json['approvedBy'] as num?)?.toInt(),
  approvedAt: json['approvedAt'] as String?,
  statusTour: json['statusTour'] as String?,
  timeDisplay: json['timeDisplay'] as String?,
  destination: json['destination'] as String?,
  originalPrice: (json['originalPrice'] as num?)?.toInt(),
  promoTag: json['promoTag'] as String?,
  createdAt: json['CreatedAt'] as String?,
  updatedAt: json['UpdatedAt'] as String?,
  availability:
      (json['availability'] as List<dynamic>?)
          ?.map(
            (e) => BxPackageAvailability.fromJson(e as Map<String, dynamic>),
          )
          .toList() ??
      const [],
  hotels:
      (json['hotels'] as List<dynamic>?)
          ?.map((e) => BxPackageHotel.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
  activities:
      (json['activities'] as List<dynamic>?)
          ?.map((e) => BxPackageActivity.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
  addons:
      (json['addons'] as List<dynamic>?)
          ?.map((e) => BxPackageAddon.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
  requiredFields:
      (json['requiredFields'] as List<dynamic>?)
          ?.map(
            (e) => BxPackageRequiredField.fromJson(e as Map<String, dynamic>),
          )
          .toList() ??
      const [],
  documentRequirements:
      (json['documentRequirements'] as List<dynamic>?)
          ?.map(
            (e) => BxPackageDocumentRequirement.fromJson(
              e as Map<String, dynamic>,
            ),
          )
          .toList() ??
      const [],
  itineraryDays:
      (json['itineraryDays'] as List<dynamic>?)
          ?.map(
            (e) => BxPackageItineraryDay.fromJson(e as Map<String, dynamic>),
          )
          .toList() ??
      const [],
  includes:
      (json['includes'] as List<dynamic>?)
          ?.map((e) => BxPackageInclude.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
  excludes:
      (json['excludes'] as List<dynamic>?)
          ?.map((e) => BxPackageExclude.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
  highlights:
      (json['highlights'] as List<dynamic>?)
          ?.map((e) => BxPackageHighlight.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
);

Map<String, dynamic> _$BxGetPackageDetailDataToJson(
  BxGetPackageDetailData instance,
) => <String, dynamic>{
  'id': instance.id,
  'packageCode': instance.packageCode,
  'agentId': instance.agentId,
  'type': instance.type,
  'name': instance.name,
  'coverImageURL': instance.coverImageUrl,
  'description': instance.description,
  'galleryImages': instance.galleryImages,
  'destinationCountryId': instance.destinationCountryId,
  'cityId': instance.cityId,
  'location': instance.location,
  'category': instance.category,
  'daysDuration': instance.daysDuration,
  'availabilityType': instance.availabilityType,
  'displayPrice': instance.displayPrice,
  'estimatedPrice': instance.estimatedPrice,
  'discountPercent': instance.discountPercent,
  'availableSeats': instance.availableSeats,
  'nextDepartureDate': instance.nextDepartureDate,
  'status': instance.status,
  'flagIssueType': instance.flagIssueType,
  'flagDetails': instance.flagDetails,
  'adminNote': instance.adminNote,
  'submittedAt': instance.submittedAt,
  'approvedBy': instance.approvedBy,
  'approvedAt': instance.approvedAt,
  'statusTour': instance.statusTour,
  'timeDisplay': instance.timeDisplay,
  'destination': instance.destination,
  'originalPrice': instance.originalPrice,
  'promoTag': instance.promoTag,
  'CreatedAt': instance.createdAt,
  'UpdatedAt': instance.updatedAt,
  'availability': instance.availability,
  'hotels': instance.hotels,
  'activities': instance.activities,
  'addons': instance.addons,
  'requiredFields': instance.requiredFields,
  'documentRequirements': instance.documentRequirements,
  'itineraryDays': instance.itineraryDays,
  'includes': instance.includes,
  'excludes': instance.excludes,
  'highlights': instance.highlights,
};

BxPackageGalleryImages _$BxPackageGalleryImagesFromJson(
  Map<String, dynamic> json,
) => BxPackageGalleryImages(
  images: (json['images'] as List<dynamic>).map((e) => e as String).toList(),
);

Map<String, dynamic> _$BxPackageGalleryImagesToJson(
  BxPackageGalleryImages instance,
) => <String, dynamic>{'images': instance.images};

BxPackageAvailability _$BxPackageAvailabilityFromJson(
  Map<String, dynamic> json,
) => BxPackageAvailability(
  id: (json['id'] as num?)?.toInt(),
  packageId: (json['packageId'] as num?)?.toInt(),
  startDate: json['startDate'] as String?,
  endDate: json['endDate'] as String?,
  isFixedGroup: json['isFixedGroup'] as bool?,
  maxSeats: (json['maxSeats'] as num?)?.toInt(),
  notes: json['notes'] as String?,
  createdAt: json['CreatedAt'] as String?,
  updatedAt: json['UpdatedAt'] as String?,
);

Map<String, dynamic> _$BxPackageAvailabilityToJson(
  BxPackageAvailability instance,
) => <String, dynamic>{
  'id': instance.id,
  'packageId': instance.packageId,
  'startDate': instance.startDate,
  'endDate': instance.endDate,
  'isFixedGroup': instance.isFixedGroup,
  'maxSeats': instance.maxSeats,
  'notes': instance.notes,
  'CreatedAt': instance.createdAt,
  'UpdatedAt': instance.updatedAt,
};

BxPackageHotel _$BxPackageHotelFromJson(Map<String, dynamic> json) =>
    BxPackageHotel(
      id: (json['id'] as num?)?.toInt(),
      packageId: (json['packageId'] as num?)?.toInt(),
      hotelStars: (json['hotelStars'] as num?)?.toInt(),
      roomType: json['roomType'] as String?,
      optionName: json['optionName'] as String?,
      pricePerNightEst: (json['pricePerNightEst'] as num?)?.toInt(),
      includeInPackage: json['includeInPackage'] as bool?,
      nights: (json['nights'] as num?)?.toInt(),
      sortOrder: (json['sortOrder'] as num?)?.toInt(),
      createdAt: json['CreatedAt'] as String?,
      updatedAt: json['UpdatedAt'] as String?,
    );

Map<String, dynamic> _$BxPackageHotelToJson(BxPackageHotel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'packageId': instance.packageId,
      'hotelStars': instance.hotelStars,
      'roomType': instance.roomType,
      'optionName': instance.optionName,
      'pricePerNightEst': instance.pricePerNightEst,
      'includeInPackage': instance.includeInPackage,
      'nights': instance.nights,
      'sortOrder': instance.sortOrder,
      'CreatedAt': instance.createdAt,
      'UpdatedAt': instance.updatedAt,
    };

BxPackageActivity _$BxPackageActivityFromJson(Map<String, dynamic> json) =>
    BxPackageActivity(
      id: (json['id'] as num?)?.toInt(),
      packageId: (json['packageId'] as num?)?.toInt(),
      title: json['title'] as String?,
      imageUrl: json['imageURL'] as String?,
      estimatedCost: (json['estimatedCost'] as num?)?.toInt(),
      includeInPackage: json['includeInPackage'] as bool?,
      sortOrder: (json['sortOrder'] as num?)?.toInt(),
      createdAt: json['CreatedAt'] as String?,
      updatedAt: json['UpdatedAt'] as String?,
    );

Map<String, dynamic> _$BxPackageActivityToJson(BxPackageActivity instance) =>
    <String, dynamic>{
      'id': instance.id,
      'packageId': instance.packageId,
      'title': instance.title,
      'imageURL': instance.imageUrl,
      'estimatedCost': instance.estimatedCost,
      'includeInPackage': instance.includeInPackage,
      'sortOrder': instance.sortOrder,
      'CreatedAt': instance.createdAt,
      'UpdatedAt': instance.updatedAt,
    };

BxPackageAddon _$BxPackageAddonFromJson(Map<String, dynamic> json) =>
    BxPackageAddon(
      id: (json['id'] as num?)?.toInt(),
      packageId: (json['packageId'] as num?)?.toInt(),
      addonType: json['addonType'] as String?,
      estimatedPrice: (json['estimatedPrice'] as num?)?.toInt(),
      priceModel: json['priceModel'] as String?,
      includeInPackage: json['includeInPackage'] as bool?,
      active: json['active'] as bool?,
      createdAt: json['CreatedAt'] as String?,
      updatedAt: json['UpdatedAt'] as String?,
    );

Map<String, dynamic> _$BxPackageAddonToJson(BxPackageAddon instance) =>
    <String, dynamic>{
      'id': instance.id,
      'packageId': instance.packageId,
      'addonType': instance.addonType,
      'estimatedPrice': instance.estimatedPrice,
      'priceModel': instance.priceModel,
      'includeInPackage': instance.includeInPackage,
      'active': instance.active,
      'CreatedAt': instance.createdAt,
      'UpdatedAt': instance.updatedAt,
    };

BxPackageRequiredField _$BxPackageRequiredFieldFromJson(
  Map<String, dynamic> json,
) => BxPackageRequiredField(
  id: (json['id'] as num?)?.toInt(),
  packageId: (json['packageId'] as num?)?.toInt(),
  fieldCode: json['fieldCode'] as String?,
  isAgentSelectable: json['isAgentSelectable'] as bool?,
  isAdminLocked: json['isAdminLocked'] as bool?,
  isRequired: json['isRequired'] as bool?,
  sortOrder: (json['sortOrder'] as num?)?.toInt(),
  createdAt: json['CreatedAt'] as String?,
  updatedAt: json['UpdatedAt'] as String?,
);

Map<String, dynamic> _$BxPackageRequiredFieldToJson(
  BxPackageRequiredField instance,
) => <String, dynamic>{
  'id': instance.id,
  'packageId': instance.packageId,
  'fieldCode': instance.fieldCode,
  'isAgentSelectable': instance.isAgentSelectable,
  'isAdminLocked': instance.isAdminLocked,
  'isRequired': instance.isRequired,
  'sortOrder': instance.sortOrder,
  'CreatedAt': instance.createdAt,
  'UpdatedAt': instance.updatedAt,
};

BxPackageDocumentRequirement _$BxPackageDocumentRequirementFromJson(
  Map<String, dynamic> json,
) => BxPackageDocumentRequirement(
  id: (json['id'] as num?)?.toInt(),
  packageId: (json['packageId'] as num?)?.toInt(),
  documentTypeId: (json['documentTypeId'] as num?)?.toInt(),
  isRequired: json['isRequired'] as bool?,
  isOptional: json['isOptional'] as bool?,
  requiredAfter: json['requiredAfter'] as String?,
  isLocked: json['isLocked'] as bool?,
  notes: json['notes'] as String?,
  createdAt: json['CreatedAt'] as String?,
  updatedAt: json['UpdatedAt'] as String?,
);

Map<String, dynamic> _$BxPackageDocumentRequirementToJson(
  BxPackageDocumentRequirement instance,
) => <String, dynamic>{
  'id': instance.id,
  'packageId': instance.packageId,
  'documentTypeId': instance.documentTypeId,
  'isRequired': instance.isRequired,
  'isOptional': instance.isOptional,
  'requiredAfter': instance.requiredAfter,
  'isLocked': instance.isLocked,
  'notes': instance.notes,
  'CreatedAt': instance.createdAt,
  'UpdatedAt': instance.updatedAt,
};

BxPackageItineraryDay _$BxPackageItineraryDayFromJson(
  Map<String, dynamic> json,
) => BxPackageItineraryDay(
  id: (json['id'] as num?)?.toInt(),
  packageId: (json['packageId'] as num?)?.toInt(),
  dayNumber: (json['dayNumber'] as num?)?.toInt(),
  title: json['title'] as String?,
  description: json['description'] as String?,
  sortOrder: (json['sortOrder'] as num?)?.toInt(),
  items:
      (json['items'] as List<dynamic>?)
          ?.map(
            (e) => BxPackageItineraryItem.fromJson(e as Map<String, dynamic>),
          )
          .toList() ??
      const [],
  createdAt: json['CreatedAt'] as String?,
  updatedAt: json['UpdatedAt'] as String?,
);

Map<String, dynamic> _$BxPackageItineraryDayToJson(
  BxPackageItineraryDay instance,
) => <String, dynamic>{
  'id': instance.id,
  'packageId': instance.packageId,
  'dayNumber': instance.dayNumber,
  'title': instance.title,
  'description': instance.description,
  'sortOrder': instance.sortOrder,
  'items': instance.items,
  'CreatedAt': instance.createdAt,
  'UpdatedAt': instance.updatedAt,
};

BxPackageItineraryItem _$BxPackageItineraryItemFromJson(
  Map<String, dynamic> json,
) => BxPackageItineraryItem(
  id: (json['id'] as num?)?.toInt(),
  itineraryDayId: (json['itineraryDayId'] as num?)?.toInt(),
  time: json['time'] as String?,
  title: json['title'] as String?,
  description: json['description'] as String?,
  sortOrder: (json['sortOrder'] as num?)?.toInt(),
  createdAt: json['CreatedAt'] as String?,
  updatedAt: json['UpdatedAt'] as String?,
);

Map<String, dynamic> _$BxPackageItineraryItemToJson(
  BxPackageItineraryItem instance,
) => <String, dynamic>{
  'id': instance.id,
  'itineraryDayId': instance.itineraryDayId,
  'time': instance.time,
  'title': instance.title,
  'description': instance.description,
  'sortOrder': instance.sortOrder,
  'CreatedAt': instance.createdAt,
  'UpdatedAt': instance.updatedAt,
};

BxPackageInclude _$BxPackageIncludeFromJson(Map<String, dynamic> json) =>
    BxPackageInclude(
      id: (json['id'] as num?)?.toInt(),
      packageId: (json['packageId'] as num?)?.toInt(),
      category: json['category'] as String?,
      itemText: json['itemText'] as String?,
      sortOrder: (json['sortOrder'] as num?)?.toInt(),
      createdAt: json['CreatedAt'] as String?,
      updatedAt: json['UpdatedAt'] as String?,
    );

Map<String, dynamic> _$BxPackageIncludeToJson(BxPackageInclude instance) =>
    <String, dynamic>{
      'id': instance.id,
      'packageId': instance.packageId,
      'category': instance.category,
      'itemText': instance.itemText,
      'sortOrder': instance.sortOrder,
      'CreatedAt': instance.createdAt,
      'UpdatedAt': instance.updatedAt,
    };

BxPackageExclude _$BxPackageExcludeFromJson(Map<String, dynamic> json) =>
    BxPackageExclude(
      id: (json['id'] as num?)?.toInt(),
      packageId: (json['packageId'] as num?)?.toInt(),
      itemText: json['itemText'] as String?,
      sortOrder: (json['sortOrder'] as num?)?.toInt(),
      createdAt: json['CreatedAt'] as String?,
      updatedAt: json['UpdatedAt'] as String?,
    );

Map<String, dynamic> _$BxPackageExcludeToJson(BxPackageExclude instance) =>
    <String, dynamic>{
      'id': instance.id,
      'packageId': instance.packageId,
      'itemText': instance.itemText,
      'sortOrder': instance.sortOrder,
      'CreatedAt': instance.createdAt,
      'UpdatedAt': instance.updatedAt,
    };

BxPackageHighlight _$BxPackageHighlightFromJson(Map<String, dynamic> json) =>
    BxPackageHighlight(
      id: (json['id'] as num?)?.toInt(),
      packageId: (json['packageId'] as num?)?.toInt(),
      name: json['name'] as String?,
      iconUrl: json['iconURL'] as String?,
      sortOrder: (json['sortOrder'] as num?)?.toInt(),
      createdAt: json['CreatedAt'] as String?,
      updatedAt: json['UpdatedAt'] as String?,
    );

Map<String, dynamic> _$BxPackageHighlightToJson(BxPackageHighlight instance) =>
    <String, dynamic>{
      'id': instance.id,
      'packageId': instance.packageId,
      'name': instance.name,
      'iconURL': instance.iconUrl,
      'sortOrder': instance.sortOrder,
      'CreatedAt': instance.createdAt,
      'UpdatedAt': instance.updatedAt,
    };
