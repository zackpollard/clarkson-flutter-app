import 'dart:convert';

UserResponse welcomeFromJson(String str) => UserResponse.fromJson(json.decode(str));

String welcomeToJson(UserResponse data) => json.encode(data.toJson());

class UserResponse {
  User user;

  UserResponse({
    this.user,
  });

  factory UserResponse.fromJson(Map<String, dynamic> json) => new UserResponse(
    user: User.fromJson(json["user"]),
  );

  Map<String, dynamic> toJson() => {
    "user": user.toJson(),
  };
}

class User {
  String id;
  String email;
  String username;
  bool admin;
  Preferences preferences;

  User({
    this.id,
    this.email,
    this.username,
    this.admin,
    this.preferences,
  });

  factory User.fromJson(Map<String, dynamic> json) => new User(
    id: json["id"],
    email: json["email"],
    username: json["username"],
    admin: json["admin"],
    preferences: Preferences.fromJson(json["preferences"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "email": email,
    "username": username,
    "admin": admin,
    "preferences": preferences.toJson(),
  };
}

class Preferences {
  Unit fuelUnit;
  Unit distanceUnit;
  Unit fuelConsumptionUnit;
  Unit currencyUnit;

  Preferences({
    this.fuelUnit,
    this.distanceUnit,
    this.fuelConsumptionUnit,
    this.currencyUnit,
  });

  factory Preferences.fromJson(Map<String, dynamic> json) => new Preferences(
    fuelUnit: Unit.fromJson(json["fuelUnit"]),
    distanceUnit: Unit.fromJson(json["distanceUnit"]),
    fuelConsumptionUnit: Unit.fromJson(json["fuelConsumptionUnit"]),
    currencyUnit: Unit.fromJson(json["currencyUnit"]),
  );

  Map<String, dynamic> toJson() => {
    "fuelUnit": fuelUnit.toJson(),
    "distanceUnit": distanceUnit.toJson(),
    "fuelConsumptionUnit": fuelConsumptionUnit.toJson(),
    "currencyUnit": currencyUnit.toJson(),
  };
}

class Unit {
  int id;
  String unit;
  String unitName;
  String symbol;

  Unit({
    this.id,
    this.unit,
    this.unitName,
    this.symbol,
  });

  factory Unit.fromJson(Map<String, dynamic> json) => new Unit(
    id: json["id"],
    unit: json["unit"],
    unitName: json["unitName"],
    symbol: json["symbol"] == null ? null : json["symbol"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "unit": unit,
    "unitName": unitName,
    "symbol": symbol == null ? null : symbol,
  };
}
