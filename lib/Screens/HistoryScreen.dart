import 'package:flutter/material.dart';
import 'package:ip_app_1/FileManagement.dart';
import 'package:ip_app_1/StorageModel.dart';
import 'package:ip_app_1/main.dart';

import 'MainScreen.dart';

class HistoryScreen extends StatefulWidget {
  HistoryScreen({Key key}) : super(key: key);

  @override
  _HistoryScreenState createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {

  var myColumns = <DataColumn>[
    DataColumn(label: Text('Date')),
    DataColumn(label: Text('Translation'))
  ];

var rows = [];
  loadRows() {
    for (var i in preferences.history) {
      rows.add({'Date': i.creationDate.toString(), 'Translation': i.text});
    }
  }
  
  saveRows() async {
    preferences.history = [];
    for (var i in rows) {
      preferences.history.add(HistoryModel(creationDate: DateTime.parse(i["Date"]), text: i["Translation"]));
    }
    await savePreferences();
  }

  @override
  void initState() {
    super.initState();
    loadRows();
  }

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
        title:Text("History"),
        leading: IconButton(
          iconSize: 40,
          icon: Icon(Icons.arrow_left_sharp),
          onPressed: () {
            Navigator.pop(context);
          }
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          DataTable(
            showCheckboxColumn: false,
            columnSpacing: 65,
            columns: myColumns,
            rows: rows.map((itemRow) => DataRow(
              onSelectChanged: (bool selected) {
                if (selected) {
                  showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text("Full Translation"),
                            content: Text("Full Recording:\n\n" + itemRow['Translation'] + "\n\nDo you wish to delete this item from your history?"),
                            actions: [
                              TextButton(
                                child: Text("Back"),
                                onPressed: () {
                                  Navigator.pop(context);
                                }
                              ),
                              TextButton(
                                child: Text("Delete"),
                                onPressed: () async {
                                  setState(() {             
                                    rows.remove(itemRow);              
                                  });
                                  await saveRows();
                                  Navigator.pop(context);
                                }
                              )
                            ]
                          );
                        }
                      );
                }
              },
              cells: [
                DataCell(Text(itemRow['Date'])),
                DataCell(Text(itemRow['Translation']))
              ]
            )).toList(),
            sortColumnIndex: 0,
            sortAscending: true,
          )
        ] 
      )
    );
  }
}