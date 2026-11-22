// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bx_get_my_booking_list_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BxGetMyBookingListRequest _$BxGetMyBookingListRequestFromJson(
  Map<String, dynamic> json,
) => BxGetMyBookingListRequest(
  page: (json['page'] as num).toInt(),
  pageSize: (json['pageSize'] as num).toInt(),
  status: json['status'] as String?,
  type: json['type'] as String?,
);

Map<String, dynamic> _$BxGetMyBookingListRequestToJson(
  BxGetMyBookingListRequest instance,
) => <String, dynamic>{
  'page': instance.page,
  'pageSize': instance.pageSize,
  'status': instance.status,
  'type': instance.type,
};
