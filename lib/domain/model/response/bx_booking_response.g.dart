// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bx_booking_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BxBookingListResponse _$BxBookingListResponseFromJson(
  Map<String, dynamic> json,
) => BxBookingListResponse(
  code: (json['code'] as num?)?.toInt(),
  message: json['msg'] as String?,
  data: json['data'] == null
      ? null
      : BxBookingListData.fromJson(json['data'] as Map<String, dynamic>),
);

Map<String, dynamic> _$BxBookingListResponseToJson(
  BxBookingListResponse instance,
) => <String, dynamic>{
  'code': instance.code,
  'msg': instance.message,
  'data': instance.data,
};

BxBookingItem _$BxBookingItemFromJson(Map<String, dynamic> json) =>
    BxBookingItem(
      id: (json['id'] as num?)?.toInt(),
      bookingCode: json['bookingCode'] as String?,
      userId: (json['userId'] as num?)?.toInt(),
      agentId: (json['agentId'] as num?)?.toInt(),
      packageId: (json['packageId'] as num?)?.toInt(),
      type: json['type'] as String?,
      bookingStatus: json['bookingStatus'] as String?,
      paymentStatus: json['paymentStatus'] as String?,
      amountGross: (json['amountGross'] as num?)?.toInt(),
      discountPercent: (json['discountPercent'] as num?)?.toInt(),
      currency: json['currency'] as String?,
      destinationCountryId: (json['destinationCountryId'] as num?)?.toInt(),
      travelerCount: (json['travelerCount'] as num?)?.toInt(),
      notes: json['notes'] as String?,
      startDate: json['startDate'] as String?,
      endDate: json['endDate'] as String?,
      requestedAt: json['requestedAt'] as String?,
      updatedAt: json['updatedAt'] as String?,
    );

Map<String, dynamic> _$BxBookingItemToJson(BxBookingItem instance) =>
    <String, dynamic>{
      'id': instance.id,
      'bookingCode': instance.bookingCode,
      'userId': instance.userId,
      'agentId': instance.agentId,
      'packageId': instance.packageId,
      'type': instance.type,
      'bookingStatus': instance.bookingStatus,
      'paymentStatus': instance.paymentStatus,
      'amountGross': instance.amountGross,
      'discountPercent': instance.discountPercent,
      'currency': instance.currency,
      'destinationCountryId': instance.destinationCountryId,
      'travelerCount': instance.travelerCount,
      'notes': instance.notes,
      'startDate': instance.startDate,
      'endDate': instance.endDate,
      'requestedAt': instance.requestedAt,
      'updatedAt': instance.updatedAt,
    };

BxBookingDetailResponse _$BxBookingDetailResponseFromJson(
  Map<String, dynamic> json,
) => BxBookingDetailResponse(
  code: (json['code'] as num?)?.toInt(),
  message: json['msg'] as String?,
  data: json['data'] == null
      ? null
      : BxBookingDetailData.fromJson(json['data'] as Map<String, dynamic>),
);

Map<String, dynamic> _$BxBookingDetailResponseToJson(
  BxBookingDetailResponse instance,
) => <String, dynamic>{
  'code': instance.code,
  'msg': instance.message,
  'data': instance.data,
};

BxBookingDetailData _$BxBookingDetailDataFromJson(Map<String, dynamic> json) =>
    BxBookingDetailData(
      booking: json['booking'] == null
          ? null
          : BxBookingItem.fromJson(json['booking'] as Map<String, dynamic>),
      travelers: (json['travelers'] as List<dynamic>?)
          ?.map((e) => BxBookingTraveler.fromJson(e as Map<String, dynamic>))
          .toList(),
      offers: (json['offers'] as List<dynamic>?)
          ?.map((e) => BxBookingOffer.fromJson(e as Map<String, dynamic>))
          .toList(),
      documents: (json['documents'] as List<dynamic>?)
          ?.map((e) => BxBookingDocument.fromJson(e as Map<String, dynamic>))
          .toList(),
      statusHistory: (json['statusHistory'] as List<dynamic>?)
          ?.map(
            (e) => BxBookingStatusHistory.fromJson(e as Map<String, dynamic>),
          )
          .toList(),
    );

Map<String, dynamic> _$BxBookingDetailDataToJson(
  BxBookingDetailData instance,
) => <String, dynamic>{
  'booking': instance.booking,
  'travelers': instance.travelers,
  'offers': instance.offers,
  'documents': instance.documents,
  'statusHistory': instance.statusHistory,
};

BxBookingTraveler _$BxBookingTravelerFromJson(Map<String, dynamic> json) =>
    BxBookingTraveler(
      id: (json['id'] as num?)?.toInt(),
      bookingId: (json['bookingId'] as num?)?.toInt(),
      isBooker: json['isBooker'] as bool?,
      fullName: json['fullName'] as String?,
      dob: json['dob'] as String?,
      nationalityId: (json['nationalityId'] as num?)?.toInt(),
      passportNumber: json['passportNumber'] as String?,
      passportExpiry: json['passportExpiry'] as String?,
      adultOrChild: json['adultOrChild'] as String?,
      email: json['email'] as String?,
      docStatus: json['docStatus'] as String?,
    );

Map<String, dynamic> _$BxBookingTravelerToJson(BxBookingTraveler instance) =>
    <String, dynamic>{
      'id': instance.id,
      'bookingId': instance.bookingId,
      'isBooker': instance.isBooker,
      'fullName': instance.fullName,
      'dob': instance.dob,
      'nationalityId': instance.nationalityId,
      'passportNumber': instance.passportNumber,
      'passportExpiry': instance.passportExpiry,
      'adultOrChild': instance.adultOrChild,
      'email': instance.email,
      'docStatus': instance.docStatus,
    };

BxBookingOffer _$BxBookingOfferFromJson(Map<String, dynamic> json) =>
    BxBookingOffer(
      id: (json['id'] as num?)?.toInt(),
      bookingId: (json['bookingId'] as num?)?.toInt(),
      agentId: (json['agentId'] as num?)?.toInt(),
      finalPrice: (json['finalPrice'] as num?)?.toInt(),
      availableDates: json['availableDates'] as String?,
      notes: json['notes'] as String?,
      status: json['status'] as String?,
      offeredAt: json['offeredAt'] as String?,
      expiresAt: json['expiresAt'] as String?,
    );

Map<String, dynamic> _$BxBookingOfferToJson(BxBookingOffer instance) =>
    <String, dynamic>{
      'id': instance.id,
      'bookingId': instance.bookingId,
      'agentId': instance.agentId,
      'finalPrice': instance.finalPrice,
      'availableDates': instance.availableDates,
      'notes': instance.notes,
      'status': instance.status,
      'offeredAt': instance.offeredAt,
      'expiresAt': instance.expiresAt,
    };

BxBookingDocument _$BxBookingDocumentFromJson(Map<String, dynamic> json) =>
    BxBookingDocument(
      id: (json['id'] as num?)?.toInt(),
      bookingId: (json['bookingId'] as num?)?.toInt(),
      documentType: json['documentType'] as String?,
      fileUrl: json['fileUrl'] as String?,
      status: json['status'] as String?,
      uploadedAt: json['uploadedAt'] as String?,
    );

Map<String, dynamic> _$BxBookingDocumentToJson(BxBookingDocument instance) =>
    <String, dynamic>{
      'id': instance.id,
      'bookingId': instance.bookingId,
      'documentType': instance.documentType,
      'fileUrl': instance.fileUrl,
      'status': instance.status,
      'uploadedAt': instance.uploadedAt,
    };

BxBookingStatusHistory _$BxBookingStatusHistoryFromJson(
  Map<String, dynamic> json,
) => BxBookingStatusHistory(
  id: (json['id'] as num?)?.toInt(),
  bookingId: (json['bookingId'] as num?)?.toInt(),
  actorType: json['actorType'] as String?,
  actorId: (json['actorId'] as num?)?.toInt(),
  fromStatus: json['fromStatus'] as String?,
  toStatus: json['toStatus'] as String?,
  notes: json['notes'] as String?,
  createdAt: json['createdAt'] as String?,
);

Map<String, dynamic> _$BxBookingStatusHistoryToJson(
  BxBookingStatusHistory instance,
) => <String, dynamic>{
  'id': instance.id,
  'bookingId': instance.bookingId,
  'actorType': instance.actorType,
  'actorId': instance.actorId,
  'fromStatus': instance.fromStatus,
  'toStatus': instance.toStatus,
  'notes': instance.notes,
  'createdAt': instance.createdAt,
};

BxBookingListData _$BxBookingListDataFromJson(Map<String, dynamic> json) =>
    BxBookingListData(
      list: (json['list'] as List<dynamic>?)
          ?.map((e) => BxBookingItem.fromJson(e as Map<String, dynamic>))
          .toList(),
      total: (json['total'] as num?)?.toInt(),
      totalPage: (json['totalPage'] as num?)?.toInt(),
      page: (json['page'] as num?)?.toInt(),
      pageSize: (json['pageSize'] as num?)?.toInt(),
    );

Map<String, dynamic> _$BxBookingListDataToJson(BxBookingListData instance) =>
    <String, dynamic>{
      'list': instance.list,
      'total': instance.total,
      'totalPage': instance.totalPage,
      'page': instance.page,
      'pageSize': instance.pageSize,
    };
