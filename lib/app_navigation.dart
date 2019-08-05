import 'package:clarkson/vehicles_page.dart';
import 'package:flutter/material.dart';

import 'dashboard_page.dart';
import 'fillups_page.dart';

class AppNavigation extends StatefulWidget {
  static String tag = 'navigation-page';
  @override
  AppNavigationState createState() => AppNavigationState();
}

class AppNavigationState extends State<AppNavigation> {
  int _currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        onTap: onTabTapped, // new
        currentIndex: _currentIndex, // new
        items: [
          new BottomNavigationBarItem(
            icon: Icon(
                Icons.home,
              color: Colors.black,
            ),
            title: Text(
                'Dashboard',
                style: TextStyle(color: Colors.black)
            ),
          ),
          new BottomNavigationBarItem(
            icon: Icon(
              Icons.directions_car,
              color: Colors.black,
            ),
            title: Text(
                'Vehicles',
                style: TextStyle(color: Colors.black)
            ),
          ),
          new BottomNavigationBarItem(
            icon: Icon(
              Icons.local_gas_station,
              color: Colors.black,
            ),
            title: Text(
                'Fill-Ups',
                style: TextStyle(color: Colors.black)
            ),
          ),
        ],
      ),
        body: [
          DashboardPage(),
          VehiclePage(),
          FillupPage(),
        ][_currentIndex]
    );
  }

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }
}