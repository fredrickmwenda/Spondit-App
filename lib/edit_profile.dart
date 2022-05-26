import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:iot_app/model/user_profile.dart';
import 'package:iot_app/widgets/custom_app_bar.dart';
import 'package:iot_app/widgets/profile_widget.dart';
import 'package:iot_app/widgets/text_field_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({Key? key, required this.userProfile}) : super(key: key);
  final UserProfile userProfile;

  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  

  final ImagePicker picker = ImagePicker();

  //send the userProfile to the server
  //final response = await http.post(
  //  'http://
  @override
  Widget build(BuildContext context) => ThemeSwitchingArea(
          child: Builder(
        builder: (context) => Scaffold(
            appBar: buildAppBar(context),
            body: ListView(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.symmetric(horizontal: 32),
              children: [
                ProfileWidget(
                  //
                  imagePath: '',
                  isEdit: true,
                  onClicked: () async {
                    final image =
                        await picker.pickImage(source: ImageSource.gallery);
                    if (image != null) {
                      setState(() {
                        widget.userProfile.profilePic = image.path;

                      });
                    }
                  },
                ),
                const SizedBox(height: 32),
                TextField(
                  decoration: const InputDecoration(
                    labelText: 'Full Name',
                  ),
                  onChanged: (value) => widget.userProfile.name = value,
                ),

                TextFieldWidget(
                  label: 'Email',
                  text: widget.userProfile.email,
                  onChanged: (value) => widget.userProfile.email = value,
                ),

                TextFieldWidget(
                  label: 'Phone Number',
                  text: widget.userProfile.phone,
                  onChanged: (value) => widget.userProfile.phone = value,
                ),

                TextFieldWidget(
                  label: 'Address',
                  text: widget.userProfile.address,
                  onChanged: (value) => widget.userProfile.address = value,
                ),

                TextFieldWidget(
                  label: 'City',
                  text: widget.userProfile.city,
                  onChanged: (value) => widget.userProfile.city = value,
                ),

                TextFieldWidget(
                  label: 'State',
                  text: widget.userProfile.state,
                  onChanged: (value) => widget.userProfile.state = value,
                ),

                TextFieldWidget(
                  label: 'Country',
                  text: widget.userProfile.country,
                  onChanged: (value) => widget.userProfile.country = value,
                ),

                TextFieldWidget(
                  label: 'Zip',
                  text: widget.userProfile.zip,
                  onChanged: (value) => widget.userProfile.zip = value,
                ),

                TextFieldWidget(
                  label: 'About',
                  text: widget.userProfile.about,
                  onChanged: (value) => widget.userProfile.about = value,
                  maxLines: 5,
                ),

                //save button
                const SizedBox(height: 32),
                ElevatedButton(
                  onPressed: () async {
                    final prefs = await SharedPreferences.getInstance();
                    final token = prefs.getString('token');
                    final response = await Dio().post(
                      'http://' + widget.userProfile.id + ':8080/api/user/update',
                      data: widget.userProfile.toJson(),
                      options: Options(
                        headers: {
                          'Authorization': 'Bearer $token',
                        },
                      ),
                    );
                    switch (response.statusCode) {
                      case 200:
                        // Navigator.pop(context);
                        //show success message that profile has been updated
                        showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            title: const Text('Profile Updated'),
                            content:
                                const Text('Your profile has been updated'),
                            actions: <Widget>[
                              TextButton(
                                onPressed: () => Navigator.pop(context),
                                child: const Text('OK'),
                              )
                            ],
                          ),
                        );

                        break;
                      case 401:
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Invalid Token'),
                          ),
                        );
                        break;
                      case 422:
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Invalid Data'),
                          ),
                        );
                        break;
                      case 500:
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Server Error'),
                          ),
                        );
                        break;

                      case 404:
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('User Not Found'),
                          ),
                        );
                        break;
                      default:
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text(
                              'Something went wrong',
                              style: TextStyle(color: Colors.white),
                            ),
                            backgroundColor: Colors.red,
                          ),
                        );
                    }
                  },
                  child: const Text('Save'),
                ),
              ],
            )),
      ));
}

// Future getUserProfile() async {
//   final prefs = await SharedPreferences.getInstance();
//   final userProfile = UserProfile.fromJson(prefs.getString('userProfile'));
//   return userProfile;
// }

// //post the userProfile to the server
// Future postUserProfile() async {
// //get the data user entered
//   final prefs = await SharedPreferences.getInstance();
//   final userProfile = UserProfile.fromJson(prefs.getString('userProfile'));
//   final response = await Dio().post(
//     'http://',
//     data: userProfile.toJson(),
//   );
//   return response;
// }
