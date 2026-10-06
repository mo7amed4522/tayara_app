// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bx_login_user_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BxLoginUserResponse _$BxLoginUserResponseFromJson(Map<String, dynamic> json) =>
    BxLoginUserResponse(
      code: (json['code'] as num).toInt(),
      data: json['data'] == null
          ? null
          : BxLoginUserData.fromJson(json['data'] as Map<String, dynamic>),
      msg: json['msg'] as String,
    );

Map<String, dynamic> _$BxLoginUserResponseToJson(
  BxLoginUserResponse instance,
) => <String, dynamic>{
  'code': instance.code,
  'data': instance.data,
  'msg': instance.msg,
};

BxLoginUserData _$BxLoginUserDataFromJson(Map<String, dynamic> json) =>
    BxLoginUserData(
      user: json['user'] == null
          ? null
          : BxLoginUser.fromJson(json['user'] as Map<String, dynamic>),
      token: json['token'] as String?,
      expiresAt: (json['expiresAt'] as num?)?.toInt(),
    );

Map<String, dynamic> _$BxLoginUserDataToJson(BxLoginUserData instance) =>
    <String, dynamic>{
      'user': instance.user,
      'token': instance.token,
      'expiresAt': instance.expiresAt,
    };

BxLoginUser _$BxLoginUserFromJson(Map<String, dynamic> json) => BxLoginUser(
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
  totalSpend: json['totalSpend'] as num?,
  status: json['status'] as String?,
  blockReason: json['blockReason'] as String?,
  lastLoginAt: json['lastLoginAt'] as String?,
  firebaseUid: json['firebaseUid'] as String?,
  authProvider: json['authProvider'] as String?,
  createdAt: json['CreatedAt'] as String?,
  updatedAt: json['UpdatedAt'] as String?,
);

Map<String, dynamic> _$BxLoginUserToJson(BxLoginUser instance) =>
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
