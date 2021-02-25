import 'package:flutter/material.dart';

import 'SettingsScreen.dart';
import 'HistoryScreen.dart';

class MainScreen extends StatefulWidget {
  MainScreen({Key key}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: IconButton(
            iconSize: 40,
            icon: Icon(Icons.info_outline),
            onPressed: () {
              print("hi!");
            },
          )
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
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Tap to translate',
              style: TextStyle(fontSize: 20)
            ),
            IconButton(
              iconSize: 70,
              icon: Icon(Icons.play_circle_outline),
              onPressed: () => {
                print("Test!")
              },
            ),
          ],
        ),
      ),
    );
  }
}