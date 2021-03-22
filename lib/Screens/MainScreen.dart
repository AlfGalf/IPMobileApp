import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:ip_app_1/Screens/CameraScreen.dart';

import 'SettingsScreen.dart';
import 'HistoryScreen.dart';

class MainScreen extends StatefulWidget {
  final CameraDescription camera;
  MainScreen({Key key, this.camera}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text("")
        ),
        leading: IconButton(
          iconSize: 40,
          icon: Icon(Icons.history),
          onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (_) => HistoryScreen()));
          }
        ),
        actions: [
          IconButton(
            iconSize: 30,
            icon: Icon(Icons.settings),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (_) => SettingsScreen()));
            },
          )
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Spacer(flex: 1),
            SizedBox(
              child: ElevatedButton(
                child: Text("Tap to translate", style: TextStyle(fontSize: 18)),
                onPressed: () => {
                  Navigator.push(context, MaterialPageRoute(builder: (_) => CameraScreen(camera: widget.camera)))
                },
              ),
              width: 300,
            ),
            Spacer(flex: 1)
          ],
        ),
      ),
    );
  }
}