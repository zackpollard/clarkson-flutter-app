import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'models/responses/fuel_response.dart';
import 'models/responses/user_response.dart';

class FillUpDetailPageArguments {
  final User user;
  final Fuel fuel;

  FillUpDetailPageArguments(this.user, this.fuel);
}

class FillUpDetailPage extends StatelessWidget {
  static String tag = 'fillup-detail-page';

  @override
  Widget build(BuildContext context) {
    final FillUpDetailPageArguments args = ModalRoute.of(context).settings.arguments;
    final User user = args.user;
    final Fuel fuel = args.fuel;
    return Scaffold(
        body: SafeArea(
            child: Column(
                children: [
                  getLogo(),
                  Container(
                    padding: EdgeInsets.all(16),
                    child: Column(
                      children: [
                        FillUpTextInputField("Date", '${DateFormat('dd-MM-yyyy HH:mm').format(fuel.date)}', rightText: "Litres"),
                        FillUpTextInputField("Fuel Amount", '${fuel.fuelAmount}', rightText: "Litres"),
                        FillUpTextInputField("Cost per ${user.preferences.fuelUnit.unit}", '${fuel.fuelUnitCost}', rightText: "Litres"),
                        FillUpTextInputField("Total Cost", '${fuel.totalCost}', rightText: "Litres"),
                        FillUpTextInputField("Odometer", '${fuel.odometerReading}', rightText: "Litres")
                      ]
                    )
                  )
                ]
            )
        )
    );
  }

  Widget getLogo() {
    return Container(
        padding: EdgeInsets.all(24),
        child: Center(
            child: Text('Edit Fill-Up',
                style: TextStyle(
                    fontFamily: 'Lobster',
                    fontSize: 36
                )
            )
        )
    );
  }

  Widget FillUpTextInputField(String title, String initialValue, {String leftText, String rightText}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(title,
          style: TextStyle(
            fontWeight: FontWeight.w400,
            color: Color.fromRGBO(145, 154, 161, 1)
          )
        ),
        Container(
          padding: EdgeInsets.symmetric(vertical: 8),
          child: IntrinsicHeight(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Expanded(
                  child: TextFormField(
                    style: TextStyle(
                      color: Color.fromRGBO(85, 89, 92, 1),
                      fontSize: 14
                    ),
                    initialValue: initialValue,
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.zero),
                        borderSide: BorderSide(
                            width: 1,
                            color: Color.fromRGBO(206, 212, 218, 1)
                        ),

                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.zero),
                        borderSide: BorderSide(
                            width: 1,
                            color: Color.fromRGBO(145, 154, 161, 1)
                        ),
                      ),
                      filled: true,
                      fillColor: Color.fromRGBO(247, 247, 249, 1),
                      contentPadding: EdgeInsets.all(16),
                    ),
                  )
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 24),
                  height: double.infinity,
                  decoration: BoxDecoration(
                    color: Color.fromRGBO(236, 238, 239, 1),
                    border: new Border(
                      right: BorderSide(
                        color: Color.fromRGBO(206, 212, 218, 1)
                      ),
                      top: BorderSide(
                          color: Color.fromRGBO(206, 212, 218, 1)
                      ),
                      bottom: BorderSide(
                          color: Color.fromRGBO(206, 212, 218, 1)
                      ),
                    ),
                  ),
                  child: Center(
                    child: Text(rightText,
                      style: TextStyle(
                        color: Color.fromRGBO(85, 89, 92, 1)
                      )
                    )
                  )
                )
              ]
            )
          )
        )
      ]
    );
  }
}