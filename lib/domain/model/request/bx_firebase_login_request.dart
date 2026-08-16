// File: lib/domain/model/request/bx_firebase_login_request.dart
// Architecture: Domain Layer - Request Model
// Purpose: Model for Firebase login request

import 'package:json_annotation/json_annotation.dart';

part 'bx_firebase_login_request.g.dart';

@JsonSerializable()
class BxFirebaseLoginRequest {
  @JsonKey(name: 'idToken')
  final String idToken;

  BxFirebaseLoginRequest({required this.idToken});

  factory BxFirebaseLoginRequest.fromJson(Map<String, dynamic> json) => _$BxFirebaseLoginRequestFromJson(json);

  Map<String, dynamic> toJson() => _$BxFirebaseLoginRequestToJson(this);
}
