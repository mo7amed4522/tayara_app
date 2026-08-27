// Copyright (c) 2026 Tayara. All rights reserved.
//
// File: lib/domain/model/response/bx_booking_response.dart
// Architecture: Domain Layer - Booking Response Models
// Purpose: Models for booking API responses

import 'package:json_annotation/json_annotation.dart';

part 'bx_booking_response.g.dart';

@JsonSerializable()
class BxBookingListResponse {
  @JsonKey(name: 'code')
  final int? code;

  @JsonKey(name: 'msg')
  final String? message;

  @JsonKey(name: 'data')
  final BxBookingListData? data;

  BxBookingListResponse({this.code, this.message, this.data});

  factory BxBookingListResponse.fromJson(Map<String, dynamic> json) =>
      _$BxBookingListResponseFromJson(json);

  Map<String, dynamic> toJson() => _$BxBookingListResponseToJson(this);
}

@JsonSerializable()
class BxBookingItem {
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

  @JsonKey(name: 'type')
  final String? type;

  @JsonKey(name: 'bookingStatus')
  final String? bookingStatus;

  @JsonKey(name: 'paymentStatus')
  final String? paymentStatus;

  @JsonKey(name: 'amountGross')
  final int? amountGross;

  @JsonKey(name: 'discountPercent')
  final int? discountPercent;

  @JsonKey(name: 'currency')
  final String? currency;

  @JsonKey(name: 'destinationCountryId')
  final int? destinationCountryId;

  @JsonKey(name: 'travelerCount')
  final int? travelerCount;

  @JsonKey(name: 'notes')
  final String? notes;

  @JsonKey(name: 'startDate')
  final String? startDate;

  @JsonKey(name: 'endDate')
  final String? endDate;

  @JsonKey(name: 'requestedAt')
  final String? requestedAt;

  @JsonKey(name: 'updatedAt')
  final String? updatedAt;

  BxBookingItem({
    this.id,
    this.bookingCode,
    this.userId,
    this.agentId,
    this.packageId,
    this.type,
    this.bookingStatus,
    this.paymentStatus,
    this.amountGross,
    this.discountPercent,
    this.currency,
    this.destinationCountryId,
    this.travelerCount,
    this.notes,
    this.startDate,
    this.endDate,
    this.requestedAt,
    this.updatedAt,
  });

  factory BxBookingItem.fromJson(Map<String, dynamic> json) =>
      _$BxBookingItemFromJson(json);

  Map<String, dynamic> toJson() => _$BxBookingItemToJson(this);
}

@JsonSerializable()
class BxBookingDetailResponse {
  @JsonKey(name: 'code')
  final int? code;

  @JsonKey(name: 'msg')
  final String? message;

  @JsonKey(name: 'data')
  final BxBookingDetailData? data;

  BxBookingDetailResponse({this.code, this.message, this.data});

  factory BxBookingDetailResponse.fromJson(Map<String, dynamic> json) =>
      _$BxBookingDetailResponseFromJson(json);

  Map<String, dynamic> toJson() => _$BxBookingDetailResponseToJson(this);
}

@JsonSerializable()
class BxBookingDetailData {
  @JsonKey(name: 'booking')
  final BxBookingItem? booking;

  @JsonKey(name: 'travelers')
  final List<BxBookingTraveler>? travelers;

  @JsonKey(name: 'offers')
  final List<BxBookingOffer>? offers;

  @JsonKey(name: 'documents')
  final List<BxBookingDocument>? documents;

  @JsonKey(name: 'statusHistory')
  final List<BxBookingStatusHistory>? statusHistory;

  BxBookingDetailData({
    this.booking,
    this.travelers,
    this.offers,
    this.documents,
    this.statusHistory,
  });

  factory BxBookingDetailData.fromJson(Map<String, dynamic> json) =>
      _$BxBookingDetailDataFromJson(json);

  Map<String, dynamic> toJson() => _$BxBookingDetailDataToJson(this);
}

@JsonSerializable()
class BxBookingTraveler {
  @JsonKey(name: 'id')
  final int? id;

  @JsonKey(name: 'bookingId')
  final int? bookingId;

  @JsonKey(name: 'isBooker')
  final bool? isBooker;

  @JsonKey(name: 'fullName')
  final String? fullName;

  @JsonKey(name: 'dob')
  final String? dob;

  @JsonKey(name: 'nationalityId')
  final int? nationalityId;

  @JsonKey(name: 'passportNumber')
  final String? passportNumber;

  @JsonKey(name: 'passportExpiry')
  final String? passportExpiry;

  @JsonKey(name: 'adultOrChild')
  final String? adultOrChild;

  @JsonKey(name: 'email')
  final String? email;

  @JsonKey(name: 'docStatus')
  final String? docStatus;

  BxBookingTraveler({
    this.id,
    this.bookingId,
    this.isBooker,
    this.fullName,
    this.dob,
    this.nationalityId,
    this.passportNumber,
    this.passportExpiry,
    this.adultOrChild,
    this.email,
    this.docStatus,
  });

  factory BxBookingTraveler.fromJson(Map<String, dynamic> json) =>
      _$BxBookingTravelerFromJson(json);

  Map<String, dynamic> toJson() => _$BxBookingTravelerToJson(this);
}

@JsonSerializable()
class BxBookingOffer {
  @JsonKey(name: 'id')
  final int? id;

  @JsonKey(name: 'bookingId')
  final int? bookingId;

  @JsonKey(name: 'agentId')
  final int? agentId;

  @JsonKey(name: 'finalPrice')
  final int? finalPrice;

  @JsonKey(name: 'availableDates')
  final String? availableDates;

  @JsonKey(name: 'notes')
  final String? notes;

  @JsonKey(name: 'status')
  final String? status;

  @JsonKey(name: 'offeredAt')
  final String? offeredAt;

  @JsonKey(name: 'expiresAt')
  final String? expiresAt;

  BxBookingOffer({
    this.id,
    this.bookingId,
    this.agentId,
    this.finalPrice,
    this.availableDates,
    this.notes,
    this.status,
    this.offeredAt,
    this.expiresAt,
  });

  factory BxBookingOffer.fromJson(Map<String, dynamic> json) =>
      _$BxBookingOfferFromJson(json);

  Map<String, dynamic> toJson() => _$BxBookingOfferToJson(this);
}

@JsonSerializable()
class BxBookingDocument {
  @JsonKey(name: 'id')
  final int? id;

  @JsonKey(name: 'bookingId')
  final int? bookingId;

  @JsonKey(name: 'documentType')
  final String? documentType;

  @JsonKey(name: 'fileUrl')
  final String? fileUrl;

  @JsonKey(name: 'status')
  final String? status;

  @JsonKey(name: 'uploadedAt')
  final String? uploadedAt;

  BxBookingDocument({
    this.id,
    this.bookingId,
    this.documentType,
    this.fileUrl,
    this.status,
    this.uploadedAt,
  });

  factory BxBookingDocument.fromJson(Map<String, dynamic> json) =>
      _$BxBookingDocumentFromJson(json);

  Map<String, dynamic> toJson() => _$BxBookingDocumentToJson(this);
}

@JsonSerializable()
class BxBookingStatusHistory {
  @JsonKey(name: 'id')
  final int? id;

  @JsonKey(name: 'bookingId')
  final int? bookingId;

  @JsonKey(name: 'actorType')
  final String? actorType;

  @JsonKey(name: 'actorId')
  final int? actorId;

  @JsonKey(name: 'fromStatus')
  final String? fromStatus;

  @JsonKey(name: 'toStatus')
  final String? toStatus;

  @JsonKey(name: 'notes')
  final String? notes;

  @JsonKey(name: 'createdAt')
  final String? createdAt;

  BxBookingStatusHistory({
    this.id,
    this.bookingId,
    this.actorType,
    this.actorId,
    this.fromStatus,
    this.toStatus,
    this.notes,
    this.createdAt,
  });

  factory BxBookingStatusHistory.fromJson(Map<String, dynamic> json) =>
      _$BxBookingStatusHistoryFromJson(json);

  Map<String, dynamic> toJson() => _$BxBookingStatusHistoryToJson(this);
}

// ── Booking List Data ────────────────────────────────────────────────────────

@JsonSerializable()
class BxBookingListData {
  @JsonKey(name: 'list')
  final List<BxBookingItem>? list;

  @JsonKey(name: 'total')
  final int? total;

  @JsonKey(name: 'totalPage')
  final int? totalPage;

  @JsonKey(name: 'page')
  final int? page;

  @JsonKey(name: 'pageSize')
  final int? pageSize;

  BxBookingListData({
    this.list,
    this.total,
    this.totalPage,
    this.page,
    this.pageSize,
  });

  factory BxBookingListData.fromJson(Map<String, dynamic> json) =>
      _$BxBookingListDataFromJson(json);

  Map<String, dynamic> toJson() => _$BxBookingListDataToJson(this);
}
