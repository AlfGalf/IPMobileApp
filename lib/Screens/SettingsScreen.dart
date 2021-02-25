import 'package:flutter/material.dart';

import 'MainScreen.dart';

class SettingsScreen extends StatefulWidget {
  SettingsScreen({Key key}) : super(key: key);

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title:Text("Settings"),
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
              'Settings Screen',
              style: TextStyle(fontSize: 20)
            ),
          ],
        ),
      ),
    );
  }
}