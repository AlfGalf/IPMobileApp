import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:ip_app_1/FileManagement.dart';
import 'package:ip_app_1/StorageModel.dart';
import 'package:ip_app_1/main.dart';
import 'package:path/path.dart';

import 'MainScreen.dart';

class CameraScreen extends StatefulWidget {
  CameraDescription camera;
  CameraScreen({Key key, this.camera}) : super(key: key);

  @override
  _CameraScreenState createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {

  CameraController _controller;
  Future<void> _initializeControllerFuture;
  Timer timer;
  bool isRecording = false;
  bool isClosed = false;
  bool wasRecording = false;
  String currentRecording = "";
  String fullRecording = "";

  bool hasFlash = false;

  @override
  void initState() {
    _controller = CameraController(
      widget.camera,
      ResolutionPreset.medium
    );

    _initializeControllerFuture = _controller.initialize();
    takeImage();
    super.initState();
  }

  takeImage() async {
    await _initializeControllerFuture;
    try {
      if (isClosed) {
        return;
      }
      if (!isRecording) {
        Future.delayed(const Duration(seconds: 1), takeImage);
        return;
      }
      
      Future.delayed(const Duration(seconds: 2));

      final image = await _controller.takePicture();
      var resp = await _asyncFileUpload(image.path);
      setState(() {
        if (currentRecording.length > 12) {
          currentRecording = "..." + fullRecording.substring(fullRecording.length - 10, fullRecording.length - 1) + " " + fullRecording[fullRecording.length-1];
        }
        else {
          currentRecording = fullRecording;
        }
        fullRecording += resp['result'];
      });
    }
    catch(e) {
      test(this.context, e.toString());
    }
    Future.delayed(const Duration(seconds: 2), takeImage);
  }

  _asyncFileUpload(String filePath) async {
   var request = http.MultipartRequest("POST", Uri.parse(preferences.serverUrl));
   var pic = await http.MultipartFile.fromPath("image", filePath);

   request.files.add(pic);
   var response = await request.send();

   var responseData = await response.stream.toBytes();
   var responseString = String.fromCharCodes(responseData);
   return jsonDecode(responseString);
}

  @override
  void dispose() {
    // Dispose of the controller when the widget is disposed.
    isRecording = false;
    isClosed = true;
    _controller.dispose();
    super.dispose();
  }


  test(context, text) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Debug"),
          content: Text(text),
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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('ASL Translator')),
      // Wait until the controller is initialized before displaying the
      // camera preview. Use a FutureBuilder to display a loading spinner
      // until the controller has finished initializing.
      body: Column(
        children: [
          FutureBuilder<void>(
            future: _initializeControllerFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                // If the Future is complete, display the preview.
                return CameraPreview(_controller);
              } else {
                // Otherwise, display a loading indicator.
                return Center(child: CircularProgressIndicator());
              }
            },
          ),
          Spacer(flex: 1),
          Expanded(
            flex: 2,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Spacer(flex: 1),
                IconButton(
                  icon: Icon(Icons.videocam), 
                  color: isRecording ? Colors.red : Colors.white,
                  iconSize: 45,
                  onPressed: () {
                    if (isRecording) {
                      setState(() {
                        isRecording = false;
                      });
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text("Finalise Recording"),
                            content: Text("Full Recording:\n\n" + fullRecording + "\n\nDo you wish to save this recording to the app history?"),
                            actions: [
                              TextButton(
                                child: Text("Discard"),
                                onPressed: () {
                                  setState(() {            
                                    fullRecording = "";
                                    currentRecording = "";                  
                                  });
                                  Navigator.pop(context);
                                }
                              ),
                              TextButton(
                                child: Text("Save"),
                                onPressed: () {
                                  preferences.history.add(new HistoryModel(creationDate: DateTime.now(), text: fullRecording));
                                  savePreferences();
                                  // save fullRecording to history
                                  setState(() {            
                                    fullRecording = "";
                                    currentRecording = "";                  
                                  });
                                  Navigator.pop(context);
                                }
                              )
                            ]
                          );
                        }
                      );
                    }
                    else {
                      setState(() {
                        isRecording = true;
                      });                    
                    }
                  }
                ),
                Spacer(flex: 1),
                IconButton(
                  icon: Icon(Icons.info), 
                  iconSize: 45,
                  onPressed: () {
                    setState(() {
                      wasRecording = isRecording;
                      isRecording = false;
                    }); 
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text("How to use"),
                          content: Text('''When recording is active, the camera flash will turn on and then off. \n\nOnce the flash turns off, sign the first letter. Each time the camera flashes, sign a letter.
                          '''),
                          actions: [
                            TextButton(
                              child: Text("OK"),
                              onPressed: () {
                                setState(() {
                                  isRecording = wasRecording;
                                }); 
                                Navigator.pop(context);
                              }
                            )
                          ]
                        );
                      }
                    );
                  }
                ),
                Spacer(flex: 1),
              ]
            )
          ),
         Expanded(
            flex: 1,
            child: Text(isRecording ? "Recording: " + currentRecording : "", 
            style: TextStyle(fontSize: 20))
          ),
          Spacer(flex: 1)
        ]
      )
    );
  }
}