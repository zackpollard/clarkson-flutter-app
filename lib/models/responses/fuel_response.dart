import 'dart:convert';

FuelResponse fuelResponseFromJson(String str) => FuelResponse.fromJson(json.decode(str));

String fuelResponseToJson(FuelResponse data) => json.encode(data.toJson());

class FuelResponse {
  List<Fuel> fuel;

  FuelResponse({
    this.fuel,
  });

  factory FuelResponse.fromJson(Map<String, dynamic> json) => new FuelResponse(
    fuel: new List<Fuel>.from(json["fuel"].map((x) => Fuel.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "fuel": new List<dynamic>.from(fuel.map((x) => x.toJson())),
  };
}

class Fuel {
  String id;
  String vehicle;
  DateTime date;
  double fuelAmount;
  double totalCost;
  double fuelUnitCost;
  dynamic locationLatitude;
  dynamic locationLongitude;
  int tripDistance;
  int odometerReading;
  dynamic notes;
  bool fullTank;
  bool missedFillUp;

  Fuel({
    this.id,
    this.vehicle,
    this.date,
    this.fuelAmount,
    this.totalCost,
    this.fuelUnitCost,
    this.locationLatitude,
    this.locationLongitude,
    this.tripDistance,
    this.odometerReading,
    this.notes,
    this.fullTank,
    this.missedFillUp,
  });

  factory Fuel.fromJson(Map<String, dynamic> json) => new Fuel(
    id: json["id"],
    vehicle: json["vehicle"],
    date: DateTime.parse(json["date"]),
    fuelAmount: json["fuelAmount"].toDouble(),
    totalCost: json["totalCost"].toDouble(),
    fuelUnitCost: json["fuelUnitCost"].toDouble(),
    locationLatitude: json["locationLatitude"],
    locationLongitude: json["locationLongitude"],
    tripDistance: json["tripDistance"],
    odometerReading: json["odometerReading"],
    notes: json["notes"],
    fullTank: json["fullTank"],
    missedFillUp: json["missedFillUp"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "vehicle": vehicle,
    "date": date.toIso8601String(),
    "fuelAmount": fuelAmount,
    "totalCost": totalCost,
    "fuelUnitCost": fuelUnitCost,
    "locationLatitude": locationLatitude,
    "locationLongitude": locationLongitude,
    "tripDistance": tripDistance,
    "odometerReading": odometerReading,
    "notes": notes,
    "fullTank": fullTank,
    "missedFillUp": missedFillUp,
  };
}
