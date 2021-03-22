
// Gets the location of the application's configuration file.
import 'dart:convert';
import 'dart:io';

import 'package:path_provider/path_provider.dart';

import 'StorageModel.dart';
import 'main.dart';

Future<String> getConfigLocation(String configLocation) async { 
  final directory = await getApplicationDocumentsDirectory();
  return directory.path + configLocation; 
}

// Updates the global Preferences instance based on the preferences JSON file, if exists.
Future<bool> loadPreferences() async {
  String loc = await getConfigLocation(preferences.configFilePath);
  try {
    final file = File(loc);
    String contents = await file.readAsString();
    preferences = StorageModel.fromJson(json.decode(contents));
  } catch (e) {
    preferences = StorageModel();
    return false;
  }
  return true;
}

// Saves the global Preferences into the preferences JSON file.
Future<bool> savePreferences() async {
  String loc = await getConfigLocation(preferences.configFilePath);
  try {
    final file = File(loc);
    await file.writeAsString(json.encode(preferences.toJson()));
    return true;
  } catch (e) {
    return false;
  }
}