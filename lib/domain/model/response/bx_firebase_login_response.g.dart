// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bx_firebase_login_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BxFirebaseLoginResponse _$BxFirebaseLoginResponseFromJson(
  Map<String, dynamic> json,
) => BxFirebaseLoginResponse(
  code: (json['code'] as num?)?.toInt(),
  message: json['msg'] as String?,
  data: json['data'] == null
      ? null
      : BxFirebaseLoginData.fromJson(json['data'] as Map<String, dynamic>),
);

Map<String, dynamic> _$BxFirebaseLoginResponseToJson(
  BxFirebaseLoginResponse instance,
) => <String, dynamic>{
  'code': instance.code,
  'msg': instance.message,
  'data': instance.data,
};

BxFirebaseLoginData _$BxFirebaseLoginDataFromJson(Map<String, dynamic> json) =>
    BxFirebaseLoginData(
      user: json['user'] == null
          ? null
          : BxFirebaseUser.fromJson(json['user'] as Map<String, dynamic>),
      token: json['token'] as String?,
      expiresAt: (json['expiresAt'] as num?)?.toInt(),
    );

Map<String, dynamic> _$BxFirebaseLoginDataToJson(
  BxFirebaseLoginData instance,
) => <String, dynamic>{
  'user': instance.user,
  'token': instance.token,
  'expiresAt': instance.expiresAt,
};

BxFirebaseUser _$BxFirebaseUserFromJson(Map<String, dynamic> json) =>
    BxFirebaseUser(
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

Map<String, dynamic> _$BxFirebaseUserToJson(BxFirebaseUser instance) =>
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
