// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_sign_in.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserSignIn _$UserSignInFromJson(Map<String, dynamic> json) => UserSignIn(
      id: json['id'] as int?,
      name: json['name'] as String,
      username: json['username'] as String,
      email: json['email'] as String,
      token: json['api_token'] as String,
    );

Map<String, dynamic> _$UserSignInToJson(UserSignIn instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'username': instance.username,
      'email': instance.email,
      'api_token': instance.token,
    };
