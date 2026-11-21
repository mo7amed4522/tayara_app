// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bx_get_user_data_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BxGetUserDataResponse _$BxGetUserDataResponseFromJson(
  Map<String, dynamic> json,
) => BxGetUserDataResponse(
  code: (json['code'] as num).toInt(),
  data: json['data'] == null
      ? null
      : BxGetUserData.fromJson(json['data'] as Map<String, dynamic>),
  msg: json['msg'] as String,
);

Map<String, dynamic> _$BxGetUserDataResponseToJson(
  BxGetUserDataResponse instance,
) => <String, dynamic>{
  'code': instance.code,
  'data': instance.data,
  'msg': instance.msg,
};

BxGetUserData _$BxGetUserDataFromJson(Map<String, dynamic> json) =>
    BxGetUserData(
      user: json['user'] == null
          ? null
          : BxGetUserDataUser.fromJson(json['user'] as Map<String, dynamic>),
      pastTrips: (json['pastTrips'] as num?)?.toInt(),
      upcoming: (json['upcoming'] as num?)?.toInt(),
      favorites: (json['favorites'] as num?)?.toInt(),
    );

Map<String, dynamic> _$BxGetUserDataToJson(BxGetUserData instance) =>
    <String, dynamic>{
      'user': instance.user,
      'pastTrips': instance.pastTrips,
      'upcoming': instance.upcoming,
      'favorites': instance.favorites,
    };

BxGetUserDataUser _$BxGetUserDataUserFromJson(Map<String, dynamic> json) =>
    BxGetUserDataUser(
      id: (json['id'] as num?)?.toInt(),
      fullName: json['fullName'] as String?,
      userName: json['userName'] as String?,
      nickName: json['nickName'] as String?,
      headerImg: json['headerImg'] as String?,
      phoneCountryCode: json['phoneCountryCode'] as String?,
      phone: json['phone'] as String?,
      email: json['email'] as String?,
      nationality: json['nationality'] as String?,
      dateOfBirth: json['dateOfBirth'] as String?,
      kycStatus: json['kycStatus'] as String?,
      totalSpend: (json['totalSpend'] as num?)?.toInt(),
      status: json['status'] as String?,
      blockReason: json['blockReason'] as String?,
      lastLoginAt: json['lastLoginAt'] as String?,
      firebaseUid: json['firebaseUid'] as String?,
      authProvider: json['authProvider'] as String?,
      createdAt: json['CreatedAt'] as String?,
      updatedAt: json['UpdatedAt'] as String?,
    );

Map<String, dynamic> _$BxGetUserDataUserToJson(BxGetUserDataUser instance) =>
    <String, dynamic>{
      'id': instance.id,
      'fullName': instance.fullName,
      'userName': instance.userName,
      'nickName': instance.nickName,
      'headerImg': instance.headerImg,
      'phoneCountryCode': instance.phoneCountryCode,
      'phone': instance.phone,
      'email': instance.email,
      'nationality': instance.nationality,
      'dateOfBirth': instance.dateOfBirth,
      'kycStatus': instance.kycStatus,
      'totalSpend': instance.totalSpend,
      'status': instance.status,
      'blockReason': instance.blockReason,
      'lastLoginAt': instance.lastLoginAt,
      'firebaseUid': instance.firebaseUid,
      'authProvider': instance.authProvider,
      'CreatedAt': instance.createdAt,
      'UpdatedAt': instance.updatedAt,
    };
