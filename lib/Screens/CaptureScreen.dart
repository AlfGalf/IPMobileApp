import 'package:flutter/material.dart';

import 'MainScreen.dart';


class CaptureScreen extends StatefulWidget {
  
  CaptureScreen({Key key}) : super(key: key);

  @override
  _CaptureScreenState createState() => _CaptureScreenState();
}

class _CaptureScreenState extends State<CaptureScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:Text("Camera"),
        leading: IconButton(
          iconSize: 40,
          icon: Icon(Icons.arrow_left_sharp),
          onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (_) => MainScreen()));
          }
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'History Screen',
              style: TextStyle(fontSize: 20)
            ),
          ],
        ),
      ),
    );
  }
}