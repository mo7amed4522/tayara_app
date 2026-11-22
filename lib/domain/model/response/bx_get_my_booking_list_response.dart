// File: lib/domain/model/response/bx_get_my_booking_list_response.dart
// Architecture: Domain Layer - Response Model
// Purpose: Model for the current user's booking list response

import 'package:json_annotation/json_annotation.dart';

part 'bx_get_my_booking_list_response.g.dart';

@JsonSerializable()
class BxGetMyBookingListResponse {
  @JsonKey(name: 'code')
  final int code;

  @JsonKey(name: 'data')
  final BxGetMyBookingListData? data;

  @JsonKey(name: 'msg')
  final String msg;

  BxGetMyBookingListResponse({
    required this.code,
    this.data,
    required this.msg,
  });

  factory BxGetMyBookingListResponse.fromJson(Map<String, dynamic> json) =>
      _$BxGetMyBookingListResponseFromJson(json);

  Map<String, dynamic> toJson() => _$BxGetMyBookingListResponseToJson(this);
}

@JsonSerializable()
class BxGetMyBookingListData {
  @JsonKey(name: 'list')
  final List<BxMyBookingItem> list;

  @JsonKey(name: 'total')
  final int total;

  @JsonKey(name: 'totalPage')
  final int totalPage;

  @JsonKey(name: 'page')
  final int page;

  @JsonKey(name: 'pageSize')
  final int pageSize;

  BxGetMyBookingListData({
    required this.list,
    required this.total,
    required this.totalPage,
    required this.page,
    required this.pageSize,
  });

  factory BxGetMyBookingListData.fromJson(Map<String, dynamic> json) =>
      _$BxGetMyBookingListDataFromJson(json);

  Map<String, dynamic> toJson() => _$BxGetMyBookingListDataToJson(this);
}

@JsonSerializable()
class BxMyBookingItem {
  @JsonKey(name: 'id')
  final int? id;

  @JsonKey(name: 'bookingCode')
  final String? bookingCode;

  @JsonKey(name: 'userId')
  final int? userId;

  @JsonKey(name: 'agentId')
  final int? agentId;

  @JsonKey(name: 'packageId')
  final int? packageId;

  @JsonKey(name: 'customTripRequestId')
  final int? customTripRequestId;

  @JsonKey(name: 'type')
  final String? type;

  @JsonKey(name: 'bookingStatus')
  final String? bookingStatus;

  @JsonKey(name: 'paymentStatus')
  final String? paymentStatus;

  @JsonKey(name: 'kycStatus')
  final String? kycStatus;

  @JsonKey(name: 'amountGross')
  final num? amountGross;

  @JsonKey(name: 'discountAmount')
  final num? discountAmount;

  @JsonKey(name: 'discountPercent')
  final num? discountPercent;

  @JsonKey(name: 'couponCode')
  final String? couponCode;

  @JsonKey(name: 'commissionPercent')
  final num? commissionPercent;

  @JsonKey(name: 'commissionAmount')
  final num? commissionAmount;

  @JsonKey(name: 'stripeFee')
  final num? stripeFee;

  @JsonKey(name: 'agentShare')
  final num? agentShare;

  @JsonKey(name: 'currency')
  final String? currency;

  @JsonKey(name: 'destinationCountryId')
  final int? destinationCountryId;

  @JsonKey(name: 'startDate')
  final String? startDate;

  @JsonKey(name: 'endDate')
  final String? endDate;

  @JsonKey(name: 'travelerCount')
  final int? travelerCount;

  @JsonKey(name: 'hotelChoiceId')
  final int? hotelChoiceId;

  @JsonKey(name: 'selectedActivities')
  final dynamic selectedActivities;

  @JsonKey(name: 'notes')
  final String? notes;

  @JsonKey(name: 'adminNotes')
  final String? adminNotes;

  @JsonKey(name: 'cancellationReason')
  final String? cancellationReason;

  @JsonKey(name: 'cancelledBy')
  final int? cancelledBy;

  @JsonKey(name: 'requestedAt')
  final String? requestedAt;

  @JsonKey(name: 'priceConfirmedAt')
  final String? priceConfirmedAt;

  @JsonKey(name: 'holdExpiresAt')
  final String? holdExpiresAt;

  @JsonKey(name: 'paidAt')
  final String? paidAt;

  @JsonKey(name: 'capturedAt')
  final String? capturedAt;

  @JsonKey(name: 'confirmedAt')
  final String? confirmedAt;

  @JsonKey(name: 'cancelledAt')
  final String? cancelledAt;

  @JsonKey(name: 'CreatedAt')
  final String? createdAt;

  @JsonKey(name: 'UpdatedAt')
  final String? updatedAt;

  BxMyBookingItem({
    this.id,
    this.bookingCode,
    this.userId,
    this.agentId,
    this.packageId,
    this.customTripRequestId,
    this.type,
    this.bookingStatus,
    this.paymentStatus,
    this.kycStatus,
    this.amountGross,
    this.discountAmount,
    this.discountPercent,
    this.couponCode,
    this.commissionPercent,
    this.commissionAmount,
    this.stripeFee,
    this.agentShare,
    this.currency,
    this.destinationCountryId,
    this.startDate,
    this.endDate,
    this.travelerCount,
    this.hotelChoiceId,
    this.selectedActivities,
    this.notes,
    this.adminNotes,
    this.cancellationReason,
    this.cancelledBy,
    this.requestedAt,
    this.priceConfirmedAt,
    this.holdExpiresAt,
    this.paidAt,
    this.capturedAt,
    this.confirmedAt,
    this.cancelledAt,
    this.createdAt,
    this.updatedAt,
  });

  factory BxMyBookingItem.fromJson(Map<String, dynamic> json) =>
      _$BxMyBookingItemFromJson(json);

  Map<String, dynamic> toJson() => _$BxMyBookingItemToJson(this);
}
