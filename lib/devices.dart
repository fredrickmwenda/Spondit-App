import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:iot_app/model/device_data.dart';
import 'package:iot_app/utilities/api_urls.dart';
import 'package:iot_app/utilities/mqtt_client.dart';
//  import package mqtt_client;
import 'package:mqtt_client/mqtt_client.dart';
import 'package:mqtt_client/mqtt_server_client.dart';
// import 'package:mqtt_client/mqtt_server_client.dart';

import 'package:shared_preferences/shared_preferences.dart';

class Devices extends StatefulWidget {
  //Devices({Key? key, required this.title}) : super(key: key);
  //devices are retrieved frm the DeviceData Model
  // final String deviceName;
  // final bool deviceStatus;
  // final bool enable_1;
  // final bool enable_2;
  // final bool enable_3;
  // final bool enable_4;
  // final int deviceId;
  // final String deviceType;
  // final String lane1;
  // final String lane2;
  // final String lane3;
  // final String lane4;
  // final double latitude;
  // final double longitude;
  // final String deviceDescription;
  // final String deviceImages;
  // final DateTime deviceCreatedAt;
  // final DateTime deviceUpdatedAt;
  // final String state;
  // final String city;

  // Devices({
  //   Key? key,
  //   required this.deviceName,
  //   required this.deviceStatus,
  //   required this.enable_1,
  //   required this.enable_2,
  //   required this.enable_3,
  //   required this.enable_4,
  //   required this.deviceId,
  //   required this.deviceType,
  //   required this.lane1,
  //   required this.lane2,
  //   required this.lane3,
  //   required this.lane4,
  //   required this.latitude,
  //   required this.longitude,
  //   required this.deviceDescription,
  //   required this.deviceImages,
  //   required this.deviceCreatedAt,
  //   required this.deviceUpdatedAt,
  //   required this.state,
  //   required this.city,
  // }) : super(key: key);

  @override
  _DevicesState createState() => _DevicesState();
}

class _DevicesState extends State<Devices> {
  //lanes TextEditingController
  TextEditingController _lane1Controller = TextEditingController();
  TextEditingController _lane2Controller = TextEditingController();
  TextEditingController _lane3Controller = TextEditingController();
  TextEditingController _lane4Controller = TextEditingController();

  //get access token from shared preferences
  String accessToken = "";

  // Future List of  devices with  null check

  final List<DeviceData> _devices = [];
  var topic = "topic/test";
  MqttClient client = MqttServerClient.withPort('broker.emqx.io', 'flutter_client', 1883);

  void _publish(String message) {
    final builder = MqttClientPayloadBuilder();
    builder.addString('Hello from flutter_client');
    client.publishMessage(topic, MqttQos.atLeastOnce, builder.payload);
  }

  //get devices from the server
  Future<List<DeviceData>> fetchDevices() async {
    final response = await Dio().get(
      'https://b054-41-80-108-154.eu.ngrok.io/devices/all',
    );
    if (response.statusCode == 200) {
      List<DeviceData> devices = [];
      for (var device in response.data) {
        devices.add(DeviceData.fromJson(device));
      }
      return devices;
      // If the call to the server was successful, parse the JSON
      // return (json.decode(response.toString()) as List)
      //     .map((data) => DeviceData.fromJson(data))
      //     .toList();

      // print(devices);

    } else {
      throw Exception('Failed to load devices');
    }
  }

  @override
  void initState() {
    super.initState();
    fetchDevices().then((value) {
      setState(() {
        _devices.addAll(value);
      });
    });

    //get devicees from the server
    // devices = fetchDevices() as List<DeviceData>;

    //load the access token from shared preferences
    // accessToken = "";
    _loadAccessToken();
  }

  //load the access token from shared preferences
  _loadAccessToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      accessToken = prefs.getString('access_token') ?? "";
    });
  }

  //function to update the device status
  _updateDeviceStatus(DeviceData device) async {
    //get the device status
    bool deviceStatus = device.deviceStatus;
    //get the device id
    int deviceId = device.deviceId as int;
    //get the device  enable_1
    bool enable_1 = device.enable_1;

    //get the device  enable_2
    bool enable_2 = device.enable_2;

    //get the device  enable_3
    bool enable_3 = device.enable_3;

    //get the device  enable_4
    bool enable_4 = device.enable_4;

    // status of the device
    bool status = !deviceStatus;

    //update the device status
    setState(() {
      device.deviceStatus = status;
    });

    //update the device status on the server
    //  await http.put(
    //   'https://5514-41-80-106-82.eu.ngrok.io/devices/update/$deviceId',
    //   body: json.encode({
    //     'device_status': status,
    //     'enable_1': enable_1,
    //     'enable_2': enable_2,
    //     'enable_3': enable_3,
    //     'enable_4': enable_4,
    //   }),
    //   headers: {
    //     'Content-Type': 'application/json',
    //     'Authorization': 'Bearer $accessToken',
    //   },
    // );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Devices"),
      ),
      body: Container(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Column(
              //return the number of devices
              children: <Widget>[
                Text(
                  "Number of devices: ${_devices.length}",
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            Expanded(
              //return number of devices

              child: ListView.builder(
                //scrollDirection: Axis.horizontal,
                itemCount: _devices.length,
                itemBuilder: (context, index) {
                  return Container(
                    padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                    height: 350,
                    width: double.maxFinite,
                    child: Card(
                      elevation: 5,
                      child: SizedBox(
                        child: DecoratedBox(
                          decoration: BoxDecoration(
                            border: const Border(
                                //have a border radius of 10
                                //borderRadius: BorderRadius.all(Radius.circular(10)),

                                // top: BorderSide(
                                //   color: Colors.grey,
                                //   width: 2.0,
                                // ),
                                ),
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            //  image: DecorationImage(
                            //    image: NetworkImage(
                            //      _devices[index].deviceImages,
                            //    ),
                            //    fit: BoxFit.cover,
                            //  ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(7),
                            child: Stack(
                              children: <Widget>[
                                Align(
                                  alignment: Alignment.centerRight,
                                  child: Stack(
                                    children: <Widget>[
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 10, top: 5),
                                        child: Column(
                                          children: <Widget>[
                                            Row(
                                              children: <Widget>[
                                                Text(
                                                  _devices[index].deviceName,
                                                  style: const TextStyle(
                                                    fontSize: 20,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                                const SizedBox(
                                                  width: 10,
                                                ),
                                                // space between the text and the device type
                                                const Spacer(),
                                                Align(
                                                  alignment: Alignment.topRight,
                                                  child: Text(
                                                    _devices[index].deviceType,
                                                    style: const TextStyle(
                                                      fontSize: 15,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            //horizontal line
                                            Container(
                                              height: 1,
                                              width: double.maxFinite,
                                              color: Colors.grey,
                                            ),

                                            // space between the device name and the device lanes
                                            const SizedBox(
                                              height: 5,
                                            ),
                                            Row(
                                              children: <Widget>[
                                                const Text(
                                                  "Lane 1: ",
                                                  style: TextStyle(
                                                    fontSize: 15,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                                Expanded(
                                                    //
                                                    child: CupertinoSwitch(
                                                  value:
                                                      _devices[index].enable_1,
                                                  onChanged: (bool value) {
                                                    setState(() {
                                                      _devices[index].enable_1 =
                                                          value;
                                                    });
                                                    // state
                                                    client.subscribe(topic, MqttQos.atLeastOnce);
                                                  },
                                                )),
                                                //CupertinoSwitch to enable/disable the lane 1
                                              ],
                                            ),
                                            const SizedBox(
                                              height: 5,
                                            ),

                                            Row(
                                              children: <Widget>[
                                                const Text(
                                                  "Lane 2: ",
                                                  style: TextStyle(
                                                    fontSize: 15,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                                Expanded(
                                                    //
                                                    child: CupertinoSwitch(
                                                  value:
                                                      _devices[index].enable_2,
                                                  onChanged: (bool value) {
                                                    setState(() {
                                                      _devices[index].enable_2 =
                                                          value;
                                                    });
                                                  },
                                                )),
                                                //CupertinoSwitch to enable/disable the lane 1
                                              ],
                                            ),

                                            const SizedBox(
                                              height: 5,
                                            ),

                                            Row(
                                              children: <Widget>[
                                                const Text(
                                                  "Lane 3: ",
                                                  style: TextStyle(
                                                    fontSize: 15,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                                Expanded(
                                                  //
                                                  child: CupertinoSwitch(
                                                    value: _devices[index]
                                                        .enable_3,
                                                    onChanged: (bool value) {
                                                      setState(() {
                                                        _devices[index]
                                                            .enable_3 = value;

                                                        // if the user wants to enable_1, then enable_2 and enabled_3 and enable_4 will be  set to false
                                                        // if the user wants to enable_2, then enable_1 and enabled_3 and enable_4 will be  set to false
                                                        // if the user wants to enable_3, then enable_1 and enable_2 and enabled_4 will be  set to false
                                                        // if the user wants to enable_4, then enable_1 and enable_2 and enable_3 will be  set to false
                                                        // use switch case to enable/disable the lanes
                                                      });
                                                    },
                                                  ),
                                                ),
                                                //CupertinoSwitch to enable/disable the lane 1
                                              ],
                                            ),

                                            const SizedBox(
                                              height: 5,
                                            ),

                                            Row(
                                              children: <Widget>[
                                                const Text(
                                                  "Lane 4: ",
                                                  style: TextStyle(
                                                    fontSize: 15,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                                Expanded(
                                                    //
                                                    child: CupertinoSwitch(
                                                  value:
                                                      _devices[index].enable_4,
                                                  onChanged: (bool value) {
                                                    setState(() {
                                                      // _devices[index].enable_4 =
                                                      //     value;
                                                      // if enable_3 is true set enable_4 to false or if enable_2 is true set enable_4 to false
                                                      if (_devices[index]
                                                              .enable_3 ==
                                                          true) {
                                                        _devices[index]
                                                            .enable_4 = false;
                                                      }
                                                      if (_devices[index]
                                                              .enable_2 ==
                                                          true) {
                                                        _devices[index]
                                                            .enable_4 = false;
                                                      }

                                                      if (_devices[index]
                                                              .enable_1 ==
                                                          true) {
                                                        _devices[index]
                                                            .enable_4 = false;
                                                      }
                                                      //otherwise set enable_4 to its original value (true or false) depending on the value of enable_3 , enable_2  and enable_1 respectively
                                                      // but  if enable_4 is set by the user to true , then set enable_3, enable_2 and enable_4 to false
                                                      else {
                                                        _devices[index]
                                                            .enable_4 = value;
                                                      }
                                                    });
                                                  },
                                                )),
                                                //CupertinoSwitch to enable/disable the lane 1
                                              ],
                                            ),

                                            const SizedBox(
                                              height: 5,
                                            ),
                                            //Row with CupertinoSwitch to enable/disable the device & state & city
                                            Row(
                                              children: <Widget>[
                                                Text(
                                                  _devices[index].state,
                                                  style: const TextStyle(
                                                    fontSize: 15,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                                const SizedBox(
                                                  width: 10,
                                                ),
                                                Text(
                                                  _devices[index].city,
                                                  style: const TextStyle(
                                                    fontSize: 15,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                                const SizedBox(
                                                  width: 10,
                                                ),
                                                //CupertinoSwitch to enable/disable the device
                                                // Expanded(
                                                //   child: CupertinoSwitch(
                                                //     value: _devices[index].deviceStatus,
                                                //     onChanged: (bool value) {
                                                //       setState(() {
                                                //         _devices[index].deviceStatus = value;
                                                //       });
                                                //     },
                                                //   ),
                                                // ),
                                              ],
                                            ),

                                            // connecting the device to the network
                                            const SizedBox(
                                              height: 5,
                                            ),
                                            Row(
                                              children: <Widget>[
                                                //ElevatedButton to connect the device to the network
                                                Expanded(
                                                  child: ElevatedButton(
                                                    child: const Text(
                                                      "Connect",
                                                      style: TextStyle(
                                                        fontSize: 15,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    ),
                                                    onPressed: () {
                                                      connect().then((value) {
                                                        client = value;
                                                        // if (value == true) {
                                                        //   setState(() {
                                                        //     _devices[index]
                                                        //         .deviceStatus =
                                                        //         true;
                                                        //   });
                                                        });
                                                      //connect the device to mqtt broker
                                                      // connectDevice(
                                                      //     _devices[index]
                                                      //         .deviceId
                                                      //         .toString());
                                                      //then connect the device to the network
                                                      // _connectDevice(
                                                      //     _devices[index]
                                                      //         .deviceId);
                                                    },
                                                  ),
                                                ),
                                                // separator between the connect button and the disconnect button
                                                const SizedBox(
                                                  width: 15,
                                                ),
                                                //ElevatedButton to disconnect the device from the network
                                                Expanded(
                                                  child: ElevatedButton(
                                                    child: const Text(
                                                      "Disconnect",
                                                      style: TextStyle(
                                                        fontSize: 15,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    ),
                                                    onPressed: () {
                                                      client.disconnect();
                                                      //disconnect the device to mqtt broker
                                                      // connectDevice(
                                                      //     _devices[index]
                                                      //         .deviceId);

                                                      
                                                      // _connectDevice(
                                                      //     _devices[index]
                                                      //         .deviceId);
                                                    },
                                                  ),
                                                ),
                                              ],
                                            ),
                                            // Device Stat
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );

    //METHODS
    //method to connect the device to the network

    //only show the list of devices if the user is logged in
    // if (isLoggedIn)
    //   return Scaffold(
    //     appBar: AppBar(
    //       title: const Text('Devices'),
    //     ),

    //
  }
}

// function to change enable_1, enable_2, enable_3 and enable_4 to false if enable_1 is true,
// if enable_2 is true, then set enable_1, enable_3 and enable_4 to false, if enable_3 is true, then set enable_2, enable_1 and enable_3 to false,
// if enable_4 is true, then set enable_2, enable_1, enable_3 and enable_4 to false
// void _setEnableFalse() {
//   for (int i = 0; i < _devices.length; i++) {
//     if (_devices[i].enable_1 == true) {
//       _devices[i].enable_2 = false;
//       _devices[i].enable_3 = false;
//       _devices[i].enable_4 = false;
//     }
// connect device to MQTT Client  then connect device to the network
void connectDevice(String deviceId) {}

// connect the device to the Rest Api network using the device id and the current user's id  in shared preferences
void _connectDevice(String deviceId) async {
  // print ("connecting device" + deviceId);
  //get the current user's id from shared preferences
  // SharedPreferences prefs = await SharedPreferences.getInstance();
  // String? userId = prefs.getString('userId');
  String? userId = await SharedPreferences.getInstance().then((value) {
    return value.getString("userId");
  });
  // print ("userId: " + userId);
  // print ("deviceId: " + deviceId);
  await Dio().post(
    'https://b054-41-80-108-154.eu.ngrok.io/connected/devices',
    //ApiUrls().getConnectedDevicesUrl(),
    data: {
      'user_detail_id': userId,
      'device_name': deviceId,
      'active': true,
      'time_connected': DateTime.now().toString(),
    },
  ).then((response) async {
    print("response: " + response.toString());
    switch (response.statusCode) {
      case 200:
        print("device connected");
        // message that the device is connected

        break;
      case 400:
        print("device not connected");
        // message that the device is not connected

        break;
      case 500:
        print('server error');
        // message that the server is not connected

        break;
      case 404:
        print('device not found');
        // message that the device is not found

        break;
      default:
        print('unknown error');
        // message that the device is not connected

        break;
    }
  });
}
