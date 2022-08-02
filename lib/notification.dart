import 'dart:convert';
//import 'package:connectivity/connectivity.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:iot_app/model/notification.dart';
import 'package:iot_app/utilities/api_urls.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:intl/intl.dart';
// import 'package:shinewash/api/api.dart';
// import 'package:shinewash/models/notification.dart';
// import '../models/notification.dart';

import 'package:shared_preferences/shared_preferences.dart';

const darkBlue = Color(0xFF265E9E);
const extraDarkBlue = Color(0xFF91B4D8);

class Notifications extends StatefulWidget {
  const Notifications({Key? key}) : super(key: key);

  @override
  _NotificationsState createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {
  var showSnipper = false;

  String accessToken = "";
  //get integer user id from shared preferences
  int userId = 0;

  List<NotificationsData> nd = [];

 
  // List<NotificationOrder> no = List<NotificationOrder>();

  @override
  void initState() {
    _loadAccessToken();
    //delay get notifications so as to load SharedPreferences first
    Future.delayed(const Duration(seconds: 5), () {
      getNotificationData(userId: userId);
    });

    super.initState();
  }

  _loadAccessToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      accessToken = (prefs.getString('token') ?? '');
      //get int value of user id
      userId = prefs.getInt('userId')!;
    });
  }

  Future<void> getNotificationData({required int userId}) async {
    Dio dio = Dio();
    dio.options.headers['Authorization'] = 'Bearer $accessToken';
    //get notifications of a specific user using userId

    var res = await dio.get(
      ApiUrls().getNotificationsUrl(),
      //pass the userId
    );
    var body = json.decode(res.data);
    var theData = body['data'];
    switch (res.statusCode) {
      case 200:
        for (int i = 0; i < theData.length; i++) {
          Map<String, dynamic> map = theData[i];
          nd.add(NotificationsData.fromJson(map));
        }

        setState(() {
          showSnipper = false;
        });

        break;

      case 500:
        Fluttertoast.showToast(
          msg: "Server Error",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0,
        );
        break;

      default:
        Fluttertoast.showToast(
          msg: "Server Error",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0,
        );
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(
            Icons.chevron_left,
            size: 24,
            color: darkBlue,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        centerTitle: true,
        title: const Text(
          'Notifications',
          style: TextStyle(
            color: darkBlue,
            fontSize: 18.0,
          ),
        ),
        actions: [
          IconButton(
              icon: const Icon(
                Icons.message,
                size: 22,
                color: darkBlue,
              ),
              onPressed: () {})
        ],
      ),
      body: ModalProgressHUD(
        inAsyncCall: showSnipper,
        child: nd.isEmpty
            ? Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: const Center(
                    child: Text(
                  'Not any notification found',
                  style: TextStyle(
                    color: darkBlue,
                    fontSize: 16,
                  ),
                )))
            : Container(
                child: ListView.builder(
                  scrollDirection: Axis.vertical,
                  itemCount: nd.length,
                  itemBuilder: (context, index) {
                    NotificationsData notificationsData = nd[index];
                    //NotificationUser notificationsUserData = nu[index];
                    // NotificationOrder notificationsOrderData = no[index];
                    return Card(
                      margin: const EdgeInsets.all(7.0),
                      child: ListTile(
                        contentPadding: const EdgeInsets.all(10.0),
                        leading: Container(
                          padding: const EdgeInsets.all(2.0),
                          decoration: const BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.all(
                                Radius.circular(7.0),
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black26,
                                  blurRadius: 0.5,
                                  spreadRadius: 0.5,
                                )
                              ]),
                        ),
                        title: Text(
                          notificationsData.title,
                          style: const TextStyle(
                            color: darkBlue,
                            fontSize: 18,
                          ),
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 7.0),
                            //show DateTime in a readable format
                            Text(
                              DateFormat('dd MMM yyyy').format(
                                DateTime.parse("${notificationsData.time}"),
                              ),
                            ),
                 
                            Text(
                              notificationsData.message,
                              style: const TextStyle(
                                color: extraDarkBlue,
                                fontSize: 14,
                              ),
                            )
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
      ),
    );
  }
}
