import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  static String tag = 'home-page';
  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text('Home')
      ),
      body: new Center(child: new Text("Hello World")),
    );
  }
}