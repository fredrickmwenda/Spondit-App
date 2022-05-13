import 'package:flutter/material.dart';
import 'package:iot_app/constants/constants.dart';
import 'package:iot_app/widgets/button_widget.dart';
import 'package:http/http.dart' as http;

class ProfileScreen extends StatelessWidget {
  late List data;
  var idClient;
  var _isLoading = false;



  //Get Client Data from the API after successful login
  // ignore: missing_return
  // Future<String> loginData (String id) async {
  //   var response = await http.get(
  //     Uri.encodeFull("$apiUrl/api/client/$id"),
  //     headers: {"Accept": "application/json"});
      
  //   setState ( () {
  //     _isLoading = true;
  //     var convertDataToJson = json.decode ( response.body );
  //     data = convertDataToJson['result'];
  //     if (data != null) {
  //       firstName = data[0]['fullname'];
  //       phoneNumber = data[0] ['phone_number'];
  //       email = data[0]['email'];
  //       avi = data[0]['avatar'];
  //     }
  //     print ( data );
  //   } );
  //   return "Success!";

  // }

  // @override
  // void initState() {
  //   super.initState();
  //   setState(() {
  //     loginData(widget.idClient);
  //   });
  // }

  AppBar buildAppBar() {
    return AppBar(
      elevation: 0.70,
      centerTitle: true,
      backgroundColor: kMainAppColor,
      title: const Text(
        "Account",
        style: TextStyle(
          color: kTextColor,
        ),
      ),
      actions: [
        IconButton(
          onPressed: () {},
          icon: const Icon(
            Icons.edit,
            color: kTextColor,
          ),
          // icon: SvgPicture.asset(
          //   SvgImages.edit,
          //   color: AppColors.baseBlackColor,
          //   width: 25,
          // ),
        )
      ],
      shadowColor: kMainAppColor.withOpacity(0.10),
    );
  }

  Widget buildlistTileWidget({String? leading, required String trailing}) {
    return ListTile(
      tileColor: kTextColor,
      leading: Text(
        leading ?? "",
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
      ),
      trailing: Text(
        trailing,
        style: const TextStyle(
          fontSize: 16,
        ),
      ),
    );
  }

  Widget buildBottomListTile({String? leading, String? trailing}) {
    return ListTile(
      onTap: () {},
      tileColor: kSubTextColor,
      leading: Text(
        leading!,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
      ),
      trailing: Wrap(
        spacing: 5,
        children: [
          Text(
            trailing!,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 20,
            ),
          ),
          const Icon(
            Icons.arrow_forward_ios_outlined,
            size: 20,
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kMainAppColor,
      appBar: buildAppBar(),
      body: ListView(
        physics: const BouncingScrollPhysics(),
        children: [
          Container(
            height: 200,
            margin: const EdgeInsets.only(bottom: 10),
            color: kTextColor,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: const [
                  Center(
                    child: CircleAvatar(
                      radius: 35,
                      backgroundColor: Colors.transparent,
                      backgroundImage: NetworkImage(
                          "https://i.pinimg.com/originals/7b/48/65/7b48654b92587f3df86c21d7071bad42.jpg"),
                    ),
                  ),
                  Text(
                    "zuser",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    "zlocation",
                    textAlign: TextAlign.center,
                  )
                ],
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(bottom: 20),
            color: kTextColor,
            child: Column(
              children: [
                buildlistTileWidget(
                    leading: "Full name", trailing: "user"),
                const Divider(),
                buildlistTileWidget(
                  leading: "Email",
                  trailing: "johndoe@gmail.com",
                ),
                const Divider(),
                buildlistTileWidget(
                  leading: "Address",
                  trailing: "123123",
                ),
                const Divider(),

              ],
            ),
          ),

          Container(
            margin: const EdgeInsets.all(20.0),
            child: MyButtonWidget(
              text: "Log Out", 
              color: kMainAppColor, 
              onPress: () {},
            )
          ),
        ],
      ),
    );
  }
}