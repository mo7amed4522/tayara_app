// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bx_booking_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BxCreateBookingRequest _$BxCreateBookingRequestFromJson(
  Map<String, dynamic> json,
) => BxCreateBookingRequest(
  type: json['type'] as String,
  packageId: (json['packageId'] as num?)?.toInt(),
  customTripRequestId: (json['customTripRequestId'] as num?)?.toInt(),
  travelerCount: (json['travelerCount'] as num?)?.toInt() ?? 1,
  hotelChoiceID: (json['hotelChoiceId'] as num?)?.toInt(),
  selectedActivities: (json['selectedActivities'] as List<dynamic>?)
      ?.map((e) => (e as num).toInt())
      .toList(),
  notes: json['notes'] as String?,
  startDate: json['startDate'] as String?,
  endDate: json['endDate'] as String?,
  travelers: (json['travelers'] as List<dynamic>?)
      ?.map((e) => BxTravelerReq.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$BxCreateBookingRequestToJson(
  BxCreateBookingRequest instance,
) => <String, dynamic>{
  'type': instance.type,
  'packageId': instance.packageId,
  'customTripRequestId': instance.customTripRequestId,
  'travelerCount': instance.travelerCount,
  'hotelChoiceId': instance.hotelChoiceID,
  'selectedActivities': instance.selectedActivities,
  'notes': instance.notes,
  'startDate': instance.startDate,
  'endDate': instance.endDate,
  'travelers': instance.travelers,
};

BxTravelerReq _$BxTravelerReqFromJson(Map<String, dynamic> json) =>
    BxTravelerReq(
      fullName: json['fullName'] as String,
      dob: json['dob'] as String?,
      nationalityId: (json['nationalityId'] as num?)?.toInt(),
      passportNumber: json['passportNumber'] as String?,
      passportExpiry: json['passportExpiry'] as String?,
      adultOrChild: json['adultOrChild'] as String,
      email: json['email'] as String?,
    );

Map<String, dynamic> _$BxTravelerReqToJson(BxTravelerReq instance) =>
    <String, dynamic>{
      'fullName': instance.fullName,
      'dob': instance.dob,
      'nationalityId': instance.nationalityId,
      'passportNumber': instance.passportNumber,
      'passportExpiry': instance.passportExpiry,
      'adultOrChild': instance.adultOrChild,
      'email': instance.email,
    };

BxCancelBookingRequest _$BxCancelBookingRequestFromJson(
  Map<String, dynamic> json,
) => BxCancelBookingRequest(
  bookingId: (json['bookingId'] as num).toInt(),
  reason: json['reason'] as String?,
);

Map<String, dynamic> _$BxCancelBookingRequestToJson(
  BxCancelBookingRequest instance,
) => <String, dynamic>{
  'bookingId': instance.bookingId,
  'reason': instance.reason,
};
