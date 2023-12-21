import 'package:flutter/material.dart';
import 'package:hw4/welcomScreen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'SecondScreen.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late bool isFirstTime;

  @override
  void initState() {
    super.initState();
    checkFirstSeen();
  }

  void checkFirstSeen() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool _seen = (prefs.getBool('seen') ?? false);

    if (_seen) {
      setState(() {
        isFirstTime = false;
      });
    } else {
      await prefs.setBool('seen', true);
      setState(() {
        isFirstTime = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My App',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
      ),
      home: isFirstTime == null
          ? CircularProgressIndicator()
          : isFirstTime
          ? WelcomeScreen()
          : SecondScreen(),
    );
  }
}
