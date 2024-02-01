import 'package:json_annotation/json_annotation.dart';

part 'user_sign_in.g.dart';

@JsonSerializable()
class UserSignIn {
  final String name;
  final String username;
  final String email;
  @JsonKey(name: 'api_token')
  final String apiToken;

  UserSignIn(
      {required this.name,
      required this.username,
      required this.email,
      required this.apiToken});

  factory UserSignIn.fromJson(Map<String, dynamic> json) =>
      _$UserSignInFromJson(json);

  Map<String, dynamic> toJson() => _$UserSignInToJson(this);
}
