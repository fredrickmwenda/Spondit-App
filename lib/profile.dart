import 'package:flutter/material.dart';
import 'package:iot_app/constants/constants.dart';

import 'package:shared_preferences/shared_preferences.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late ThemeData theme;

  //bool isLoading = false;
  bool isLoggedIn = false;
  bool isAdmin = false;
  bool isUser = false;
  bool isGuest = false;

  bool isNotification = true;

  String name = '';
  String email = '';

  @override
  void initState() {
    super.initState();
    //isLoading = true;
    isLoggedIn = false;
    isAdmin = false;
    isUser = false;
    isGuest = false;
    isNotification = true;
    getUser();
    //get shared preferences
    _getSharedPreferences();
  }

  Future<void> getUser() async {
    // var response = await http.get(Constants.baseUrl + 'user/getUser');
    // if (response.statusCode == 200) {
    //   var data = json.decode(response.body);
    //   if (data['status'] == 'success') {
    //     setState(() {
    //       isLoading = false;
    //       isLoggedIn = true;
    //       isAdmin = data['data']['isAdmin'];
    //       isUser = data['data']['isUser'];
    //       isGuest = data['data']['isGuest'];
    //     });
    //   } else {
    //     setState(() {
    //       isLoading = false;
    //       isLoggedIn = false;
    //       isAdmin = false;
    //       isUser = false;
    //       isGuest = false;
    //     });
    //   }
    // } else {
    //   setState(() {
    //     isLoading = false;
    //     isLoggedIn = false;
    //     isAdmin = false;
    //     isUser = false;
    //     isGuest = false;
    //   });
    // }
  }

  void _getSharedPreferences() async {
    //get shared preferences
    var prefs = await SharedPreferences.getInstance();
    setState(() {
      isNotification = prefs.getBool('notification') ?? true;
      //get name and email
      name = prefs.getString('name') ?? '';
      email = prefs.getString('email') ?? '';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
        data: theme.copyWith(
            colorScheme: theme.colorScheme
                .copyWith(secondary: kTextColor.withAlpha(40))),
        child: SafeArea(
            child: Scaffold(
          appBar: AppBar(
            title: const Text('Profile'),
            centerTitle: true,
          ),

          //body
          body: ListView(
            padding: const EdgeInsets.fromLTRB(24, 36, 24, 24),
            children: [
              Container(
                child: Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(50),
                      child: Image(
                        //get  image from shared preferences if available otherwise use default image
                        image: AssetImage(name == ''
                            ? 'assets/images/user.png'
                            : 'assets/images/user.png'),

                        height: 100,
                        width: 100,
                      ),
                    ),
                    const SizedBox(
                      width: 16,
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            name == '' ? 'Guest' : name,
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          Text(
                            email == '' ? 'Guest' : email,
                            style: TextStyle(fontSize: 12),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          //Edit button

                          OutlinedButton(
                            onPressed: () {
                              Navigator.pushNamed(context, '/editProfile');
                            },
                            child: const Text(
                              'Edit Profile',
                              style: TextStyle(color: kTextColor),
                            ),
                            style: ButtonStyle(
                              padding: MaterialStateProperty.all<EdgeInsets>(
                                  const EdgeInsets.symmetric(
                                      vertical: 8, horizontal: 16)),
                              shape: MaterialStateProperty.all(
                                  RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30.0),
                              )),
                            ),
                          )
                        ],
                      ),
                    ),
        
                  ],
                ),
              ),
              const SizedBox(
                height: 24,
              ),
              Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Options",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    SwitchListTile(
                      dense: true,
                      //contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                      inactiveTrackColor: kGreenColor.withAlpha(40),
                      activeTrackColor: kGreenColor,
                      activeColor: kGreenColor,

                      title: const Text(
                        'Notifications',
                        style: TextStyle(letterSpacing: 0),
                      ),
                      onChanged: (bool value) {
                        setState(() {
                          isNotification = value;
                        });
                      },

                      value: isNotification,
                    ),
                    const Divider(
                      thickness: 1,
                      height: 1,
                      //color: kTextColor.withAlpha(40),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    const Text(
                      "Account",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    ListTile(
                      dense: true,
                      visualDensity: VisualDensity.compact,
                      //contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                      title: const Text(
                        'Personal Information',
                        style: TextStyle(letterSpacing: 0),
                      ),
                      trailing: const Icon(
                        Icons.arrow_forward_ios,
                        size: 16,
                        color: kTextColor,
                      ),
                      onTap: () {
                        //logout
                        //Navigator.pushNamed(context, '/login');
                      },
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Center(
                      child: OutlinedButton(
                        onPressed: () {
                          //logout
                          //Navigator.pushNamed(context, '/login');
                        },
                        child: const Text(
                          'Logout',
                          style: TextStyle(color: kTextColor),
                        ),
                        style: ButtonStyle(
                          padding: MaterialStateProperty.all<EdgeInsets>(
                              const EdgeInsets.symmetric(
                                  vertical: 8, horizontal: 16)),
                          shape:
                              MaterialStateProperty.all(RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.0),
                          )),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 24,
              ),
              Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        //icon
                        Icon(
                          Icons.info,
                          color: kTextColor,
                          size: 24,
                        ),
                        SizedBox(
                          width: 14,
                        ),
                        //text
                        Text(
                          "Feel Free to contact us",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: kTextColor,
                          ),
                        )
                      ]))
            ],
          ),
        )));
  }
}
