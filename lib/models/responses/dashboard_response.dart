import 'dart:convert';

DashboardResponse dashboardResponseFromJson(String str) => DashboardResponse.fromJson(json.decode(str));

String dashboardResponseToJson(DashboardResponse data) => json.encode(data.toJson());

class DashboardResponse {
  List<TopStat> topStats;

  DashboardResponse({
    this.topStats,
  });

  factory DashboardResponse.fromJson(Map<String, dynamic> json) => new DashboardResponse(
    topStats: new List<TopStat>.from(json["topStats"].map((x) => TopStat.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "topStats": new List<dynamic>.from(topStats.map((x) => x.toJson())),
  };
}

class TopStat {
  int totalDistance;
  int totalFillUps;
  double totalSpent;

  TopStat({
    this.totalDistance,
    this.totalFillUps,
    this.totalSpent,
  });

  factory TopStat.fromJson(Map<String, dynamic> json) => new TopStat(
    totalDistance: json["totalDistance"],
    totalFillUps: json["totalFillUps"],
    totalSpent: json["totalSpent"].toDouble(),
  );

  Map<String, dynamic> toJson() => {
    "totalDistance": totalDistance,
    "totalFillUps": totalFillUps,
    "totalSpent": totalSpent,
  };
}
