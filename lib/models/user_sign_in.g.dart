// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_sign_in.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserSignIn _$UserSignInFromJson(Map<String, dynamic> json) => UserSignIn(
      name: json['name'] as String,
      username: json['username'] as String,
      email: json['email'] as String,
      apiToken: json['api_token'] as String,
    );

Map<String, dynamic> _$UserSignInToJson(UserSignIn instance) =>
    <String, dynamic>{
      'name': instance.name,
      'username': instance.username,
      'email': instance.email,
      'api_token': instance.apiToken,
    };
