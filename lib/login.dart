import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:iot_app/dashboard.dart';
import 'package:iot_app/homepage.dart';
import 'package:iot_app/model/user.dart';
import 'package:iot_app/utilities/user_data.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:velocity_x/velocity_x.dart';
import '../constants/constants.dart';
import 'package:http/http.dart' as http;

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController controllerEmail = TextEditingController();
  TextEditingController controllerPass = TextEditingController();

  // @override
  // void initState() {
  //   super.initState();

  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kMainAppColor,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Stack(
              children: [
                // Container(
                //   height: MediaQuery.of(context).size.height * 0.55,
                //   decoration: const BoxDecoration(
                //     image: DecorationImage(
                //       image: AssetImage("assets/images/5.png"),
                //       fit: BoxFit.cover,
                //     ),
                //   ),
                // ),
                Container(
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                      colors: [
                        kTextFieldColor,
                        Colors.transparent,
                      ],
                    ),
                  ),
                  height: MediaQuery.of(context).size.height * 0.55,
                  width: MediaQuery.of(context).size.width,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 20),
                    child: Column(
                      children: [
                        const SizedBox(height: 30),
                        RichText(
                          text: const TextSpan(
                            text: 'Spondit',
                            style: TextStyle(
                                fontFamily: "Bebas",
                                fontSize: 30,
                                letterSpacing: 5),
                            // children: <TextSpan>[
                            //   TextSpan(
                            //     text: 'ELEMENT',
                            //     style: TextStyle(color: kTextColor),
                            //   )
                            // ],
                          ),
                        ),
                        const Spacer(),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: const [
                              Text(
                                "Sign in",
                                style: TextStyle(
                                  fontSize: 40,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 5),
                              Text(
                                "The best IOT Device connection",
                                style: TextStyle(color: Colors.white),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),

            //_loginPage(context),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Email",
                    style: TextStyle(color: Color(0xFF707070), fontSize: 18),
                  ),
                  TextFormField(
                    controller: controllerEmail,
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(
                      hintText: "johndoe@gmail.com",
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Color(0xFF707070)),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Color(0xFF707070)),
                      ),
                      hintStyle: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    "Password",
                    style: TextStyle(color: Color(0xFF707070), fontSize: 18),
                  ),
                  TextFormField(
                    obscureText: true,
                    controller: controllerPass,
                    keyboardType: TextInputType.text,
                    decoration: const InputDecoration(
                      hintText: "********",
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Color(0xFF707070)),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Color(0xFF707070)),
                      ),
                      hintStyle: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                        onPressed: () {},
                        child: const Text(
                          "Forgot you password?",
                          style: TextStyle(color: Colors.white),
                        )),
                  ),
                  Center(
                    child: Column(
                      children: [
                        const SizedBox(height: 20),
                        TextButton(
                          onPressed: () async {
                            // _showDialog("Data is loading...");
                            // showDialog(
                            //   context: context,
                            //   builder: (BuildContext context) {
                            //     return const AlertDialog(
                            //       title: Text("Data procesing"),
                            //       content: Text("Processing your data"),
                            //     );
                            //   }
                            // );
                            //_inputValidations();
                            //Navigator.pop(context);
                            _loginUser(controllerEmail.text.toString(),
                                controllerPass.text.toString());
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: kSubTextColor,
                            ),
                            height: 50,
                            width: MediaQuery.of(context).size.width * 0.7,
                            child: const Center(
                              child: Text(
                                "Login",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _inputValidations() {
    if (controllerEmail.text.isEmpty) {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return const AlertDialog(
              title: Text("Error"),
              content: Text("Please enter your email"),
            );
          });
    } else if (controllerPass.text.isEmpty) {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return const AlertDialog(
              title: Text("Error"),
              content: Text("Please enter your password"),
            );
          });
    } else {
      _onLoading();
    }
  }

  void _onLoading() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => Dialog(
        child: Container(
          height: 100,
          color: Colors.white,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const <Widget>[
              CircularProgressIndicator(),
              Padding(
                padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                child: Text(
                  "Loading",
                  style: TextStyle(fontSize: 18),
                ),
              )
            ],
          ),
        ),
      ),
    );
    // call the login function
    Future.delayed(const Duration(seconds: 3), () {
      Navigator.pop(context);
      _loginProcess();
    });
  }

  void _loginUser(String email, String password) async {
    //call the rest api
    Map<String, String> data = {
      "email": email,
      "password": password,
    };

    //var body = json.encode(data);
    //print(body);
    try {
      //use dio to make the request
      await Dio()
          .post(
        "https://b054-41-80-108-154.eu.ngrok.io/user/login",
        data: data,
      )
          .then((response) async {
        //check the response
        print(response.data);

        if (response.statusCode == 200) {
          print("success");
          //if success, create client object  and save it in shared preferences
          SharedPreferences prefs = await SharedPreferences.getInstance();
          prefs.setString("token", response.data["access_token"]);
          prefs.setString("email", response.data["email"]);
          prefs.setString("name", response.data["full_name"]);
          Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => const HomePage(),
                ),
              ); 

          // var client = User.fromJson(json.decode(response.data));
          // print(client.email);
          // if (client.email.isNotEmpty && client.accessToken.isNotEmpty) {
          //   UserData userData = UserData();

          //   if (await userData.saveClient(client)) {
          //     Navigator.pushReplacement(
          //       context,
          //       MaterialPageRoute(
          //         builder: (context) => const DashboardPage(),
          //       ),
          //     );
          //   }
          // }
        } else {
          print('here');
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return const AlertDialog(
                  title: Text("Error"),
                  content: Text("Invalid email or pa"),
                );
              });
        }
      });
    } catch (e) {
      print(e.toString());
    }

    //_loginProcess();
  }

  void _loginProcess() async {
    //check unmounted state
    // Map<String, String> body = {
    //   "email": controllerEmail.text,
    //   "password": controllerPass.text,
    // };
    Map data = {
      'email': controllerEmail.text,
      'password': controllerPass.text,
    };

    //call the rest api
    await http
        .post(
      Uri.https('3975-105-162-4-213.eu.ngrok.io/user/login', '/user/login'),
      body: data,
    )
        .then((http.Response response) async {
      switch (response.statusCode) {
        case 200:
          final responseJson = json.decode(response.body);
          // if (responseJson['status'] == 'success') {
          //   print(responseJson);
          final client = User.fromJson(responseJson['data']);

          // final prefs = await SharedPreferences.getInstance();
          // prefs.setString('user_id', user.id);
          // prefs.setString('user_name', user.name);
          // prefs.setString('user_email', user.email);
          // prefs.setString('user_phone', user.phone);
          // prefs.setString('user_address', user.address);
          // prefs.setString('user_image', user.image);
          // prefs.setString('user_token', user.token);
          // prefs.setString('user_role', user.role);
          // prefs.setString('user_status', user.status);
          // prefs.setString('user_created_at', user.created_at);
          // prefs.setString('user_updated_at', user.updated_at);
          UserData userData = UserData();

          if (await userData.saveClient(client)) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => const DashboardPage(),
              ),
            );
          }
          // (client.role == 'admin') {
          //   userData.setUserData(client.id, client.name, client.email, client.phone, client.address, client.image, client.token, client.role, client.status, client.created_at, client.updated_at);
          //   Navigator.pushReplacement(
          //       context,
          //       MaterialPageRoute(
          //           builder: (context) => AdminHomePage()));
          // } else if (client.role == 'user') {
          //   userData.setUserData(client.id, client.name, client.email, client.phone, client.address, client.image, client.token, client.role, client.status, client.created_at, client.updated_at);
          //   Navigator.pushReplacement(
          //       context,
          //       MaterialPageRoute(
          //           builder: (context) => UserHomePage()));
          // }
          //}
          //  else {
          //   _showDialog(responseJson['message']);

          // }
          break;
        case 502:
          _showDialog("Server is not available");
          break;

        case 404:
          _showDialog("Not Found");
          break;
        case 400:
          _showDialog("Bad Request");
          break;
        default:
          _showDialog("Connection or server error. Try again later");
          break;
      }
    });

    // final response = http.post(Uri.parse(ApiUrls().getLoginUrl()),
    //   body: {
    //     "email": controllerEmail.text,
    //     "password": controllerPass.text,
    //   },
    // );

    //   switch (response.statusCode) {
    //     case 200:
    //       final responseJson = json.decode(response.body);
    //       if (responseJson['status'] == "success") {
    //         final client = User.fromJson(responseJson['data']);
    //final prefs = SharedPreferences.getInstance();
    // prefs.setString('token', client.accessToken);
    // prefs.setString('email', client.email);
    // prefs.setString('name', client.fullName);

    // UserData userData = UserData();
    // print(userData);
    // if (await userData.saveClient(client)) {
    //   // go to the Dashboard
    //   Navigator.pushReplacement(
    //     context,
    //     MaterialPageRoute(
    //       builder: (context) => const DashboardPage(

    //       ),
    //     ),
    //   );
    //check if user is admin
    // if (user.isAdmin) {
    //   Navigator.pushReplacement(
    //     context,
    //     MaterialPageRoute(
    //       builder: (context) => AdminHomePage(),
    //     ),
    //   );
    // } else {
    //   Navigator.pushReplacement(
    //     context,
    //     MaterialPageRoute(
    //       builder: (context) => HomePage(),
    //     ),
    //   );
    // }
    // Navigator.pushReplacement(
    //     context,
    //     MaterialPageRoute(
    //       builder: (context) => const DashboardPage(
    //             //user: user,
    //       ),
    //     )
    // );
    //       }
    //     } else {
    //       _showDialog(responseJson['message']);
    //     }
    //     break;
    //   case 400:
    //     _showDialog("Invalid email or password");
    //     break;
    //   case 403:
    //     _showDialog("Invalid email or password");
    //     break;
    //   default:
    //     _showDialog("Connection or server error. Try again later");
    //     break;
    // }
    //});
  }

  void _showDialog(
    String message,
  ) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Error"),
        content: Text(
          message,
          style: const TextStyle(
              fontSize: 16.0,
              color: Colors.black,
              fontFamily: "ShadowsIntoLightTwo"),
        ),
      ),
    );
  }
}
