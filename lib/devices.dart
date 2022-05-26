import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:iot_app/model/device_data.dart';

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
  String userId = "";

  // Future List of  devices with  null check

  final List<DeviceData> _devices = [];
  var topic = "topic/test";
  var topic1 = "topic/test1";
  var topic2 = "topic/test2";
  var topic3 = "topic/test3";
  MqttClient client =
      MqttServerClient.withPort('broker.emqx.io', 'flutter_client', 1883);

  void _publish(String message) {
    final builder = MqttClientPayloadBuilder();
    builder.addString('Hello from flutter_client');
    client.publishMessage(topic, MqttQos.atLeastOnce, builder.payload);
  }

  //get devices from the server
  Future<List<DeviceData>> fetchDevices() async {
    final response = await Dio().get(
      'https://1354-41-90-64-46.eu.ngrok.io/devices/all',
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
    fetchDevices().then((value) {
      setState(() {
        _devices.addAll(value);
        
        //textEdingcontroller according to specific device using indec

        frequencyControllerLane1.text = _devices[0].lane1;
        frequencyControllerLane2.text = _devices[0].lane2;
        frequencyControllerLane3.text = _devices[0].lane3;
        frequencyControllerLane4.text = _devices[0].lane4;
      });
    });



    //load the access token from shared preferences
    // accessToken = "";
    _loadAccessToken();
  }

  @override
  void dispose() {
    super.dispose();
    frequencyControllerLane1.dispose();
    frequencyControllerLane2.dispose();
    frequencyControllerLane3.dispose();
    frequencyControllerLane4.dispose();
  }

  //load the access token from shared preferences
  _loadAccessToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      accessToken = prefs.getString('access_token') ?? "";
      userId = prefs.getString('user_id') ?? "";
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

                                                Flexible(
                                                    child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(5.0),
                                                        //get data of the lane 3 from the models  and display  it in TextField
                                                        child: DeviceTextField(
                                                          text: _devices[index]
                                                              .lane1, 
                                                          onChanged: (value) {
                                                            setState(() {
                                                              _devices[index]
                                                                  .lane1 =
                                                                  value;
                                                            });
                                                          },
                                                        )
                                                        // child: TextField(
                                                        //   controller:
                                                        //       frequencyControllerLane3,
                                                        //   keyboardType:
                                                        //       TextInputType
                                                        //           .number,
                                                        // )
                                                        )),
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
                                                      }
                                                    });
                                                    // state
                                                    // updateState();
                                                    client.subscribe(topic,
                                                        MqttQos.atLeastOnce);
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

                                                Flexible(
                                                    child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(5.0),
                                                        //get data of the lane 3 from the models  and display  it in TextField
                                                        child: DeviceTextField(
                                                          text: _devices[index]
                                                              .lane2, 
                                                          onChanged: (value) {
                                                            setState(() {
                                                              _devices[index]
                                                                  .lane2 =
                                                                  value;
                                                            });
                                                          },
                                                        )
                                                        )),
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
                                                          _devices[i].enable_2 =
                                                              value;
                                                          _devices[i].enable_1 =
                                                              false;
                                                          _devices[i].enable_3 =
                                                              false;
                                                          _devices[i].enable_4 =
                                                              false;
                                                        }
                                                      }
                                                    });

                                                    client.subscribe(topic1,
                                                        MqttQos.atLeastOnce);
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
                                                Flexible(
                                                    child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(5.0),
                                                        //get data of the lane 3 from the models  and display  it in TextField

                                                        child: DeviceTextField(
                                                          text: _devices[index]
                                                              .lane3, 
                                                          onChanged: (value) {
                                                            setState(() {
                                                              _devices[index]
                                                                  .lane3 =
                                                                  value;
                                                            });
                                                          },
                                                        )
                                                        )),
                                                    

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
                                                          client.subscribe(
                                                              topic2,
                                                              MqttQos
                                                                  .atLeastOnce);
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
                                                Flexible(
                                                  child: Padding(
                                                    padding:
                                                      const EdgeInsets.all(5.0),
                                                      //get data of the lane 3 from the models  and display  it in TextField
                                                    child: DeviceTextField(
                                                      text: _devices[index]
                                                          .lane4, 
                                                      onChanged: (value) {
                                                        setState(() {
                                                          _devices[index]
                                                              .lane4 =
                                                              value;
                                                        });
                                                      },
                                                    )
                                                  )
                                                ),
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

                                                    client.subscribe(topic3,
                                                        MqttQos.atLeastOnce);
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
                                                          _devices[index]
                                                              .deviceId,
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

}

Future<String> deviceConnected(String deviceId, String userId) async {
  final response = await Dio().post(
    'https://50f0-138-199-60-167.ap.ngrok.io/devices/connected',
    data: {
      'device': deviceId,
      'user': userId,
    },
  );
  print(response.data);

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

      return response.data;
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
      return response.data;
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
      return response.data;
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
      return response.data;
  }
}


