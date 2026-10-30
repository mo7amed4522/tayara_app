// File: lib/domain/model/request/bx_get_package_detail_request.dart
// Architecture: Domain Layer - Request Model
// Purpose: Model for fetching a package detail by id

import 'package:json_annotation/json_annotation.dart';

part 'bx_get_package_detail_request.g.dart';

@JsonSerializable()
class BxGetPackageDetailRequest {
  @JsonKey(name: 'id')
  final int id;

  BxGetPackageDetailRequest({required this.id});

  factory BxGetPackageDetailRequest.fromJson(Map<String, dynamic> json) =>
      _$BxGetPackageDetailRequestFromJson(json);

  Map<String, dynamic> toJson() => _$BxGetPackageDetailRequestToJson(this);
}
