import 'package:flutter/material.dart';

import 'MainScreen.dart';

class HistoryScreen extends StatefulWidget {
  HistoryScreen({Key key}) : super(key: key);

  @override
  _HistoryScreenState createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title:Text("History"),
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