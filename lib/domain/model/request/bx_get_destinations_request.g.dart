// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bx_get_destinations_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BxGetDestinationsRequest _$BxGetDestinationsRequestFromJson(
  Map<String, dynamic> json,
) => BxGetDestinationsRequest(
  page: (json['page'] as num).toInt(),
  pageSize: (json['pageSize'] as num).toInt(),
);

Map<String, dynamic> _$BxGetDestinationsRequestToJson(
  BxGetDestinationsRequest instance,
) => <String, dynamic>{'page': instance.page, 'pageSize': instance.pageSize};
