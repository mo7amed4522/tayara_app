// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bx_agent_profile_details_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BxAgentProfileDetailsResponse _$BxAgentProfileDetailsResponseFromJson(
  Map<String, dynamic> json,
) => BxAgentProfileDetailsResponse(
  code: (json['code'] as num).toInt(),
  data: json['data'] == null
      ? null
      : BxAgentProfileDetailsData.fromJson(
          json['data'] as Map<String, dynamic>,
        ),
  msg: json['msg'] as String,
);

Map<String, dynamic> _$BxAgentProfileDetailsResponseToJson(
  BxAgentProfileDetailsResponse instance,
) => <String, dynamic>{
  'code': instance.code,
  'data': instance.data,
  'msg': instance.msg,
};

BxAgentProfileDetailsData _$BxAgentProfileDetailsDataFromJson(
  Map<String, dynamic> json,
) => BxAgentProfileDetailsData(
  agent: json['agent'] == null
      ? null
      : BxAgentProfileAgent.fromJson(json['agent'] as Map<String, dynamic>),
  packages: (json['packages'] as List<dynamic>)
      .map((e) => BxAgentProfilePackage.fromJson(e as Map<String, dynamic>))
      .toList(),
  packagesTotal: (json['packagesTotal'] as num).toInt(),
  reviews: (json['reviews'] as List<dynamic>)
      .map((e) => BxAgentProfileReview.fromJson(e as Map<String, dynamic>))
      .toList(),
  reviewAvgRating: (json['reviewAvgRating'] as num?)?.toDouble(),
  reviewTotal: (json['reviewTotal'] as num).toInt(),
  topDestination: json['topDestination'] as String?,
);

Map<String, dynamic> _$BxAgentProfileDetailsDataToJson(
  BxAgentProfileDetailsData instance,
) => <String, dynamic>{
  'agent': instance.agent,
  'packages': instance.packages,
  'packagesTotal': instance.packagesTotal,
  'reviews': instance.reviews,
  'reviewAvgRating': instance.reviewAvgRating,
  'reviewTotal': instance.reviewTotal,
  'topDestination': instance.topDestination,
};

BxAgentProfileAgent _$BxAgentProfileAgentFromJson(Map<String, dynamic> json) =>
    BxAgentProfileAgent(
      id: (json['id'] as num?)?.toInt(),
      companyName: json['companyName'] as String?,
      responsibleName: json['responsibleName'] as String?,
      headerImg: json['headerImg'] as String?,
      phoneCountryCode: json['phoneCountryCode'] as String?,
      phone: json['phone'] as String?,
      businessEmail: json['businessEmail'] as String?,
      countryId: (json['countryId'] as num?)?.toInt(),
      cityId: (json['cityId'] as num?)?.toInt(),
      country: json['country'] as String?,
      city: json['city'] as String?,
      companyAddress: json['companyAddress'] as String?,
      licenseNumber: json['licenseNumber'] as String?,
      status: json['status'] as String?,
      planId: (json['planId'] as num?)?.toInt(),
      shortDescription: json['shortDescription'] as String?,
      longDescription: json['longDescription'] as String?,
      backgroundImage: json['backgroundImage'] as String?,
      trustedTravelersCount: (json['trustedTravelersCount'] as num?)?.toInt(),
      commissionPercent: (json['commissionPercent'] as num?)?.toInt(),
      slaHours: (json['slaHours'] as num?)?.toInt(),
      approvedBy: (json['approvedBy'] as num?)?.toInt(),
      rejectedReason: json['rejectedReason'] as String?,
      approvedAt: json['approvedAt'] as String?,
      lastLoginAt: json['lastLoginAt'] as String?,
      createdAt: json['CreatedAt'] as String?,
      updatedAt: json['UpdatedAt'] as String?,
      averageRating: (json['averageRating'] as num?)?.toDouble(),
      reviewCount: (json['reviewCount'] as num?)?.toInt(),
      trustedCount: (json['trustedCount'] as num?)?.toInt(),
      statusLabel: json['statusLabel'] as String?,
    );

Map<String, dynamic> _$BxAgentProfileAgentToJson(
  BxAgentProfileAgent instance,
) => <String, dynamic>{
  'id': instance.id,
  'companyName': instance.companyName,
  'responsibleName': instance.responsibleName,
  'headerImg': instance.headerImg,
  'phoneCountryCode': instance.phoneCountryCode,
  'phone': instance.phone,
  'businessEmail': instance.businessEmail,
  'countryId': instance.countryId,
  'cityId': instance.cityId,
  'country': instance.country,
  'city': instance.city,
  'companyAddress': instance.companyAddress,
  'licenseNumber': instance.licenseNumber,
  'status': instance.status,
  'planId': instance.planId,
  'shortDescription': instance.shortDescription,
  'longDescription': instance.longDescription,
  'backgroundImage': instance.backgroundImage,
  'trustedTravelersCount': instance.trustedTravelersCount,
  'commissionPercent': instance.commissionPercent,
  'slaHours': instance.slaHours,
  'approvedBy': instance.approvedBy,
  'rejectedReason': instance.rejectedReason,
  'approvedAt': instance.approvedAt,
  'lastLoginAt': instance.lastLoginAt,
  'CreatedAt': instance.createdAt,
  'UpdatedAt': instance.updatedAt,
  'averageRating': instance.averageRating,
  'reviewCount': instance.reviewCount,
  'trustedCount': instance.trustedCount,
  'statusLabel': instance.statusLabel,
};

BxAgentProfilePackage _$BxAgentProfilePackageFromJson(
  Map<String, dynamic> json,
) => BxAgentProfilePackage(
  id: (json['id'] as num?)?.toInt(),
  packageCode: json['packageCode'] as String?,
  agentId: (json['agentId'] as num?)?.toInt(),
  type: json['type'] as String?,
  name: json['name'] as String?,
  coverImageUrl: json['coverImageURL'] as String?,
  description: json['description'] as String?,
  galleryImages: json['galleryImages'] == null
      ? null
      : BxAgentProfileGalleryImages.fromJson(
          json['galleryImages'] as Map<String, dynamic>,
        ),
  destinationCountryId: (json['destinationCountryId'] as num?)?.toInt(),
  cityId: (json['cityId'] as num?)?.toInt(),
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
  salePrice: json['salePrice'] as num?,
  rating: (json['rating'] as num?)?.toDouble(),
  reviewCount: (json['reviewCount'] as num?)?.toInt(),
  seatsLeft: (json['seatsLeft'] as num?)?.toInt(),
  departureDate: json['departureDate'] as String?,
  nextDepartureAt: json['nextDepartureAt'] as String?,
);

Map<String, dynamic> _$BxAgentProfilePackageToJson(
  BxAgentProfilePackage instance,
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
  'agentName': instance.agentName,
  'agentLogo': instance.agentLogo,
  'salePrice': instance.salePrice,
  'rating': instance.rating,
  'reviewCount': instance.reviewCount,
  'seatsLeft': instance.seatsLeft,
  'departureDate': instance.departureDate,
  'nextDepartureAt': instance.nextDepartureAt,
};

BxAgentProfileGalleryImages _$BxAgentProfileGalleryImagesFromJson(
  Map<String, dynamic> json,
) => BxAgentProfileGalleryImages(
  images: (json['images'] as List<dynamic>).map((e) => e as String).toList(),
);

Map<String, dynamic> _$BxAgentProfileGalleryImagesToJson(
  BxAgentProfileGalleryImages instance,
) => <String, dynamic>{'images': instance.images};

BxAgentProfileReview _$BxAgentProfileReviewFromJson(
  Map<String, dynamic> json,
) => BxAgentProfileReview(
  id: (json['id'] as num?)?.toInt(),
  userName: json['userName'] as String?,
  userAvatar: json['userAvatar'] as String?,
  rating: (json['rating'] as num?)?.toDouble(),
  reviewText: json['reviewText'] as String?,
  createdAt: json['createdAt'] as String?,
);

Map<String, dynamic> _$BxAgentProfileReviewToJson(
  BxAgentProfileReview instance,
) => <String, dynamic>{
  'id': instance.id,
  'userName': instance.userName,
  'userAvatar': instance.userAvatar,
  'rating': instance.rating,
  'reviewText': instance.reviewText,
  'createdAt': instance.createdAt,
};
