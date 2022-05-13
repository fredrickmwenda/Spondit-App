import 'package:flutter/material.dart';
import 'package:iot_app/dashboard.dart';
import 'package:iot_app/devices.dart';
import 'package:iot_app/profile.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _selectedBar = 0;
  final widgetOptions = [
    const DashboardPage(),
    Devices(),
    ProfileScreen()

  ];



  @override
  Widget build(BuildContext context) {
    // var provider = Provider.of<BottomNavigationBarProvider>(context);
    //const bottomNavigationBarItem = BottomNavigationBarItem(icon: null);
    return MaterialApp(
      //debugShowCheckedModeBanner: false,
      // theme: _switchThemes? ThemeChange._dark, ThemeChange._light,
      home: SafeArea(
        child: Scaffold(
          body: Center(
            child: widgetOptions.elementAt(_selectedBar),
            
          ),
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: _selectedBar,
            // onTap: (index) {
            //  // provider.currentIndex = index;
            // },
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'home',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.category),
                label: 'Devices',
              ),

              BottomNavigationBarItem(
                icon: Icon(Icons.account_box),
                label: 'Profile',
              ),
            ],

            //selectedItemColor: Colors.green,
            unselectedItemColor: Colors.blue,
            fixedColor: Colors.green,
            onTap: _onItemTapped,
          ),
        ),
      ),
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedBar = index;
    });
  }
}
