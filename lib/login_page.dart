import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  static String tag = 'login-page';
  @override
  LoginPageState createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage> {

  @override
  Widget build(BuildContext context) {

    final logo = Container(
        padding: EdgeInsets.all(24),
        child: Center(
            child: Text('Clarkson',
                style: TextStyle(
                    fontFamily: 'Lobster',
                    fontSize: 48
                )
            )
        )
    );

    final loginLabel = Container(
      padding: EdgeInsets.fromLTRB(16, 16, 16, 0),
      child: Text(
          'LOG IN',
          style: TextStyle(
              color: Color.fromRGBO(145, 154, 161, 1),
              fontWeight: FontWeight.w500,
              letterSpacing: 1,
              fontSize: 18
          )
      ),
    );

    final emailLabel = Container(
      padding: EdgeInsets.fromLTRB(16, 16, 16, 0),
      child: Text(
          'Username',
          style: TextStyle(
              color: Color.fromRGBO(145, 154, 161, 1),
              fontSize: 12,
              fontWeight: FontWeight.w400
          )
      ),
    );

    final email = Container(
      padding: EdgeInsets.fromLTRB(16, 4, 16, 0),
      child: TextFormField(
          keyboardType: TextInputType.emailAddress,
          autofocus: true,
          decoration: InputDecoration(
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.zero),
              borderSide: BorderSide(
                  width: 1,
                  color: Color.fromRGBO(206, 212, 216, 1)
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
            contentPadding: EdgeInsets.all(8),
          )
      ),
    );

    final passwordLabel = Container(
      padding: EdgeInsets.fromLTRB(16, 16, 16, 0),
      child: Text(
          'Password',
          style: TextStyle(
              color: Color.fromRGBO(145, 154, 161, 1),
              fontSize: 12,
              fontWeight: FontWeight.w400
          )
      ),
    );

    final password =
    Container(
        padding: EdgeInsets.fromLTRB(16, 4, 16, 0),
        child: TextFormField(
            autofocus: false,
            obscureText: true,
            decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.zero),
                  borderSide: BorderSide(
                      width: 1,
                      color: Color.fromRGBO(206, 212, 216, 1)
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
                contentPadding: EdgeInsets.all(8)
            )
        )
    );

    final loginButton = Container(
        padding: EdgeInsets.all(8),
        child: Center(
            child: RaisedButton(
              child: Text(
                "LOG IN",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                  fontWeight: FontWeight.w400
                ),
              ),
              color: Color.fromRGBO(26, 26, 26, 1),
              splashColor: Color.fromRGBO(145, 154, 161, 1),
              highlightElevation: 2,
              onPressed: () {
              },
            )
        )
    );

    final loginForm = Card(
        shape: ContinuousRectangleBorder(),
        margin: EdgeInsets.all(8),
        elevation: 3,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            loginLabel,
            emailLabel,
            email,
            passwordLabel,
            password,
            loginButton
          ],
        )
    );

    return Scaffold(
        backgroundColor: Colors.white,
        body:
        ListView(
          children: <Widget>[
            logo,
            loginForm
          ],
        )
    );
  }
}