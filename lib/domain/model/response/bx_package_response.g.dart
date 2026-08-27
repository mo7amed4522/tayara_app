// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bx_package_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BxPackageDetailResponse _$BxPackageDetailResponseFromJson(
  Map<String, dynamic> json,
) => BxPackageDetailResponse(
  code: (json['code'] as num?)?.toInt(),
  message: json['msg'] as String?,
  data: json['data'] == null
      ? null
      : BxPackageDetailData.fromJson(json['data'] as Map<String, dynamic>),
);

Map<String, dynamic> _$BxPackageDetailResponseToJson(
  BxPackageDetailResponse instance,
) => <String, dynamic>{
  'code': instance.code,
  'msg': instance.message,
  'data': instance.data,
};

BxPackageDetailData _$BxPackageDetailDataFromJson(
  Map<String, dynamic> json,
) => BxPackageDetailData(
  id: (json['id'] as num?)?.toInt(),
  packageCode: json['packageCode'] as String?,
  agentId: (json['agentId'] as num?)?.toInt(),
  name: json['name'] as String?,
  coverImageURL: json['coverImageURL'] as String?,
  description: json['description'] as String?,
  galleryImages: (json['galleryImages'] as List<dynamic>?)
      ?.map((e) => e as String)
      .toList(),
  destinationCountryId: (json['destinationCountryId'] as num?)?.toInt(),
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
  statusTour: json['statusTour'] as String?,
  timeDisplay: json['timeDisplay'] as String?,
  destination: json['destination'] as String?,
  originalPrice: (json['originalPrice'] as num?)?.toInt(),
  promoTag: json['promoTag'] as String?,
  hotels: (json['hotels'] as List<dynamic>?)
      ?.map((e) => BxPackageHotel.fromJson(e as Map<String, dynamic>))
      .toList(),
  activities: (json['activities'] as List<dynamic>?)
      ?.map((e) => BxPackageActivity.fromJson(e as Map<String, dynamic>))
      .toList(),
  addons: (json['addons'] as List<dynamic>?)
      ?.map((e) => BxPackageAddon.fromJson(e as Map<String, dynamic>))
      .toList(),
  availability: (json['availability'] as List<dynamic>?)
      ?.map((e) => BxPackageAvailability.fromJson(e as Map<String, dynamic>))
      .toList(),
  requiredFields: (json['requiredFields'] as List<dynamic>?)
      ?.map((e) => BxPackageRequiredField.fromJson(e as Map<String, dynamic>))
      .toList(),
  documentRequirements: (json['documentRequirements'] as List<dynamic>?)
      ?.map(
        (e) => BxPackageDocumentRequirement.fromJson(e as Map<String, dynamic>),
      )
      .toList(),
  itineraryDays: (json['itineraryDays'] as List<dynamic>?)
      ?.map((e) => BxItineraryDay.fromJson(e as Map<String, dynamic>))
      .toList(),
  includes: (json['includes'] as List<dynamic>?)
      ?.map((e) => BxPackageInclusion.fromJson(e as Map<String, dynamic>))
      .toList(),
  excludes: (json['excludes'] as List<dynamic>?)
      ?.map((e) => BxPackageExclusion.fromJson(e as Map<String, dynamic>))
      .toList(),
  highlights: (json['highlights'] as List<dynamic>?)
      ?.map((e) => BxPackageHighlight.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$BxPackageDetailDataToJson(
  BxPackageDetailData instance,
) => <String, dynamic>{
  'id': instance.id,
  'packageCode': instance.packageCode,
  'agentId': instance.agentId,
  'name': instance.name,
  'coverImageURL': instance.coverImageURL,
  'description': instance.description,
  'galleryImages': instance.galleryImages,
  'destinationCountryId': instance.destinationCountryId,
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
  'statusTour': instance.statusTour,
  'timeDisplay': instance.timeDisplay,
  'destination': instance.destination,
  'originalPrice': instance.originalPrice,
  'promoTag': instance.promoTag,
  'hotels': instance.hotels,
  'activities': instance.activities,
  'addons': instance.addons,
  'availability': instance.availability,
  'requiredFields': instance.requiredFields,
  'documentRequirements': instance.documentRequirements,
  'itineraryDays': instance.itineraryDays,
  'includes': instance.includes,
  'excludes': instance.excludes,
  'highlights': instance.highlights,
};

BxPackageHotel _$BxPackageHotelFromJson(Map<String, dynamic> json) =>
    BxPackageHotel(
      id: (json['id'] as num?)?.toInt(),
      name: json['name'] as String?,
      rating: json['rating'] as String?,
      location: json['location'] as String?,
    );

Map<String, dynamic> _$BxPackageHotelToJson(BxPackageHotel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'rating': instance.rating,
      'location': instance.location,
    };

BxPackageActivity _$BxPackageActivityFromJson(Map<String, dynamic> json) =>
    BxPackageActivity(
      id: (json['id'] as num?)?.toInt(),
      name: json['name'] as String?,
      description: json['description'] as String?,
      duration: json['duration'] as String?,
    );

Map<String, dynamic> _$BxPackageActivityToJson(BxPackageActivity instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'duration': instance.duration,
    };

BxPackageAddon _$BxPackageAddonFromJson(Map<String, dynamic> json) =>
    BxPackageAddon(
      id: (json['id'] as num?)?.toInt(),
      name: json['name'] as String?,
      description: json['description'] as String?,
      price: (json['price'] as num?)?.toInt(),
    );

Map<String, dynamic> _$BxPackageAddonToJson(BxPackageAddon instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'price': instance.price,
    };

BxPackageAvailability _$BxPackageAvailabilityFromJson(
  Map<String, dynamic> json,
) => BxPackageAvailability(
  id: (json['id'] as num?)?.toInt(),
  startDate: json['startDate'] as String?,
  endDate: json['endDate'] as String?,
  seats: (json['seats'] as num?)?.toInt(),
  price: (json['price'] as num?)?.toInt(),
);

Map<String, dynamic> _$BxPackageAvailabilityToJson(
  BxPackageAvailability instance,
) => <String, dynamic>{
  'id': instance.id,
  'startDate': instance.startDate,
  'endDate': instance.endDate,
  'seats': instance.seats,
  'price': instance.price,
};

BxPackageRequiredField _$BxPackageRequiredFieldFromJson(
  Map<String, dynamic> json,
) => BxPackageRequiredField(
  id: (json['id'] as num?)?.toInt(),
  fieldName: json['fieldName'] as String?,
  fieldType: json['fieldType'] as String?,
  isRequired: json['isRequired'] as bool?,
);

Map<String, dynamic> _$BxPackageRequiredFieldToJson(
  BxPackageRequiredField instance,
) => <String, dynamic>{
  'id': instance.id,
  'fieldName': instance.fieldName,
  'fieldType': instance.fieldType,
  'isRequired': instance.isRequired,
};

BxPackageDocumentRequirement _$BxPackageDocumentRequirementFromJson(
  Map<String, dynamic> json,
) => BxPackageDocumentRequirement(
  id: (json['id'] as num?)?.toInt(),
  documentType: json['documentType'] as String?,
  description: json['description'] as String?,
);

Map<String, dynamic> _$BxPackageDocumentRequirementToJson(
  BxPackageDocumentRequirement instance,
) => <String, dynamic>{
  'id': instance.id,
  'documentType': instance.documentType,
  'description': instance.description,
};

BxItineraryDay _$BxItineraryDayFromJson(Map<String, dynamic> json) =>
    BxItineraryDay(
      id: (json['id'] as num?)?.toInt(),
      dayNumber: (json['dayNumber'] as num?)?.toInt(),
      title: json['title'] as String?,
      description: json['description'] as String?,
      items: (json['items'] as List<dynamic>?)
          ?.map((e) => BxItineraryItem.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$BxItineraryDayToJson(BxItineraryDay instance) =>
    <String, dynamic>{
      'id': instance.id,
      'dayNumber': instance.dayNumber,
      'title': instance.title,
      'description': instance.description,
      'items': instance.items,
    };

BxItineraryItem _$BxItineraryItemFromJson(Map<String, dynamic> json) =>
    BxItineraryItem(
      id: (json['id'] as num?)?.toInt(),
      title: json['title'] as String?,
      description: json['description'] as String?,
      sortOrder: (json['sortOrder'] as num?)?.toInt(),
    );

Map<String, dynamic> _$BxItineraryItemToJson(BxItineraryItem instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'description': instance.description,
      'sortOrder': instance.sortOrder,
    };

BxPackageInclusion _$BxPackageInclusionFromJson(Map<String, dynamic> json) =>
    BxPackageInclusion(
      id: (json['id'] as num?)?.toInt(),
      text: json['text'] as String?,
      sortOrder: (json['sortOrder'] as num?)?.toInt(),
    );

Map<String, dynamic> _$BxPackageInclusionToJson(BxPackageInclusion instance) =>
    <String, dynamic>{
      'id': instance.id,
      'text': instance.text,
      'sortOrder': instance.sortOrder,
    };

BxPackageExclusion _$BxPackageExclusionFromJson(Map<String, dynamic> json) =>
    BxPackageExclusion(
      id: (json['id'] as num?)?.toInt(),
      text: json['text'] as String?,
      sortOrder: (json['sortOrder'] as num?)?.toInt(),
    );

Map<String, dynamic> _$BxPackageExclusionToJson(BxPackageExclusion instance) =>
    <String, dynamic>{
      'id': instance.id,
      'text': instance.text,
      'sortOrder': instance.sortOrder,
    };

BxPackageHighlight _$BxPackageHighlightFromJson(Map<String, dynamic> json) =>
    BxPackageHighlight(
      id: (json['id'] as num?)?.toInt(),
      text: json['text'] as String?,
      sortOrder: (json['sortOrder'] as num?)?.toInt(),
    );

Map<String, dynamic> _$BxPackageHighlightToJson(BxPackageHighlight instance) =>
    <String, dynamic>{
      'id': instance.id,
      'text': instance.text,
      'sortOrder': instance.sortOrder,
    };

BxPackageReviewsResponse _$BxPackageReviewsResponseFromJson(
  Map<String, dynamic> json,
) => BxPackageReviewsResponse(
  code: (json['code'] as num?)?.toInt(),
  message: json['msg'] as String?,
  data: json['data'] == null
      ? null
      : BxPackageReviewsData.fromJson(json['data'] as Map<String, dynamic>),
);

Map<String, dynamic> _$BxPackageReviewsResponseToJson(
  BxPackageReviewsResponse instance,
) => <String, dynamic>{
  'code': instance.code,
  'msg': instance.message,
  'data': instance.data,
};

BxPackageReviewItem _$BxPackageReviewItemFromJson(Map<String, dynamic> json) =>
    BxPackageReviewItem(
      id: (json['id'] as num?)?.toInt(),
      bookingId: (json['bookingId'] as num?)?.toInt(),
      userId: (json['userId'] as num?)?.toInt(),
      rating: (json['rating'] as num?)?.toInt(),
      reviewText: json['reviewText'] as String?,
      reviewStatus: json['reviewStatus'] as String?,
      createdAt: json['createdAt'] as String?,
    );

Map<String, dynamic> _$BxPackageReviewItemToJson(
  BxPackageReviewItem instance,
) => <String, dynamic>{
  'id': instance.id,
  'bookingId': instance.bookingId,
  'userId': instance.userId,
  'rating': instance.rating,
  'reviewText': instance.reviewText,
  'reviewStatus': instance.reviewStatus,
  'createdAt': instance.createdAt,
};

BxPackageReviewsData _$BxPackageReviewsDataFromJson(
  Map<String, dynamic> json,
) => BxPackageReviewsData(
  list: (json['list'] as List<dynamic>?)
      ?.map((e) => BxPackageReviewItem.fromJson(e as Map<String, dynamic>))
      .toList(),
  total: (json['total'] as num?)?.toInt(),
  totalPage: (json['totalPage'] as num?)?.toInt(),
  page: (json['page'] as num?)?.toInt(),
  pageSize: (json['pageSize'] as num?)?.toInt(),
);

Map<String, dynamic> _$BxPackageReviewsDataToJson(
  BxPackageReviewsData instance,
) => <String, dynamic>{
  'list': instance.list,
  'total': instance.total,
  'totalPage': instance.totalPage,
  'page': instance.page,
  'pageSize': instance.pageSize,
};
