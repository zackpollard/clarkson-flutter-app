import 'dart:convert';

AuthenticateRequest authenticateRequestFromJson(String str) => AuthenticateRequest.fromJson(json.decode(str));

String authenticateRequestToJson(AuthenticateRequest data) => json.encode(data.toJson());

class AuthenticateRequest {
  String username;
  String password;

  AuthenticateRequest({
    this.username,
    this.password,
  });

  factory AuthenticateRequest.fromJson(Map<String, dynamic> json) => new AuthenticateRequest(
    username: json["username"],
    password: json["password"],
  );

  Map<String, dynamic> toJson() => {
    "username": username,
    "password": password,
  };
}