import 'package:flutter/material.dart';

import 'http/dashboard_api.dart';
import 'models/responses/dashboard_response.dart';

class VehiclePage extends StatefulWidget {
  static String tag = 'vehicles-page';
  @override
  VehiclePageState createState() => VehiclePageState();
}

class VehiclePageState extends State<VehiclePage> {
  @override
  Widget build(BuildContext context) {
    //final DashboardApiProvider _dashboardApiProvider = DashboardApiProvider();
    return getLogo();
  }

  Widget getLogo() {
    return Container(
        padding: EdgeInsets.all(24),
        child: Center(
            child: Text('Vehicles',
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

  const StatBlockWidget({Key key, this.title, this.value}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
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
                      child: Text(
                          value.toUpperCase(),
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 24
                          ),
                          textAlign: TextAlign.left
                      )
                  ),
                  color: Color.fromRGBO(52, 58, 64, 1)
              ),
            ]
        )
    );
  }
}