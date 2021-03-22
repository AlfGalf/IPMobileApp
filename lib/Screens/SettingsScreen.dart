import 'package:flutter/material.dart';

import '../FileManagement.dart';
import 'MainScreen.dart';
import '../main.dart';
import 'package:http/http.dart' as http;

class SettingsScreen extends StatefulWidget {
  SettingsScreen({Key key}) : super(key: key);

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  TextEditingController txt = TextEditingController();

  Future<String> saveChanges() async {
    preferences.serverUrl = txt.text;
    savePreferences();
    var response = await http.get(Uri.parse(preferences.serverUrl));
    print(response.body);
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("History cleared"),
          content: Text(response.body),
          actions: [
            FlatButton(
              child: Text("OK"),
              onPressed: () {
                Navigator.pop(context);
              }
            )
          ]
        );
      }
    );
    return response.body;
  }
  @override
  Widget build(BuildContext context) {
    txt.text = preferences.serverUrl;

    return Scaffold(
      appBar: AppBar(
        title:Text("Settings"),
        leading: IconButton(
          iconSize: 40,
          icon: Icon(Icons.arrow_left_sharp),
          onPressed: () {
            Navigator.pop(context);
          }
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Spacer(flex: 1),

            Row(
              children: [
                Spacer(flex: 1),
                Expanded(
                  flex: 4,
                  child: Text(
                    'Server URL:',
                    style: TextStyle(fontSize: 15)
                  )
                ),
                Expanded(
                  flex: 5,
                  child: TextField(
                    onSubmitted: (str) {
                      saveChanges();
                    },
                    controller: txt,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Enter URL'
                    ),
                  )
                ),                
                Spacer(flex: 1)
              ],
            ),
            Spacer(flex: 1),
            SizedBox(
              child: ElevatedButton(
                child: Text("Clear History", style: TextStyle(fontSize: 18)),
                onPressed: () async {
                  preferences.history = [];
                  await savePreferences();
                  await showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text("History cleared"),
                        content: Text("All history has been cleared from your device."),
                        actions: [
                          FlatButton(
                            child: Text("OK"),
                            onPressed: () {
                              Navigator.pop(context);
                            }
                          )
                        ]
                      );
                    }
                  );
                },
              ),
              width: 300,
            ),
            SizedBox(
              child: ElevatedButton(
                child: Text("Save & Exit", style: TextStyle(fontSize: 18)),
                onPressed: () {
                  saveChanges();
                  Navigator.pop(context);
                },
              ),
              width: 300,
            ),
            Spacer(flex: 8),
          ],
        ),
      ),
    );
  }
}