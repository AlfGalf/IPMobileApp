import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'FileManagement.dart';
import 'StorageModel.dart';
import 'Screens/MainScreen.dart';

StorageModel preferences = new StorageModel();


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final cameras = await availableCameras();
  final firstCamera = cameras[1];
  bool val = await loadPreferences();
  if (!val) {
    preferences.history = List<HistoryModel>();
    await savePreferences(); 
  }

  runApp(
    MaterialApp(
      theme: ThemeData.dark(),
      home: MainScreen(
        camera: firstCamera
      )
    )
  );
}