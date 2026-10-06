// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bx_get_recommended_for_customer_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BxGetRecommendedForCustomerResponse
_$BxGetRecommendedForCustomerResponseFromJson(Map<String, dynamic> json) =>
    BxGetRecommendedForCustomerResponse(
      code: (json['code'] as num).toInt(),
      data: (json['data'] as List<dynamic>?)
          ?.map(
            (e) => BxRecommendedForCustomerPackage.fromJson(
              e as Map<String, dynamic>,
            ),
          )
          .toList(),
      msg: json['msg'] as String?,
    );

Map<String, dynamic> _$BxGetRecommendedForCustomerResponseToJson(
  BxGetRecommendedForCustomerResponse instance,
) => <String, dynamic>{
  'code': instance.code,
  'data': instance.data,
  'msg': instance.msg,
};

BxRecommendedForCustomerPackage _$BxRecommendedForCustomerPackageFromJson(
  Map<String, dynamic> json,
) => BxRecommendedForCustomerPackage(
  id: (json['id'] as num?)?.toInt(),
  packageCode: json['packageCode'] as String?,
  agentId: (json['agentId'] as num?)?.toInt(),
  type: json['type'] as String?,
  name: json['name'] as String?,
  coverImageUrl: json['coverImageURL'] as String?,
  description: json['description'] as String?,
  galleryImages: json['galleryImages'] == null
      ? null
      : BxRecommendedGalleryImages.fromJson(
          json['galleryImages'] as Map<String, dynamic>,
        ),
  destinationCountryId: (json['destinationCountryId'] as num?)?.toInt(),
  location: json['location'] as String?,
  category: json['category'] as String?,
  daysDuration: (json['daysDuration'] as num?)?.toInt(),
  availabilityType: json['availabilityType'] as String?,
  displayPrice: json['displayPrice'] as num?,
  estimatedPrice: json['estimatedPrice'] as num?,
  discountPercent: json['discountPercent'] as num?,
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
  originalPrice: json['originalPrice'] as num?,
  promoTag: json['promoTag'] as String?,
  createdAt: json['CreatedAt'] as String?,
  updatedAt: json['UpdatedAt'] as String?,
  agentName: json['agentName'] as String?,
  agentLogo: json['agentLogo'] as String?,
  rating: (json['rating'] as num?)?.toDouble(),
  reviewCount: (json['reviewCount'] as num?)?.toInt(),
  viewCount: (json['viewCount'] as num?)?.toInt(),
  wishlisted: json['wishlisted'] as bool?,
);

Map<String, dynamic> _$BxRecommendedForCustomerPackageToJson(
  BxRecommendedForCustomerPackage instance,
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
  'agentName': instance.agentName,
  'agentLogo': instance.agentLogo,
  'rating': instance.rating,
  'reviewCount': instance.reviewCount,
  'viewCount': instance.viewCount,
  'wishlisted': instance.wishlisted,
};

BxRecommendedGalleryImages _$BxRecommendedGalleryImagesFromJson(
  Map<String, dynamic> json,
) => BxRecommendedGalleryImages(
  images: (json['images'] as List<dynamic>?)?.map((e) => e as String).toList(),
);

Map<String, dynamic> _$BxRecommendedGalleryImagesToJson(
  BxRecommendedGalleryImages instance,
) => <String, dynamic>{'images': instance.images};
