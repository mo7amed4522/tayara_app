// File: lib/domain/model/request/bx_get_my_booking_list_request.dart
// Architecture: Domain Layer - Request Model
// Purpose: Model for fetching the current user's booking list with pagination,
// status and type filters

import 'package:json_annotation/json_annotation.dart';

part 'bx_get_my_booking_list_request.g.dart';

@JsonSerializable()
class BxGetMyBookingListRequest {
  @JsonKey(name: 'page')
  final int page;

  @JsonKey(name: 'pageSize')
  final int pageSize;

  @JsonKey(name: 'status')
  final String? status;

  @JsonKey(name: 'type')
  final String? type;

  BxGetMyBookingListRequest({
    required this.page,
    required this.pageSize,
    this.status,
    this.type,
  });

  factory BxGetMyBookingListRequest.fromJson(Map<String, dynamic> json) =>
      _$BxGetMyBookingListRequestFromJson(json);

  Map<String, dynamic> toJson() => _$BxGetMyBookingListRequestToJson(this);
}
