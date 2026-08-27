// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bx_agent_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BxCustomerAgentDetailResponse _$BxCustomerAgentDetailResponseFromJson(
  Map<String, dynamic> json,
) => BxCustomerAgentDetailResponse(
  code: (json['code'] as num?)?.toInt(),
  message: json['msg'] as String?,
  data: json['data'] == null
      ? null
      : BxCustomerAgentDetailData.fromJson(
          json['data'] as Map<String, dynamic>,
        ),
);

Map<String, dynamic> _$BxCustomerAgentDetailResponseToJson(
  BxCustomerAgentDetailResponse instance,
) => <String, dynamic>{
  'code': instance.code,
  'msg': instance.message,
  'data': instance.data,
};

BxCustomerAgentDetailData _$BxCustomerAgentDetailDataFromJson(
  Map<String, dynamic> json,
) => BxCustomerAgentDetailData(
  agent: json['agent'] == null
      ? null
      : BxCustomerAgentProfile.fromJson(json['agent'] as Map<String, dynamic>),
  packages: (json['packages'] as List<dynamic>?)
      ?.map(
        (e) => BxCustomerAgentPackageCard.fromJson(e as Map<String, dynamic>),
      )
      .toList(),
  packagesTotal: (json['packagesTotal'] as num?)?.toInt(),
  reviews: (json['reviews'] as List<dynamic>?)
      ?.map(
        (e) => BxCustomerAgentReviewItem.fromJson(e as Map<String, dynamic>),
      )
      .toList(),
  reviewAvgRating: (json['reviewAvgRating'] as num?)?.toDouble(),
  reviewTotal: (json['reviewTotal'] as num?)?.toInt(),
  topDestination: json['topDestination'] as String?,
);

Map<String, dynamic> _$BxCustomerAgentDetailDataToJson(
  BxCustomerAgentDetailData instance,
) => <String, dynamic>{
  'agent': instance.agent,
  'packages': instance.packages,
  'packagesTotal': instance.packagesTotal,
  'reviews': instance.reviews,
  'reviewAvgRating': instance.reviewAvgRating,
  'reviewTotal': instance.reviewTotal,
  'topDestination': instance.topDestination,
};

BxCustomerAgentProfile _$BxCustomerAgentProfileFromJson(
  Map<String, dynamic> json,
) => BxCustomerAgentProfile(
  id: (json['id'] as num?)?.toInt(),
  companyName: json['companyName'] as String?,
  headerImg: json['headerImg'] as String?,
  phone: json['phone'] as String?,
  phoneCountryCode: json['phoneCountryCode'] as String?,
  businessEmail: json['businessEmail'] as String?,
  country: json['country'] as String?,
  companyAddress: json['companyAddress'] as String?,
  licenseNumber: json['licenseNumber'] as String?,
  status: json['status'] as String?,
  averageRating: (json['averageRating'] as num?)?.toDouble(),
  reviewCount: (json['reviewCount'] as num?)?.toInt(),
  trustedTravelersCount: (json['trustedTravelersCount'] as num?)?.toInt(),
  statusLabel: json['statusLabel'] as String?,
  shortDescription: json['shortDescription'] as String?,
  longDescription: json['longDescription'] as String?,
  backgroundImage: json['backgroundImage'] as String?,
);

Map<String, dynamic> _$BxCustomerAgentProfileToJson(
  BxCustomerAgentProfile instance,
) => <String, dynamic>{
  'id': instance.id,
  'companyName': instance.companyName,
  'headerImg': instance.headerImg,
  'phone': instance.phone,
  'phoneCountryCode': instance.phoneCountryCode,
  'businessEmail': instance.businessEmail,
  'country': instance.country,
  'companyAddress': instance.companyAddress,
  'licenseNumber': instance.licenseNumber,
  'status': instance.status,
  'averageRating': instance.averageRating,
  'reviewCount': instance.reviewCount,
  'trustedTravelersCount': instance.trustedTravelersCount,
  'statusLabel': instance.statusLabel,
  'shortDescription': instance.shortDescription,
  'longDescription': instance.longDescription,
  'backgroundImage': instance.backgroundImage,
};

BxCustomerAgentPackageCard _$BxCustomerAgentPackageCardFromJson(
  Map<String, dynamic> json,
) => BxCustomerAgentPackageCard(
  id: (json['id'] as num?)?.toInt(),
  packageCode: json['packageCode'] as String?,
  agentId: (json['agentId'] as num?)?.toInt(),
  name: json['name'] as String?,
  coverImageURL: json['coverImageURL'] as String?,
  category: json['category'] as String?,
  daysDuration: (json['daysDuration'] as num?)?.toInt(),
  displayPrice: (json['displayPrice'] as num?)?.toInt(),
  discountPercent: (json['discountPercent'] as num?)?.toInt(),
  salePrice: (json['salePrice'] as num?)?.toInt(),
  rating: (json['rating'] as num?)?.toDouble(),
  reviewCount: (json['reviewCount'] as num?)?.toInt(),
  seatsLeft: (json['seatsLeft'] as num?)?.toInt(),
  departureDate: json['departureDate'] as String?,
  status: json['status'] as String?,
  agentName: json['agentName'] as String?,
  agentLogo: json['agentLogo'] as String?,
);

Map<String, dynamic> _$BxCustomerAgentPackageCardToJson(
  BxCustomerAgentPackageCard instance,
) => <String, dynamic>{
  'id': instance.id,
  'packageCode': instance.packageCode,
  'agentId': instance.agentId,
  'name': instance.name,
  'coverImageURL': instance.coverImageURL,
  'category': instance.category,
  'daysDuration': instance.daysDuration,
  'displayPrice': instance.displayPrice,
  'discountPercent': instance.discountPercent,
  'salePrice': instance.salePrice,
  'rating': instance.rating,
  'reviewCount': instance.reviewCount,
  'seatsLeft': instance.seatsLeft,
  'departureDate': instance.departureDate,
  'status': instance.status,
  'agentName': instance.agentName,
  'agentLogo': instance.agentLogo,
};

BxCustomerAgentReviewItem _$BxCustomerAgentReviewItemFromJson(
  Map<String, dynamic> json,
) => BxCustomerAgentReviewItem(
  id: (json['id'] as num?)?.toInt(),
  userName: json['userName'] as String?,
  userAvatar: json['userAvatar'] as String?,
  rating: (json['rating'] as num?)?.toInt(),
  reviewText: json['reviewText'] as String?,
  createdAt: json['createdAt'] as String?,
);

Map<String, dynamic> _$BxCustomerAgentReviewItemToJson(
  BxCustomerAgentReviewItem instance,
) => <String, dynamic>{
  'id': instance.id,
  'userName': instance.userName,
  'userAvatar': instance.userAvatar,
  'rating': instance.rating,
  'reviewText': instance.reviewText,
  'createdAt': instance.createdAt,
};
