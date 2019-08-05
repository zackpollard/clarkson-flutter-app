import 'dart:convert';

AuthenticateResponse authenticateResponseFromJson(String str) => AuthenticateResponse.fromJson(json.decode(str));

String authenticateResponseToJson(AuthenticateResponse data) => json.encode(data.toJson());

class AuthenticateResponse {
  String token;
  String status;
  String message;

  AuthenticateResponse({
    this.token,
    this.status,
    this.message,
  });

  factory AuthenticateResponse.fromJson(Map<String, dynamic> json) => new AuthenticateResponse(
    token: json["token"] == null ? null : json["token"],
    status: json["status"] == null ? null : json["status"],
    message: json["message"] == null ? null : json["message"],
  );

  Map<String, dynamic> toJson() => {
    "token": token == null ? null : token,
    "status": status == null ? null : status,
    "message": message == null ? null : message,
  };
}
