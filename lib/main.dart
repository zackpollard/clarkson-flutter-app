// Copyright 2018 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:clarkson/fillup_detail_page.dart';
import 'package:flutter/material.dart';
import 'app_navigation.dart';
import 'login_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  final routes = <String, WidgetBuilder>{
    LoginPage.tag: (context) => LoginPage(),
    AppNavigation.tag: (context) => AppNavigation(),
    FillUpDetailPage.tag: (context) => FillUpDetailPage()
  };

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Clarkson',
      theme: ThemeData(          // Add the 3 lines from here...
        primaryColor: Colors.white
      ),
        home: AppNavigation(),
        routes: routes,
    );
  }
}

