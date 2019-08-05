import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'app_navigation.dart';
import 'http/authentication_api.dart';
import 'models/requests/authenticate_request.dart';
import 'models/responses/authenticate_response.dart';

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

    final loginForm = Card(
        shape: ContinuousRectangleBorder(),
        margin: EdgeInsets.all(8),
        elevation: 3,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            loginLabel,
            LoginForm()
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

class LoginForm extends StatefulWidget {
  @override
  LoginFormState createState() {
    return LoginFormState();
  }
}

class LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();
  final AuthenticateApiProvider _authenticateApiProvider = AuthenticateApiProvider();
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  static showLoadingIndicator(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return Center(
              child: CircularProgressIndicator()
          );
        },
        barrierDismissible: false
    );
  }

  @override
  void dispose() {
    usernameController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            getUsernameLabel(),
            getUsernameField(),
            getPasswordLabel(),
            getPasswordField(),
            getLoginButton()
          ],
        )
    );
  }

  Widget getUsernameLabel() {
    return Container(
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
  }

  Widget getUsernameField() {
    return Container(
      padding: EdgeInsets.fromLTRB(16, 4, 16, 0),
      child: TextFormField(
          controller: usernameController,
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
          ),
          validator: (String value) {
            if (value.length == 0) {
              return "You must provide a username";
            }
            return null;
          }
      ),
    );
  }

  Widget getPasswordLabel() {
    return Container(
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
  }

  Widget getPasswordField() {
    return Container(
        padding: EdgeInsets.fromLTRB(16, 4, 16, 0),
        child: TextFormField(
            controller: passwordController,
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
            ),
            validator: (String value) {
              if (value.length == 0) {
                return "You must provide a password";
              }
              return null;
            }
        )
    );
  }

  Widget getLoginButton() {
    return new Container(
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
                onPressed: () async {
                  if (_formKey.currentState.validate()) {
                    showLoadingIndicator(context);
                    AuthenticateResponse response = await _authenticateApiProvider
                        .postAuthentication(
                        AuthenticateRequest(
                            username: usernameController.text,
                            password: passwordController.text
                        )
                    );
                    Navigator.pop(context);
                    if (response.token != null) {
                      final prefs = await SharedPreferences.getInstance();
                      prefs.setString("access_token", response.token);
                      prefs.setString("username", usernameController.text);
                      prefs.setString("password", passwordController.text);
                      Navigator.pushReplacementNamed(context, AppNavigation.tag);
                    } else {
                      Scaffold.of(context).showSnackBar(
                          SnackBar(
                              content: Text(
                                "Error when logging in: ${response.message}",
                                style: TextStyle(
                                    color: Colors.red
                                ),
                              )
                          )
                      );
                    }
                  }
                }
            )
        )
    );
  }
}