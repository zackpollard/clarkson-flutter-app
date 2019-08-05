import 'dart:convert';

VehicleResponse vehicleResponseFromJson(String str) => VehicleResponse.fromJson(json.decode(str));

String vehicleResponseToJson(VehicleResponse data) => json.encode(data.toJson());

class VehicleResponse {
  List<Vehicle> vehicles;

  VehicleResponse({
    this.vehicles,
  });

  factory VehicleResponse.fromJson(Map<String, dynamic> json) => new VehicleResponse(
    vehicles: new List<Vehicle>.from(json["vehicles"].map((x) => Vehicle.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "vehicles": new List<dynamic>.from(vehicles.map((x) => x.toJson())),
  };
}

class Vehicle {
  String id;
  String user;
  String name;
  String registration;
  String make;
  String model;
  dynamic picture;
  int yearOfManufacture;
  dynamic vin;
  int engineSizeCc;
  int fuelType;

  Vehicle({
    this.id,
    this.user,
    this.name,
    this.registration,
    this.make,
    this.model,
    this.picture,
    this.yearOfManufacture,
    this.vin,
    this.engineSizeCc,
    this.fuelType,
  });

  factory Vehicle.fromJson(Map<String, dynamic> json) => new Vehicle(
    id: json["id"],
    user: json["user"],
    name: json["name"],
    registration: json["registration"],
    make: json["make"],
    model: json["model"],
    picture: json["picture"],
    yearOfManufacture: json["yearOfManufacture"],
    vin: json["vin"],
    engineSizeCc: json["engineSizeCC"],
    fuelType: json["fuelType"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "user": user,
    "name": name,
    "registration": registration,
    "make": make,
    "model": model,
    "picture": picture,
    "yearOfManufacture": yearOfManufacture,
    "vin": vin,
    "engineSizeCC": engineSizeCc,
    "fuelType": fuelType,
  };
}
