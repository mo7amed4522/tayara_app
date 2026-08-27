// Copyright (c) 2026 Tayara. All rights reserved.
//
// File: lib/domain/model/request/bx_booking_request.dart
// Architecture: Domain Layer - Booking Request Models
// Purpose: Models for booking API requests

import 'package:json_annotation/json_annotation.dart';

part 'bx_booking_request.g.dart';

@JsonSerializable()
class BxCreateBookingRequest {
  @JsonKey(name: 'type')
  final String type;

  @JsonKey(name: 'packageId')
  final int? packageId;

  @JsonKey(name: 'customTripRequestId')
  final int? customTripRequestId;

  @JsonKey(name: 'travelerCount')
  final int travelerCount;

  @JsonKey(name: 'hotelChoiceId')
  final int? hotelChoiceID;

  @JsonKey(name: 'selectedActivities')
  final List<int>? selectedActivities;

  @JsonKey(name: 'notes')
  final String? notes;

  @JsonKey(name: 'startDate')
  final String? startDate;

  @JsonKey(name: 'endDate')
  final String? endDate;

  @JsonKey(name: 'travelers')
  final List<BxTravelerReq>? travelers;

  BxCreateBookingRequest({
    required this.type,
    this.packageId,
    this.customTripRequestId,
    this.travelerCount = 1,
    this.hotelChoiceID,
    this.selectedActivities,
    this.notes,
    this.startDate,
    this.endDate,
    this.travelers,
  });

  factory BxCreateBookingRequest.fromJson(Map<String, dynamic> json) =>
      _$BxCreateBookingRequestFromJson(json);

  Map<String, dynamic> toJson() => _$BxCreateBookingRequestToJson(this);
}

@JsonSerializable()
class BxTravelerReq {
  @JsonKey(name: 'fullName')
  final String fullName;

  @JsonKey(name: 'dob')
  final String? dob;

  @JsonKey(name: 'nationalityId')
  final int? nationalityId;

  @JsonKey(name: 'passportNumber')
  final String? passportNumber;

  @JsonKey(name: 'passportExpiry')
  final String? passportExpiry;

  @JsonKey(name: 'adultOrChild')
  final String adultOrChild;

  @JsonKey(name: 'email')
  final String? email;

  BxTravelerReq({
    required this.fullName,
    this.dob,
    this.nationalityId,
    this.passportNumber,
    this.passportExpiry,
    required this.adultOrChild,
    this.email,
  });

  factory BxTravelerReq.fromJson(Map<String, dynamic> json) =>
      _$BxTravelerReqFromJson(json);

  Map<String, dynamic> toJson() => _$BxTravelerReqToJson(this);
}

@JsonSerializable()
class BxCancelBookingRequest {
  @JsonKey(name: 'bookingId')
  final int bookingId;

  @JsonKey(name: 'reason')
  final String? reason;

  BxCancelBookingRequest({required this.bookingId, this.reason});

  factory BxCancelBookingRequest.fromJson(Map<String, dynamic> json) =>
      _$BxCancelBookingRequestFromJson(json);

  Map<String, dynamic> toJson() => _$BxCancelBookingRequestToJson(this);
}
