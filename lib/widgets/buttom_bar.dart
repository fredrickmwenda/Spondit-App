import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ButtomBarPage extends StatelessWidget {
  const ButtomBarPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Stack(
        children: <Widget>[
          ListView.separated(
            itemCount: 5,
            separatorBuilder: (context, index) {
              return const Divider();
            },
            itemBuilder: (context, index){
              return _listItem();
            },
          ),
        ],
      ),
    );
  }

  Widget _listItem() {
    return InkWell(
      child: SizedBox(
        height: 120,
        child: Row(
          children: <Widget>[
            Container(
              width: 50,
              margin: const EdgeInsets.all(10),
              height: 100,
              child: Image.network('src'),
              decoration:  const BoxDecoration(
                boxShadow: [
                  BoxShadow(
                      color: Colors.black26,
                      offset: Offset(0.0, 2.0),
                      blurRadius: 25.0,
                    )
                ]
              ),
            ),
            
            
          ],
        ),
      ),
    );
  }
}
