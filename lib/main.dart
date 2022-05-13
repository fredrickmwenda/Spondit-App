import 'dart:async';

import 'package:flutter/material.dart';
import 'package:iot_app/dashboard.dart';
import 'package:iot_app/login.dart';
import 'package:iot_app/utilities/user_data.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'IOT APP',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),    
      home: SplashScreenWidget(),
    );
  }
}


class SplashScreenWidget extends StatefulWidget {
  SplashScreenWidget({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreenWidget> {
  UserData userData = UserData();
  @override
  void initState() {
    super.initState();
    _loadUserDetails();
  }

  _loadUserDetails() async {
    if (await userData.getClientLoginStatus()) {
      Timer(const Duration(seconds: 5), loadHome);
    } else {
      Timer(const Duration(seconds: 5), loadLogin);
    }
  }

  void loadHome() {
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => DashboardPage()),
        (Route<dynamic> route) => false);
  }

  void loadLogin() {
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => LoginScreen()),
        (Route<dynamic> route) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColorDark),
           ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start, 
            children: <Widget>[
            Expanded(
              flex: 2,
              child: Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(
                      Icons. sensors,
                      color: Theme.of(context).scaffoldBackgroundColor,
                      size: 50.0,
                    ),
                    const Padding(
                      padding: EdgeInsets.only(top: 20.0),
                    ),
                    const Text(
                      "IOT APP",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Divider(
                        color: Colors.white,
                        indent: 150.0,
                        endIndent: 150.0,
                        height: 20.0),
                    const Text(
                      "Spondit",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const <Widget>[
                  CircularProgressIndicator(
                    backgroundColor: Colors.white,
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 30.0),
                  ),
                  Text(
                    "The most effecient and affordable traffic Manager in town",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 13.0,
                      fontWeight: FontWeight.bold,
                    ),
                  )
                ],
              ),
            ),
          ]),
        ],
      ));
  }
}
