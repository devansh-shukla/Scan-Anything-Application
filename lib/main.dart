import 'package:flutter/material.dart';
import 'package:textrecognition/login_page.dart';
import 'package:textrecognition/splash_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Text Recognition',
      theme: ThemeData(
        primarySwatch: Colors.pink,
      ),

      home: SplashScreen(),
    );
  }
}

