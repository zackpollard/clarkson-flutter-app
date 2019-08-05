import 'package:clarkson/fillup_detail_page.dart';
import 'package:clarkson/http/user_api.dart';
import 'package:clarkson/utils/converter.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:html_unescape/html_unescape.dart';
import 'package:auto_size_text/auto_size_text.dart';

import 'http/fuel_api.dart';
import 'http/vehicle_api.dart';
import 'models/responses/fuel_response.dart';
import 'models/responses/user_response.dart';
import 'models/responses/vehicle_response.dart';

class FillupPage extends StatefulWidget {
  static String tag = 'fillup-page';
  @override
  FillUpPageState createState() => FillUpPageState();
}

class FillupData {
  final UserResponse userResponse;
  final VehicleResponse vehicleResponse;
  final FuelResponse fuelResponse;

  FillupData(this.userResponse, this.vehicleResponse, this.fuelResponse);
}

class FillUpPageState extends State<FillupPage> {
  final UserApiProvider _userApiProvider = UserApiProvider();
  final VehicleApiProvider _vehicleApiProvider = VehicleApiProvider();
  final FuelApiProvider  _fuelApiProvider = FuelApiProvider();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(future: new Future(() async {
      Future<UserResponse> userFuture = _userApiProvider.getUser();
      Future<VehicleResponse> vehicleFuture = _vehicleApiProvider.getVehicle();
      Future<FuelResponse> fuelFuture = _fuelApiProvider.getFuel("4512FA03-DC98-43F2-9EA44-0D0FF0461C4");
      return FillupData(await userFuture, await vehicleFuture, await fuelFuture);
    }),
      builder: (BuildContext context, AsyncSnapshot<FillupData> response) {
        if(response.data != null && response.data.userResponse != null && response.data.vehicleResponse != null && response.data.fuelResponse != null) {
          List<Fuel> fillUps = response.data.fuelResponse.fuel;
          return SafeArea(
              child: Container(
                  child: Column(
                      children: [
                        getLogo(),
                        Expanded(
                          child: ListView.builder(
                            padding: EdgeInsets.fromLTRB(8, 0, 8, 0),
                            itemCount: fillUps.length,
                            itemBuilder: (context, index) {
                                return FillUpWidget(fuel: fillUps[fillUps.length - 1 - index], user: response.data.userResponse.user);
                            },
                          )
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
                      CircularProgressIndicator()
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
            child: Text('Fill-Ups',
                style: TextStyle(
                    fontFamily: 'Lobster',
                    fontSize: 36
                )
            )
        )
    );
  }
}

class FillUpWidget extends StatelessWidget {
  final Fuel fuel;
  final User user;

  FillUpWidget({Key key, this.fuel, this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AutoSizeGroup autoSizeGroup = AutoSizeGroup();
    return FlatButton(
        padding: EdgeInsets.zero,
        child: Card(
          elevation: 2,
          shape: BeveledRectangleBorder(),
          child: Container(
              padding: EdgeInsets.all(8),
              child: Row(
                  children: [
                    Container(
                        color: Color.fromRGBO(239, 239, 239, 1),
                        padding: EdgeInsets.all(8),
                        margin: EdgeInsets.fromLTRB(0, 0, 8, 0),
                        constraints: new BoxConstraints(
                          minHeight: 64,
                          minWidth: 64
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text(
                                '${fuel.tripDistance != fuel.odometerReading ?
                                      ConsumptionConverter.calculateConsumption(
                                          user.preferences.fuelConsumptionUnit.unit,
                                          fuel.fuelAmount,
                                          user.preferences.fuelUnit.unit,
                                          fuel.tripDistance,
                                          user.preferences.distanceUnit.unit
                                      ) : "---"}',
                                style: TextStyle(
                                    fontFamily: "monospace",
                                    fontSize: 16,
                                    color: Color.fromRGBO(145, 154, 161, 1)
                                ),
                              ),
                              Text(
                                '${user.preferences.fuelConsumptionUnit.unit}',
                                style: TextStyle(
                                    fontFamily: "monospace",
                                    fontSize: 16,
                                    color: Color.fromRGBO(145, 154, 161, 1)
                                ),
                              )
                            ]
                        )
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                        AutoSizeText(
                            '${DateFormat('dd-MM-yyyy HH:mm').format(fuel.date)}',
                          maxLines: 1,
                          group: autoSizeGroup,
                          style: TextStyle(
                                fontFamily: "monospace",
                                color: Color.fromRGBO(145, 154, 161, 1)
                            ),
                         ),
                          SizedBox(height: 4),
                          AutoSizeText(
                            '${fuel.fuelAmount}${user.preferences.fuelUnit.unit} @ ${HtmlUnescape().convert(user.preferences.currencyUnit.symbol)}${fuel.fuelUnitCost} per ${user.preferences.fuelUnit.unit}',
                            maxLines: 1,
                            group: autoSizeGroup,
                            style: TextStyle(
                                fontFamily: "monospace",
                                color: Color.fromRGBO(145, 154, 161, 1)
                            ),
                          ),
                          SizedBox(height: 4),
                          AutoSizeText(
                            '${fuel.tripDistance} ${user.preferences.distanceUnit.unitName.toLowerCase()} travelled.',
                            maxLines: 1,
                            group: autoSizeGroup,
                            style: TextStyle(
                                fontFamily: "monospace",
                                color: Color.fromRGBO(145, 154, 161, 1)
                            ),
                          ),
                        ]
                      )
                    )
                  ]
              )
          )
      ),
      onPressed: () {
          Navigator.pushNamed(
            context,
            FillUpDetailPage.tag,
              arguments: FillUpDetailPageArguments(user, fuel)
          );
      },
    );
  }
}