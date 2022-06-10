import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:iot_app/model/device_data.dart';
import 'package:iot_app/utilities/api_urls.dart';

import 'package:iot_app/utilities/mqtt_client.dart';
import 'package:iot_app/widgets/device_textf_field.dart';
//  import package mqtt_client;
import 'package:mqtt_client/mqtt_client.dart';
import 'package:mqtt_client/mqtt_server_client.dart';
// import 'package:mqtt_client/mqtt_server_client.dart';

import 'package:shared_preferences/shared_preferences.dart';

import 'package:fluttertoast/fluttertoast.dart';

class Devices extends StatefulWidget {
  @override
  _DevicesState createState() => _DevicesState();
}

class _DevicesState extends State<Devices> {
  //lanes TextEditingController
  TextEditingController frequencyControllerLane1 = TextEditingController();
  TextEditingController frequencyControllerLane2 = TextEditingController();
  TextEditingController frequencyControllerLane3 = TextEditingController();
  TextEditingController frequencyControllerLane4 = TextEditingController();

  //get access token from shared preferences
  String accessToken = "";
  //get integer user id from shared preferences
  int userId = 0;

  //get boolean value from shared preferences
  bool isNormal = false;
  bool isAdvanced = false;


  // Future List of  devices with  null check

  final List<DeviceData> _devices = [];
  var topic = "topic/devices";
  var topic1 = "topic/test1";
  var topic2 = "topic/test2";
  var topic3 = "topic/test3";
  var topic4 = "topic/test4";
  MqttClient client =
      MqttServerClient.withPort('broker.emqx.io', 'flutter_client', 1883);

  void _publish(String message) {
    final builder = MqttClientPayloadBuilder();
    builder.addString('Hello from flutter_client');
    client.publishMessage(topic, MqttQos.atLeastOnce, builder.payload);
  }

  //get devices from the server
  Future<List<DeviceData>> fetchDevices() async {
    Dio dio = Dio();

    dio.options.headers['Authorization'] = 'Bearer $accessToken';
    print(dio.options.headers);
    final response = await dio.get(
      ApiUrls().getDeviceListUrl(),
    );
    if (response.statusCode == 200) {
      List<DeviceData> devices = [];
      for (var device in response.data) {
        devices.add(DeviceData.fromJson(device));
      }
      return devices;
    } else {
      throw Exception('Failed to load devices');
    }
  }

  @override
  void initState() {
    super.initState();
    //first get access token from shared preferences
    _loadAccessToken();
    // wait for access token to be loaded
    Future.delayed(const Duration(seconds: 10), () {
      // wait for user id to be loaded

      //then get devices from the server
      fetchDevices().then((value) {
        setState(() {
          _devices.addAll(value);
        });
      });
    });
    // fetchDevices().then((value) {
    //   setState(() {
    //     _devices.addAll(value);
    //   });
    // });

    //load the access token from shared preferences
    // accessToken = "";
  }

  @override
  void dispose() {
    super.dispose();
  }

  //load the access token from shared preferences
  _loadAccessToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      accessToken = (prefs.getString('token') ?? '');
      //get int value of user id
      userId = prefs.getInt('userId')!;
      //get boolean value of normal or advanced
      isNormal = prefs.getBool('is_normal')!;
      isAdvanced = prefs.getBool('is_advanced')!;
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
                    height: 400,
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

                                                 
                                            if(isNormal == true)...[
                                              Flexible(
                                                child: Padding(
                                                  padding: const EdgeInsets.all(5),
                                                  child: DeviceTextField(
                                                    text: _devices[index].lane1,
                                                    onChanged: (value) {
                                                      setState(() {
                                                        _devices[index].lane1 =
                                                            value;
                                                      });
                                                    },
                                                    enabled: false, 
                                                  )
                                                ),
                                              ),
                                            ]
                                            else if(isAdvanced == true)...[
                                              Flexible(
                                                child: Padding(
                                                  padding: const EdgeInsets.all(5),
                                                  child: DeviceTextField(
                                                    text: _devices[index].lane1,
                                                    onChanged: (value) {
                                                      setState(() {
                                                        _devices[index].lane1 =
                                                            value;
                                                      });
                                                       _publish(
                                                              _devices[index]
                                                                  .lane1,
                                                            );
                                                    },
                                                    enabled: true, 
                                                  )
                                                ),
                                              ),

                                            ],


                                                Expanded(
                                                    //
                                                    child: CupertinoSwitch(
                                                  value:
                                                      _devices[index].enable_1,
                                                  onChanged: (bool value) {
                                                    setState(() {
                                                      //updateStat(value, index);
                                                      for (int i = 0;
                                                          i < _devices.length;
                                                          i++) {
                                                        if (i == index) {
                                                          _devices[i].enable_1 =
                                                              value;
                                                          _devices[i].enable_2 =
                                                              false;
                                                          _devices[i].enable_3 =
                                                              false;
                                                          _devices[i].enable_4 =
                                                              false;
                                                        }
                                                        //call the function to update the device status

                                                      }
                                                    });
                                                    // state
                                                    //function to send  enable status to the server
                                                    // enableState(
                                                    //      index,
                                                    //       _devices[index]
                                                    //           .enable_1,                                                 
                                                    //     _devices[index]
                                                    //         .enable_2,
                                                    //     _devices[index].enable_3,
                                                    //     _devices[index]
                                                    //         .enable_4,

                                                    // );
                                                    if (_devices[index]
                                                            .enable_1 ==
                                                        true) {

                                                      client.subscribe(topic1, MqttQos.atLeastOnce);

                                                      Fluttertoast.showToast(
                                                          msg: "Subscribed to " +
                                                              topic1,
                                                          toastLength:
                                                              Toast.LENGTH_SHORT,
                                                          gravity:
                                                              ToastGravity.BOTTOM,
                                                          backgroundColor:
                                                              Colors.blue,
                                                          textColor:
                                                              Colors.white,
                                                          fontSize: 16.0
                                                        );

                                                    }


                                                    
                                                    // client.subscribe(topic,
                                                    //     MqttQos.atLeastOnce);
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

                                                if(isNormal == true)...[
                                                  Flexible(
                                                    child: Padding(
                                                      padding: const EdgeInsets.all(5),
                                                      child: DeviceTextField(
                                                        text: _devices[index].lane2,
                                                        onChanged: (value) {
                                                          setState(() {
                                                            _devices[index].lane1 =
                                                                value;
                                                          });
                                                        },
                                                        enabled: false, 
                                                      )
                                                    ),
                                                  ),
                                                ]
                                                else if(isAdvanced == true)...[
                                                  Flexible(
                                                    child: Padding(
                                                      padding: const EdgeInsets.all(5),
                                                      child: DeviceTextField(
                                                        text: _devices[index].lane2,
                                                        onChanged: (value) {
                                                          setState(() {
                                                            _devices[index].lane1 =
                                                                value;
                                                          });
                                                          _publish(
                                                                  _devices[index]
                                                                      .lane2,
                                                                );
                                                        },
                                                        enabled: true, 
                                                      )
                                                    ),
                                                  ),

                                                ],

                                                Expanded(
                                                    //
                                                    child: CupertinoSwitch(
                                                  value:
                                                      _devices[index].enable_2,
                                                  onChanged: (bool value) {
                                                    setState(() {
                                                      //updateStat(value, index);
                                                      for (int i = 0;
                                                          i < _devices.length;
                                                          i++) {
                                                        if (i == index) {
                                                          //get  device id
                                                          _devices[i].id =
                                                              _devices[i].id;

                                                          _devices[i].enable_2 =
                                                              value;
                                                          _devices[i].enable_1 =
                                                              false;
                                                          _devices[i].enable_3 =
                                                              false;
                                                          _devices[i].enable_4 =
                                                              false;
                                                            
                                                            //store the device status

                                                        }                                                       
                         
                                                      }

                                                    });

                                                    //Subscribe  to topic with deviceName
                                                    //if _devices[index].enable_2 is true
                                                    //then call the function to publish the status of the lane 2
                                                    if(_devices[index].enable_2 == true){
                                                      client.subscribe(topic2,
                                                          MqttQos.atLeastOnce);
                                                      //notify that they are subscribed to the topic
                                                       Fluttertoast.showToast(
                                                          msg: "Subscribed to " +
                                                              topic2,
                                                          toastLength: Toast.LENGTH_SHORT,
                                                          gravity: ToastGravity.BOTTOM,                                                          
                                                          backgroundColor: Colors.green,
                                                          textColor: Colors.white,
                                                          fontSize: 16.0);

                                                    }

                                                    // client.subscribe(topic1,
                                                    //     MqttQos.atLeastOnce);
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

                                                if(isNormal == true)...[
                                                  Flexible(
                                                    child: Padding(
                                                      padding: const EdgeInsets.all(5),
                                                      child: DeviceTextField(
                                                        text: _devices[index].lane3,
                                                        onChanged: (value) {
                                                          setState(() {
                                                            _devices[index].lane3 =
                                                                value;
                                                          });
                                                        },
                                                        enabled: false, 
                                                      )
                                                    ),
                                                  ),
                                                ]
                                                else if(isAdvanced == true)...[
                                                  Flexible(
                                                    child: Padding(
                                                      padding: const EdgeInsets.all(5),
                                                      child: DeviceTextField(
                                                        text: _devices[index].lane3,
                                                        onChanged: (value) {
                                                          setState(() {
                                                            _devices[index].lane3 =
                                                                value;
                                                          });
                                                          _publish(
                                                                  _devices[index]
                                                                      .lane3,
                                                                );
                                                        },
                                                        enabled: true, 
                                                      )
                                                    ),
                                                  ),

                                                ],

                                                Expanded(
                                                    //
                                                    child: CupertinoSwitch(
                                                        value: _devices[index]
                                                            .enable_3,
                                                        onChanged:
                                                            (bool value) {
                                                          setState(() {
                                                            // updateStat(
                                                            //     value, index);

                                                            for (int i = 0;
                                                                i <
                                                                    _devices
                                                                        .length;
                                                                i++) {
                                                              if (i == index) {
                                                                //get device id

                                                                _devices[i]
                                                                        .enable_3 =
                                                                    value;
                                                                _devices[i]
                                                                        .enable_2 =
                                                                    false;
                                                                _devices[i]
                                                                        .enable_1 =
                                                                    false;
                                                                _devices[i]
                                                                        .enable_4 =
                                                                    false;
                                                              }
                                                            }
                                                          });
                                                          // updateState();
                                                          if(_devices[index].enable_3 == true){
                                                            client.subscribe(topic3,
                                                                MqttQos.atLeastOnce);
                                                            //notify that they are subscribed to the topic
                                                            Fluttertoast.showToast(
                                                                msg: "Subscribed to " +
                                                                    topic3,
                                                                toastLength:
                                                                    Toast.LENGTH_SHORT,
                                                                gravity:
                                                                    ToastGravity.BOTTOM,
                                                                backgroundColor:
                                                                    Colors.green,
                                                                textColor:
                                                                    Colors.white,
                                                                fontSize: 16.0);
                                                          }
  
                                                        })),
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
                                                if(isNormal == true)...[
                                                  Flexible(
                                                    child: Padding(
                                                      padding: const EdgeInsets.all(5),
                                                      child: DeviceTextField(
                                                        text: _devices[index].lane4,
                                                        onChanged: (value) {
                                                          setState(() {
                                                            _devices[index].lane4 =
                                                                value;
                                                          });
                                                        },
                                                        enabled: false, 
                                                      )
                                                    ),
                                                  ),
                                                ]
                                                else if(isAdvanced == true)...[
                                                  Flexible(
                                                    child: Padding(
                                                      padding: const EdgeInsets.all(5),
                                                      child: DeviceTextField(
                                                        text: _devices[index].lane4,
                                                        onChanged: (value) {
                                                          setState(() {
                                                            _devices[index].lane4 =
                                                                value;
                                                          });
                                                          _publish(
                                                                  _devices[index]
                                                                      .lane4,
                                                                );
                                                        },
                                                        enabled: true, 
                                                      )
                                                    ),
                                                  ),

                                                ],

                                                Expanded(
                                                    //
                                                    child: CupertinoSwitch(
                                                  value:
                                                      _devices[index].enable_4,
                                                  onChanged: (bool value) {
                                                    setState(() {
                                                      //updateStat(value, index);

                                                      for (int i = 0;
                                                          i < _devices.length;
                                                          i++) {
                                                        if (i == index) {
                                                          _devices[i].enable_4 =
                                                              value;
                                                          _devices[i].enable_2 =
                                                              false;
                                                          _devices[i].enable_1 =
                                                              false;
                                                          _devices[i].enable_3 =
                                                              false;
                                                        }
                                                      }
                                                    });
                                                    if(_devices[index].enable_4 == true){
                                                      client.subscribe(topic4,
                                                          MqttQos.atLeastOnce);
                                                      //notify that they are subscribed to the topic
                                                      Fluttertoast.showToast(
                                                          msg: "Subscribed to " +
                                                              topic4,
                                                          toastLength:
                                                              Toast.LENGTH_SHORT,
                                                          gravity:
                                                              ToastGravity.BOTTOM,
                                                          backgroundColor:
                                                              Colors.green,
                                                          textColor:
                                                              Colors.white,
                                                          fontSize: 16.0);
                                                    }

                                                    // client.subscribe(topic3,
                                                    //     MqttQos.atLeastOnce);
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

                                                      //send the data to the server via rest api that the device is connected
                                                      deviceConnected(
                                                          _devices[index].id,
                                                          userId);
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
                                                      //send the data to the server via rest api that the device is disconnected
                                                      deviceDisconnected(
                                                          _devices[index].id,
                                                          userId);
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
  }

  // function to connect the device to the network
  void deviceConnected(int deviceId, int userId) async {
    Map<String, dynamic> data = {
      'device_id': deviceId,
      'user_id': userId,
    };

    Dio dio = Dio();
    dio.options.headers['Authorization'] = 'Bearer $accessToken';
    final response = await dio.post(
      ApiUrls().getConnectDeviceUrl(),
      data: data,
      // data: {
      //   'device_id': deviceId,
      //   'user_id': userId,
      // }
    );
    //print(response.data);

    switch (response.statusCode) {
      case 200:

        //show Scaffold that the device is connected
        Fluttertoast.showToast(
          msg: "Device Connected",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 16.0,
        );
        break;

      case 400:
        Fluttertoast.showToast(
          msg: "Device not connected",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0,
        );
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

  void deviceDisconnected(int deviceId, int userId) async {
    Map<String, dynamic> data = {
      'device_id': deviceId,
      'user_id': userId,
    };
    Dio dio = Dio();
    dio.options.headers['Authorization'] = 'Bearer $accessToken';
    final response = await dio.post(
      ApiUrls().getDisconnectDeviceUrl(),
      data: data,
      // data: {
      //   'device': deviceId,
      //   'user': userId,
      // }
    );
    print(response.data);

    switch (response.statusCode) {
      case 200:

        //show Scaffold that the device is connected
        Fluttertoast.showToast(
          msg: "Device Disconnected",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 16.0,
        );
        break;

      case 400:
        Fluttertoast.showToast(
          msg: "Device not disconnected",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0,
        );
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

  //function to post change state of enable_1, enable_2, enable_3 and enable_4 for each device
  void enableState(int deviceId, bool enable_1, bool enable_2, bool enable_3,
      bool enable_4) async {
    print('deviceId: $deviceId');
    print('enable_1: $enable_1');
    Map<String, dynamic> data = {
      'enable_1': enable_1,
      'enable_2': enable_2,
      'enable_3': enable_3,
      'enable_4': enable_4,
    };

    print('data: $data');

    Dio dio = Dio();
    dio.options.headers['Authorization'] = 'Bearer $accessToken';
    final response = await dio.post(
      ApiUrls().getChangeDeviceStateUrl(),

      data: data,
      // data: {
      //   'enable_1': enable_1,
      //   'enable_2': enable_2,
      //   'enable_3': enable_3,
      //   'enable_4': enable_4,
      // }
    );

    print(response.data);

    switch (response.statusCode) {
      case 200:

        //show Scaffold that the device is connected
        Fluttertoast.showToast(
          msg: "Device State Changed",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 16.0,
        );
        break;

      case 400:
        Fluttertoast.showToast(
          msg: "Device not connected",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0,
        );
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



  // _onLaneChanged(bool p1) {
  //   // check if the user is normal or advanced
  //   if (isNormal == true) {
  //     // set the textfield as readonly
      
  //     setState(() {
  //       // set the textfield as readonly
  //       lane1 = p1;

  //     });
       


  //   } else {
  //     // if the user is advanced user
  //     // check if the lane is changed
  //     if (p1 != _lane1) {
  //       // if the lane is changed
  //       // change the lane
  //       setState(() {
  //         _lane1 = p1;
  //       });
  //     }
  //   }
  // }
}





