import 'package:json_annotation/json_annotation.dart';

import 'package:e_commerce_app/core/storage/auth_tokens.dart';

part 'login_response.g.dart';

@JsonSerializable(createToJson: false)
class LoginResponse {
  const LoginResponse({
    required this.id,
    required this.username,
    required this.accessToken,
    required this.refreshToken,
    this.email,
    this.firstName,
    this.lastName,
    this.image,
  });

  factory LoginResponse.fromJson(Map<String, dynamic> json) =>
      _$LoginResponseFromJson(json);

  final int id;
  final String username;
  final String accessToken;
  final String refreshToken;
  final String? email;
  final String? firstName;
  final String? lastName;
  final String? image;

  AuthTokens get tokens {
    return AuthTokens(accessToken: accessToken, refreshToken: refreshToken);
  }
}
