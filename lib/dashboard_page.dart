import 'package:clarkson/http/user_api.dart';
import 'package:flutter/material.dart';
import 'package:html_unescape/html_unescape.dart';

import 'http/dashboard_api.dart';
import 'http/vehicle_api.dart';
import 'models/responses/dashboard_response.dart';
import 'models/responses/user_response.dart';
import 'models/responses/vehicle_response.dart';

class DashboardPage extends StatefulWidget {
  static String tag = 'dashboard-page';
  @override
  DashboardPageState createState() => DashboardPageState();
}

class DashboardData {
  final DashboardResponse dashboardResponse;
  final UserResponse userResponse;
  final VehicleResponse vehicleResponse;

  DashboardData(this.dashboardResponse, this.userResponse, this.vehicleResponse);
}

class DashboardPageState extends State<DashboardPage> {
  final DashboardApiProvider _dashboardApiProvider = DashboardApiProvider();
  final UserApiProvider _userApiProvider = UserApiProvider();
  final VehicleApiProvider _vehicleApiProvider = VehicleApiProvider();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(future: new Future(() async {

      Future<DashboardResponse> dashboardFuture = _dashboardApiProvider.getDashboard();
      Future<UserResponse> userFuture = _userApiProvider.getUser();
      Future<VehicleResponse> vehicleFuture = _vehicleApiProvider.getVehicle();

      return DashboardData(await dashboardFuture, await userFuture, await vehicleFuture);
    }),
      builder: (BuildContext context, AsyncSnapshot<DashboardData> response) {
        if(response.data != null && response.data.dashboardResponse != null && response.data.userResponse != null && response.data.vehicleResponse != null) {
          return SafeArea(
              child: Container(
                  padding: EdgeInsets.all(8),
                  child: Column(
                      children: [
                        getLogo(),
                        new Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              StatBlockWidget(title: "Total Spent",  value: "${HtmlUnescape().convert(response.data.userResponse.user.preferences.currencyUnit.symbol)}${response.data.dashboardResponse.topStats[0].totalSpent}"),
                              StatBlockWidget(title: "Total Distance", value: "${response.data.dashboardResponse.topStats[0].totalDistance} ${response.data.userResponse.user.preferences.distanceUnit.unit}"),
                            ]
                        ),
                        new Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              StatBlockWidget(title: "Total Fill-Ups", value: "${response.data.dashboardResponse.topStats[0].totalFillUps}"),
                              StatBlockWidget(title: "Number of Vehicles", value: "${response.data.vehicleResponse.vehicles.length}")
                            ]
                        )
                      ]
                  )
              )
          );
        }
        return SafeArea(
            child: Container(
                padding: EdgeInsets.all(8),
                child: Column(
                    children: [
                      getLogo(),
                      new Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            StatBlockWidget(title: "Total Spent",  value: null),
                            StatBlockWidget(title: "Total Distance", value: null),
                          ]
                      ),
                      new Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            StatBlockWidget(title: "Total Fill-Ups", value: null),
                            StatBlockWidget(title: "Number of Vehicles", value: null)
                          ]
                      )
                    ]
                )
            )
        );
      },
    );
  }

  Widget getLogo() {
    return Container(
        padding: EdgeInsets.all(24),
        child: Center(
            child: Text('Dashboard',
                style: TextStyle(
                    fontFamily: 'Lobster',
                    fontSize: 36
                )
            )
        )
    );
  }
}

class StatBlockWidget extends StatelessWidget {
  final String title;
  final String value;

  StatBlockWidget({Key key, this.title, this.value}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(child:
        Card(
            elevation: 4,
            child: Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                        color: Color.fromRGBO(52, 58, 64, 1),
                        border: Border(
                            bottom: BorderSide(
                                color: Color.fromRGBO(30, 34, 38, 1),
                                width: 0.5
                            )
                        )
                    ),
                    padding: EdgeInsets.all(12),
                        child: Center(
                            child: Text(
                                title.toUpperCase(),
                                style: TextStyle(color: Colors.white)
                            )
                        )
                  ),
                  Container(
                      padding: EdgeInsets.all(16),
                      child: Center(
                          child: value != null ? Text(
                              value.toUpperCase(),
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 24
                              ),
                              textAlign: TextAlign.left
                          ) : CircularProgressIndicator()
                      ),
                      color: Color.fromRGBO(52, 58, 64, 1)
                  ),
                ]
            )
        )
    );
  }
}