import 'dart:convert';

MonthlyFuelCostsResponse monthlyFuelCostsResponseFromJson(String str) => MonthlyFuelCostsResponse.fromJson(json.decode(str));

String monthlyFuelCostsResponseToJson(MonthlyFuelCostsResponse data) => json.encode(data.toJson());

class MonthlyFuelCostsResponse {
  List<MonthlyFuelCost> monthlyFuelCosts;

  MonthlyFuelCostsResponse({
    this.monthlyFuelCosts,
  });

  factory MonthlyFuelCostsResponse.fromJson(Map<String, dynamic> json) => new MonthlyFuelCostsResponse(
    monthlyFuelCosts: new List<MonthlyFuelCost>.from(json["monthlyFuelCosts"].map((x) => MonthlyFuelCost.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "monthlyFuelCosts": new List<dynamic>.from(monthlyFuelCosts.map((x) => x.toJson())),
  };
}

class MonthlyFuelCost {
  String vehicle;
  int month;
  int year;
  double totalCost;

  MonthlyFuelCost({
    this.vehicle,
    this.month,
    this.year,
    this.totalCost,
  });

  factory MonthlyFuelCost.fromJson(Map<String, dynamic> json) => new MonthlyFuelCost(
    vehicle: json["vehicle"],
    month: json["month"],
    year: json["year"],
    totalCost: json["totalCost"].toDouble(),
  );

  Map<String, dynamic> toJson() => {
    "vehicle": vehicle,
    "month": month,
    "year": year,
    "totalCost": totalCost,
  };
}
