import 'package:flutter/material.dart';

class LoadingIndicator {
  bool _isLoading = false;
  static void showLoadingIndicator(BuildContext context, String msg) {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => Dialog(
          child: Container(
            height: 100,
            color: Colors.white,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                CircularProgressIndicator(),
                Padding(
                  padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                  child: Text(
                    msg,
                    style: TextStyle(fontSize: 18),
                  ),
                )
              ],
            ),
          ),

        ),


    );

    new Future.delayed(Duration(seconds: 5),(){
      //_processLogin;
    });


  }
  //Future.delayed(Duration(seconds: 4)).then((_) => _isLoading = true);

  static void hideLoadingDialog(BuildContext context) {
    Navigator.of(context).pop(LoadingIndicator);
  }
}
