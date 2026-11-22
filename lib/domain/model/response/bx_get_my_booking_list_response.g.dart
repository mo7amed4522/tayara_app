// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bx_get_my_booking_list_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BxGetMyBookingListResponse _$BxGetMyBookingListResponseFromJson(
  Map<String, dynamic> json,
) => BxGetMyBookingListResponse(
  code: (json['code'] as num).toInt(),
  data: json['data'] == null
      ? null
      : BxGetMyBookingListData.fromJson(json['data'] as Map<String, dynamic>),
  msg: json['msg'] as String,
);

Map<String, dynamic> _$BxGetMyBookingListResponseToJson(
  BxGetMyBookingListResponse instance,
) => <String, dynamic>{
  'code': instance.code,
  'data': instance.data,
  'msg': instance.msg,
};

BxGetMyBookingListData _$BxGetMyBookingListDataFromJson(
  Map<String, dynamic> json,
) => BxGetMyBookingListData(
  list: (json['list'] as List<dynamic>)
      .map((e) => BxMyBookingItem.fromJson(e as Map<String, dynamic>))
      .toList(),
  total: (json['total'] as num).toInt(),
  totalPage: (json['totalPage'] as num).toInt(),
  page: (json['page'] as num).toInt(),
  pageSize: (json['pageSize'] as num).toInt(),
);

Map<String, dynamic> _$BxGetMyBookingListDataToJson(
  BxGetMyBookingListData instance,
) => <String, dynamic>{
  'list': instance.list,
  'total': instance.total,
  'totalPage': instance.totalPage,
  'page': instance.page,
  'pageSize': instance.pageSize,
};

BxMyBookingItem _$BxMyBookingItemFromJson(Map<String, dynamic> json) =>
    BxMyBookingItem(
      id: (json['id'] as num?)?.toInt(),
      bookingCode: json['bookingCode'] as String?,
      userId: (json['userId'] as num?)?.toInt(),
      agentId: (json['agentId'] as num?)?.toInt(),
      packageId: (json['packageId'] as num?)?.toInt(),
      customTripRequestId: (json['customTripRequestId'] as num?)?.toInt(),
      type: json['type'] as String?,
      bookingStatus: json['bookingStatus'] as String?,
      paymentStatus: json['paymentStatus'] as String?,
      kycStatus: json['kycStatus'] as String?,
      amountGross: json['amountGross'] as num?,
      discountAmount: json['discountAmount'] as num?,
      discountPercent: json['discountPercent'] as num?,
      couponCode: json['couponCode'] as String?,
      commissionPercent: json['commissionPercent'] as num?,
      commissionAmount: json['commissionAmount'] as num?,
      stripeFee: json['stripeFee'] as num?,
      agentShare: json['agentShare'] as num?,
      currency: json['currency'] as String?,
      destinationCountryId: (json['destinationCountryId'] as num?)?.toInt(),
      startDate: json['startDate'] as String?,
      endDate: json['endDate'] as String?,
      travelerCount: (json['travelerCount'] as num?)?.toInt(),
      hotelChoiceId: (json['hotelChoiceId'] as num?)?.toInt(),
      selectedActivities: json['selectedActivities'],
      notes: json['notes'] as String?,
      adminNotes: json['adminNotes'] as String?,
      cancellationReason: json['cancellationReason'] as String?,
      cancelledBy: (json['cancelledBy'] as num?)?.toInt(),
      requestedAt: json['requestedAt'] as String?,
      priceConfirmedAt: json['priceConfirmedAt'] as String?,
      holdExpiresAt: json['holdExpiresAt'] as String?,
      paidAt: json['paidAt'] as String?,
      capturedAt: json['capturedAt'] as String?,
      confirmedAt: json['confirmedAt'] as String?,
      cancelledAt: json['cancelledAt'] as String?,
      createdAt: json['CreatedAt'] as String?,
      updatedAt: json['UpdatedAt'] as String?,
    );

Map<String, dynamic> _$BxMyBookingItemToJson(BxMyBookingItem instance) =>
    <String, dynamic>{
      'id': instance.id,
      'bookingCode': instance.bookingCode,
      'userId': instance.userId,
      'agentId': instance.agentId,
      'packageId': instance.packageId,
      'customTripRequestId': instance.customTripRequestId,
      'type': instance.type,
      'bookingStatus': instance.bookingStatus,
      'paymentStatus': instance.paymentStatus,
      'kycStatus': instance.kycStatus,
      'amountGross': instance.amountGross,
      'discountAmount': instance.discountAmount,
      'discountPercent': instance.discountPercent,
      'couponCode': instance.couponCode,
      'commissionPercent': instance.commissionPercent,
      'commissionAmount': instance.commissionAmount,
      'stripeFee': instance.stripeFee,
      'agentShare': instance.agentShare,
      'currency': instance.currency,
      'destinationCountryId': instance.destinationCountryId,
      'startDate': instance.startDate,
      'endDate': instance.endDate,
      'travelerCount': instance.travelerCount,
      'hotelChoiceId': instance.hotelChoiceId,
      'selectedActivities': instance.selectedActivities,
      'notes': instance.notes,
      'adminNotes': instance.adminNotes,
      'cancellationReason': instance.cancellationReason,
      'cancelledBy': instance.cancelledBy,
      'requestedAt': instance.requestedAt,
      'priceConfirmedAt': instance.priceConfirmedAt,
      'holdExpiresAt': instance.holdExpiresAt,
      'paidAt': instance.paidAt,
      'capturedAt': instance.capturedAt,
      'confirmedAt': instance.confirmedAt,
      'cancelledAt': instance.cancelledAt,
      'CreatedAt': instance.createdAt,
      'UpdatedAt': instance.updatedAt,
    };
