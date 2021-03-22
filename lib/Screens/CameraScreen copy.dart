/*
import 'dart:async';
import 'dart:io';
import 'dart:typed_data';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image/image.dart' as image;

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
  bool cameraOff = false;
  Uint8List filePath;

  @override
  void initState() {
    super.initState();
    _controller = CameraController(
      widget.camera,
      ResolutionPreset.medium
    );
    _initializeControllerFuture = _controller.initialize();
    //timer = Timer.periodic(Duration(seconds: 1), (Timer t) => takeImage());

  }

  Future<void> takeImage() async {
    await _initializeControllerFuture;
    try {
      if (cameraOff) {
        return;
      }
      //_controller.setFlashMode(FlashMode.always);
      //new Future.delayed(const Duration(seconds: 1));
      //_controller.setFlashMode(FlashMode.off);
      final test = await _controller.takePicture();
      final test2 = image.decodeImage(File(test.path).readAsBytesSync());

      final file = image.copyResizeCropSquare(test2, 200);
      filePath = file.getBytes();
      return;
      //await _asyncFileUpload(image.);
    }
    catch(e) {
      print(e);
    }
    Future.delayed(const Duration(seconds: 2), takeImage);
  }

  _asyncFileUpload(String filePath) async {
   var request = http.MultipartRequest("POST", Uri.parse("http://10.0.2.2:5000/api/recieve_image"));
   var pic = await http.MultipartFile.fromPath("image", filePath);

   request.files.add(pic);
   var response = await request.send();

   var responseData = await response.stream.toBytes();
   var responseString = String.fromCharCodes(responseData);
   print(responseString);
}

  @override
  void dispose() {
    // Dispose of the controller when the widget is disposed.
    cameraOff = true;
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Take a picture')),
      // Wait until the controller is initialized before displaying the
      // camera preview. Use a FutureBuilder to display a loading spinner
      // until the controller has finished initializing.
      body: FutureBuilder<void>(
        future: takeImage(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            // If the Future is complete, display the preview.
            return Image.memory(filePath);
            return CameraPreview(_controller);
          } else {
            // Otherwise, display a loading indicator.
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}

// A widget that displays the picture taken by the user.
class DisplayPictureScreen extends StatelessWidget {
  final File file;

  const DisplayPictureScreen({Key key, this.file}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Display the Picture')),
      // The image is stored as a file on the device. Use the `Image.file`
      // constructor with the given path to display the image.
      body: Image.file(file),
    );
  }
}
*/