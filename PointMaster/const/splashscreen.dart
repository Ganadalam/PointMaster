import 'dart:async';
import 'package:flutter/material.dart';
import 'package:pointmaster/Screen/login_screen.dart';

import '../Screen/mainscreen.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // 3초 후 HomeScreen으로 이동
    Timer(Duration(seconds: 3), () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => LoginScreen()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Image.asset(
          'asset/img/splashlogo.jpg', // 스플래시 이미지
          width: 400,
          height: 400,
        ),
      ),
    );
  }
}
