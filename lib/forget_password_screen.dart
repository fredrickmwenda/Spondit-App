import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:iot_app/login.dart';
import 'package:iot_app/utilities/api_urls.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({Key? key}) : super(key: key);
  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  TextEditingController controllerEmail = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 30);,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 250,
            ),
            Text(
              'Reset Password',
              style: titleText,
            ),
            SizedBox(
              height: 5,
            ),
            Text(
              'Please enter your email address',
              style: subTitle.copyWith(fontWeight: FontWeight.w600),
            ),
            SizedBox(
              height: 10,
            ),
            // ResetForm(),
            Padding(
              padding: EdgeInsets.only(top: 20),
              child: TextFormField(

                decoration: InputDecoration(
                  hintText: 'Email',
                  hintStyle: TextStyle(color: kTextFieldColor),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: kPrimaryColor)
                  )
                ),
                //text editing controller
                controller: _emailController,
              ),
            );
            SizedBox(
              height: 40,
            ),
            GestureDetector(
                onTap: () {
                  //call reset password api using email from TextFormField
                  _resetPassword(email);
                  
                  // _resetPassword('email');
                  // Navigator.push(
                  //     context,
                  //     MaterialPageRoute(
                  //       builder: (context) => LogInScreen(),
                  //     ));
                },
                child: PrimaryButton(buttonText: 'Reset Password')),
          ],
        ),
      ),
    );
  }



  //reset password api
    //reset password api
  Future<void> _resetPassword(String email) async {
    Map<String, String> data = {
      "email": email,
    };
    try {
      //use dio to make the request
      await Dio().post(ApiUrls().getResetPasswordUrl(), data: data)
          .then((response)  async{
        print(response.data);
        //switch through the response status code
        switch (response.statusCode) {
          case 200:
            print("success");
            //if success, create client object  and save it in shared preferences

            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => const LoginScreen(),
              ),
            );
            break;
          case 400:
            print("bad request");
            break;
          case 401:
            print("unauthorized");
            break;
          case 404:
            print("not found");
            break;
          case 500:
            print("server error");
            break;
          default:
            print("unknown error");
            break;
        }

      });
    }
    catch (e) {
      print(e.toString());
    }
  }
}

