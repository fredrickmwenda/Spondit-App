import 'package:flutter/material.dart';
import 'package:iot_app/homepage.dart';
import 'package:iot_app/model/device_connection.dart';
import 'package:flutter_sparkline/flutter_sparkline.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({Key? key}) : super(key: key);

  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {


  @override
  void initState() {
    //first load shared preferences
    loadSharedPreferences();
    super.initState();

    //clall the function to get the user connected devices
    getUserConnectedDevices();
    


  }





  //chart on total devices a user is connected to
  List<DeviceConnection> _deviceConnections = [];
  List<double> _data = [
    0.0, 1.0, 1.5, 2.0, 0.0, 0.0, -0.5, -1.0, -0.5, 0.0, 0.0];


  //chart on total connections a user has made
  List<DeviceConnection> _deviceConnections2 = [];
  //get 
  List<double> _data2 = [
    0.0, 1.0, 1.5, 2.0, 0.0, 0.0, -0.5, -1.0, -0.5, 0.0, 0.0];
  final List<List<double>> charts = [
    [
      0.0,
      0.3,
      0.7,
      0.6,
      0.55,
      0.8,
      1.2,
      1.3,
      1.35,
      0.9,
      1.5,
      1.7,
      1.8,
      1.7,
      1.2,
      0.8,
      1.9,
      2.0,
      2.2,
      1.9,
      2.2,
      2.1,
      2.0,
      2.3,
      2.4,
      2.45,
      2.6,
      3.6,
      2.6,
      2.7,
      2.9,
      2.8,
      3.4
    ],
    [
      0.0,
      0.3,
      0.7,
      0.6,
      0.55,
      0.8,
      1.2,
      1.3,
      1.35,
      0.9,
      1.5,
      1.7,
      1.8,
      1.7,
      1.2,
      0.8,
      1.9,
      2.0,
      2.2,
      1.9,
      2.2,
      2.1,
      2.0,
      2.3,
      2.4,
      2.45,
      2.6,
      3.6,
      2.6,
      2.7,
      2.9,
      2.8,
      3.4,
      0.0,
      0.3,
      0.7,
      0.6,
      0.55,
      0.8,
      1.2,
      1.3,
      1.35,
      0.9,
      1.5,
      1.7,
      1.8,
      1.7,
      1.2,
      0.8,
      1.9,
      2.0,
      2.2,
      1.9,
      2.2,
      2.1,
      2.0,
      2.3,
      2.4,
      2.45,
      2.6,
      3.6,
      2.6,
      2.7,
      2.9,
      2.8,
      3.4,
    ],
    [
      0.0,
      0.3,
      0.7,
      0.6,
      0.55,
      0.8,
      1.2,
      1.3,
      1.35,
      0.9,
      1.5,
      1.7,
      1.8,
      1.7,
      1.2,
      0.8,
      1.9,
      2.0,
      2.2,
      1.9,
      2.2,
      2.1,
      2.0,
      2.3,
      2.4,
      2.45,
      2.6,
      3.6,
      2.6,
      2.7,
      2.9,
      2.8,
      3.4,
      0.0,
      0.3,
      0.7,
      0.6,
      0.55,
      0.8,
      1.2,
      1.3,
      1.35,
      0.9,
      1.5,
      1.7,
      1.8,
      1.7,
      1.2,
      0.8,
      1.9,
      2.0,
      2.2,
      1.9,
      2.2,
      2.1,
      2.0,
      2.3,
      2.4,
      2.45,
      2.6,
      3.6,
      2.6,
      2.7,
      2.9,
      2.8,
      3.4,
      0.0,
      0.3,
      0.7,
      0.6,
      0.55,
      0.8,
      1.2,
      1.3,
      1.35,
      0.9,
      1.5,
      1.7,
      1.8,
      1.7,
      1.2,
      0.8,
      1.9,
      2.0,
      2.2,
      1.9,
      2.2,
      2.1,
      2.0,
      2.3,
      2.4,
      2.45,
      2.6,
      3.6,
      2.6,
      2.7,
      2.9,
      2.8,
      3.4
    ]
  ];

  static final List<String> chartDropdownItems = [
    'Last 7 days',
    'Last month',
    'Last year'
  ];
  String actualDropdown = chartDropdownItems[0];
  int actualChart = 0;
  //user name
  String _name = '';

  @override
  void initState() {
    super.initState();
    //get fullname from shared preferences
    //SharedPreferences sharedPreferences = SharedPreferences.getInstance();
    _loadData();
  }

  void _loadData() async {
    //get fullname from sharedPreferences
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    setState(() {
     // _name = (sharedPreferences.getString('_fullName') ?? '');
     //get user name from shared preferences
      _name = (sharedPreferences.getString('name') ?? '');
      _id = (sharedPreferences.getString('userId') ?? '');
      print(_name);

     
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 2.0,
          backgroundColor: Colors.white,
          title: const Text('Dashboard',
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w700,
                  fontSize: 30.0)),
          actions: <Widget>[
            Container(
              margin: const EdgeInsets.only(right: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text(
                    //user name
                    '$_name',                
                      style: TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.w700,
                          fontSize: 14.0)),
                  Icon(Icons.arrow_drop_down, color: Colors.black54)
                ],
              ),
            )
          ],
        ),
        body: ListView(
          scrollDirection: Axis.vertical,
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          children: <Widget>[
            const Padding(padding: EdgeInsets.only(top: 16.0)),
            Container(
                margin: const EdgeInsets.only(bottom: 16.0),
                child: Material(
                    elevation: 14.0,
                    borderRadius: BorderRadius.circular(12.0),
                    shadowColor: const Color(0x802196F3),
                    child: InkWell(
                      onTap: () {},
                      child: Padding(
                        padding: const EdgeInsets.all(24.0),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: const <Widget>[
                                  Text('Total Connections',
                                      style:
                                          TextStyle(color: Colors.blueAccent)),
                                  Text('10',
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.w700,
                                          fontSize: 34.0))
                                ],
                              ),
                              Material(
                                  color: Colors.blue,
                                  borderRadius: BorderRadius.circular(24.0),
                                  child: const Center(
                                      child: Padding(
                                    padding: EdgeInsets.all(16.0),
                                    child: Icon(Icons.timeline,
                                        color: Colors.white, size: 30.0),
                                  )))
                            ]),
                      ),
                    ))),
            Container(
                margin: const EdgeInsets.only(bottom: 16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Material(
                        elevation: 14.0,
                        borderRadius: BorderRadius.circular(12.0),
                        shadowColor: const Color(0x802196F3),
                        child: InkWell(
                          onTap: () {},
                          child: Padding(
                            padding: const EdgeInsets.all(24.0),
                            child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: const <Widget>[
                                  Material(
                                      color: Colors.teal,
                                      shape: CircleBorder(),
                                      child: Padding(
                                        padding: EdgeInsets.all(16.0),
                                        child: Icon(Icons.settings_applications,
                                            color: Colors.white, size: 30.0),
                                      )),
                                  Padding(
                                      padding: EdgeInsets.only(bottom: 16.0)),
                                  Text('General',
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.w700,
                                          fontSize: 24.0)),
                                  Text('Images, Videos',
                                      style: TextStyle(color: Colors.black45)),
                                ]),
                          ),
                        )),
                    Material(
                        elevation: 14.0,
                        borderRadius: BorderRadius.circular(12.0),
                        shadowColor: const Color(0x802196F3),
                        child: InkWell(
                          onTap: () {},
                          child: Padding(
                            padding: const EdgeInsets.all(24.0),
                            child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: const <Widget>[
                                  Material(
                                      color: Colors.amber,
                                      shape: CircleBorder(),
                                      child: Padding(
                                        padding: EdgeInsets.all(16.0),
                                        child: Icon(Icons.notifications,
                                            color: Colors.white, size: 30.0),
                                      )),
                                  Padding(
                                      padding: EdgeInsets.only(bottom: 16.0)),
                                  Text('Notification',
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.w700,
                                          fontSize: 24.0)),
                                  Text('All ',
                                      style: TextStyle(color: Colors.black45)),
                                ]),
                          ),
                        )),
                  ],
                )),

            //create a list view for the connected devices
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const <Widget>[
                Padding(
                  padding: EdgeInsets.only(left: 16, top: 4),
                  child: Text(
                    'Connected Devices',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(right: 16, top: 4),
                  child: Text(
                    'See all',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.blue,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(right: 16, top: 4),
                  child: Text(
                    'Connect',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.blue,
                    ),
                  ),
                ),
              ],
            ),

            //--list of connected devices--
            _buildConnectedDevices(),

            Container(
              margin: const EdgeInsets.only(bottom: 16.0),
              child: Material(
                elevation: 14.0,
                borderRadius: BorderRadius.circular(12.0),
                shadowColor: const Color(0x802196F3),
                child: InkWell(
                  onTap: () {},
                  child: Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Row(
                          mainAxisAlignment:
                              MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment:
                                  CrossAxisAlignment.start,
                              children: const <Widget>[
                                Text('Devices Connection',
                                    style:
                                        TextStyle(color: Colors.green)),
                                Text('\16',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.w700,
                                        fontSize: 34.0)),
                              ],
                            ),
                            DropdownButton(
                                isDense: true,
                                value: actualDropdown,
                                onChanged: (String? value) =>
                                    setState(() {
                                      actualDropdown = value!;
                                      actualChart =
                                          chartDropdownItems.indexOf(
                                              value); // Refresh the chart
                                    }),
                                items: chartDropdownItems
                                    .map((String title) {
                                  return DropdownMenuItem(
                                    value: title,
                                    child: Text(title,
                                        style: const TextStyle(
                                            color: Colors.blue,
                                            fontWeight: FontWeight.w400,
                                            fontSize: 14.0)),
                                  );
                                }).toList())
                          ],
                        ),
                        const Padding(
                            padding: EdgeInsets.only(bottom: 4.0)),
                        Sparkline(
                          data: charts[actualChart],
                          lineWidth: 5.0,
                          lineColor: Colors.greenAccent,
                        )
                      ],
                    )
                  ),
                )
              )
            ),
            // create a bottom navigation bar
            
          ],
        ),
        //bottomNavigationBar: HomePage(),
      );
  }

  Widget _buildConnectedDevices() {
    //conneceted devices list using the list of devices from the userDevices API call
    var connectedDevices = getUserDevices(String userId);
    return Container(
      height: MediaQuery.of(context).size.height * 0.3,
      alignment: Alignment.centerLeft,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: connectedDevices.length,
          shrinkWrap: true,
          physics: const ClampingScrollPhysics(),
          itemBuilder: (BuildContext context, int index) {
            return Container(
              width: MediaQuery.of(context).size.width * 0.3,
              child: Column(
                children: <Widget>[
                  Container(
                    height: MediaQuery.of(context).size.height * 0.2,
                    width: MediaQuery.of(context).size.width * 0.3,
                    child: Image.asset(
                      // connectedDevices[index].image,
                      'assets/images/device.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                  Container(
                    height: MediaQuery.of(context).size.height * 0.1,
                    width: MediaQuery.of(context).size.width * 0.3,
                    child: const Text(
                      //use deviceid to get the device name from the device API call
                      connectedDevices[index].deviceId.deviceName,
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: Colors.black),
                    ),
                  ),
                  Container(
                    height: MediaQuery.of(context).size.height * 0.1,
                    width: MediaQuery.of(context).size.width * 0.3,
                    child: const Text(
                      //connectedDevices[index].status,
                      'open',
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                          color: Colors.black),
                    ),
                  ),
                ],
              ),
            );
          }),
    );
  }
}
//fetch the devices a user has connected via Rest API pass the userId to the API call
//and get the list of devices connected to the 
//user from the API call

Future <List<UserDevice>> getUserDevices(String userId) async {
  //make two api calls one to get all Devices the other to get  user Devices

  Map<String, dynamic> data = {   
    'user_id': userId,
  };
   final result = await Future.wait([
    Dio dio = Dio();
    dio.options.headers['Authorization'] = 'Bearer $accessToken';

    dio.get(ApiUrls().getDeviceListUrl()).then((response) {
      if  (response.statusCode == 200) {
        print(response.data);
        return response.data;
      } else {
        print(response.statusCode);
        return null;
      }
      print(response.data);
    });

    dio.get(ApiUrls().getUserConnectedDevicesUrl(), data: data ).then((response) {
      if  (response.statusCode == 200) {
        print(response.data);
        return response.data;
      } else {
        print(response.statusCode);
        return null;
      }
      print(response.data);
    });


   ]);



    final result1 = json.decode(result[0]);
    final result2 = json.decode(result[1]);

    List<Device> devices = [];

    for (var i = 0; i < result1.length; i++) {
      devices.add(Device.fromJson(result1[i]));
    }
    List<UserDevice> userDevices = [];
    for (var i = 0; i < result[1].length; i++) {
      userDevices.add(UserDevice.fromJson(result2[i]));
    }

    //get the deviceId from the userDevices list and use it to get the device name from the devices list
    for (var i = 0; i < userDevices.length; i++) {
      for (var j = 0; j < devices.length; j++) {
        if (userDevices[i].deviceId == devices[j].deviceId) {
          //get that device properties and assign it to the userDevices list
          userDevices[i].deviceName = devices[j].deviceName;
          userDevices[i].image = devices[j].image;
      

        }
      }
    }

    return userDevices, devices;
    //
}


