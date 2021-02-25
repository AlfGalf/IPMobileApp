import 'package:flutter/material.dart';
import 'Screens/MainScreen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MaterialApp(home: MainScreen()));
}