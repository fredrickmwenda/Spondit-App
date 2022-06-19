import 'package:flutter/material.dart';
import 'package:iot_app/dashboard.dart';
import 'package:iot_app/devices.dart';
import 'package:iot_app/notification.dart';
import 'package:iot_app/profile.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _HomePageState();
  }
}

class _HomePageState extends State<HomePage> {
  final List<Widget> _widgetList = [
    const DashboardPage(),
    Devices(),
    const Notifications(),
    const ProfileScreen(),
  ];

  int _index = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.green,
        unselectedItemColor: Colors.black,
        type: BottomNavigationBarType.shifting,
        currentIndex: _index,
        onTap: (index) {
          setState(() {
            _index = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
              size: 15,
            ),
            label: 'Home'
          ),

          BottomNavigationBarItem(
            icon: Icon(
              Icons.devices,
              size: 15,
            ),
            label: 'Devices'
          ),

          BottomNavigationBarItem(
            icon: Icon(
              Icons.notifications,
              size: 15,
            ),
            label: 'Notifications'
          ),  
                
          BottomNavigationBarItem(
            icon: Icon(
              Icons.person,
              size: 15, 
            ),
            label: 'Profile'
          ),           
        ],
      ),
      body: _widgetList[_index],
    );
  }
}

