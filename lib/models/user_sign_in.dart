import 'package:json_annotation/json_annotation.dart';

part 'user_sign_in.g.dart';

@JsonSerializable()
class UserSignIn {
  late int? id;
  late String name;
  late String username;
  late String email;
  @JsonKey(name: 'api_token')
  late String token;

  UserSignIn(
      {this.id,
      required this.name,
      required this.username,
      required this.email,
      required this.token});

  factory UserSignIn.fromJson(Map<String, dynamic> json) =>
      _$UserSignInFromJson(json);

  Map<String, dynamic> toJson() => _$UserSignInToJson(this);
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'username': username,
      'email': email,
      'token': token,
    };
  }

  UserSignIn.fromStorage(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    username = json['username'];
    email = json['email'];
    token = json['token'];
  }
}
