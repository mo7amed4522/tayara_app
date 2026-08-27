// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bx_home_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BxCustomerSearchRequest _$BxCustomerSearchRequestFromJson(
  Map<String, dynamic> json,
) => BxCustomerSearchRequest(
  keyword: json['keyword'] as String,
  page: (json['page'] as num?)?.toInt() ?? 1,
  pageSize: (json['pageSize'] as num?)?.toInt() ?? 10,
);

Map<String, dynamic> _$BxCustomerSearchRequestToJson(
  BxCustomerSearchRequest instance,
) => <String, dynamic>{
  'keyword': instance.keyword,
  'page': instance.page,
  'pageSize': instance.pageSize,
};

BxCustomerExploreRequest _$BxCustomerExploreRequestFromJson(
  Map<String, dynamic> json,
) => BxCustomerExploreRequest(
  category: json['category'] as String?,
  page: (json['page'] as num?)?.toInt() ?? 1,
  pageSize: (json['pageSize'] as num?)?.toInt() ?? 12,
);

Map<String, dynamic> _$BxCustomerExploreRequestToJson(
  BxCustomerExploreRequest instance,
) => <String, dynamic>{
  'category': instance.category,
  'page': instance.page,
  'pageSize': instance.pageSize,
};

BxCustomerDealsRequest _$BxCustomerDealsRequestFromJson(
  Map<String, dynamic> json,
) => BxCustomerDealsRequest(
  category: json['category'] as String?,
  page: (json['page'] as num?)?.toInt() ?? 1,
  pageSize: (json['pageSize'] as num?)?.toInt() ?? 12,
);

Map<String, dynamic> _$BxCustomerDealsRequestToJson(
  BxCustomerDealsRequest instance,
) => <String, dynamic>{
  'category': instance.category,
  'page': instance.page,
  'pageSize': instance.pageSize,
};

BxCustomerAgentDetailRequest _$BxCustomerAgentDetailRequestFromJson(
  Map<String, dynamic> json,
) => BxCustomerAgentDetailRequest(
  agentId: (json['agentId'] as num).toInt(),
  destinationCountryId: (json['destinationCountryId'] as num?)?.toInt(),
  page: (json['page'] as num?)?.toInt() ?? 1,
  pageSize: (json['pageSize'] as num?)?.toInt() ?? 12,
);

Map<String, dynamic> _$BxCustomerAgentDetailRequestToJson(
  BxCustomerAgentDetailRequest instance,
) => <String, dynamic>{
  'agentId': instance.agentId,
  'destinationCountryId': instance.destinationCountryId,
  'page': instance.page,
  'pageSize': instance.pageSize,
};
