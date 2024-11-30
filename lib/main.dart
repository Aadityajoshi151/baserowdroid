import 'dart:io';
import 'package:baserowdroid/screens/HomePage.dart';
import 'package:baserowdroid/widgets/TableTile.dart';
import 'package:flutter/material.dart';
import 'Constants.dart' as constants;

void main() {
  HttpOverrides.global = MyHttpOverrides();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: constants.APP_NAME,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}
