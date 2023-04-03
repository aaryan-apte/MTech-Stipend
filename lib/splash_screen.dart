import 'dart:async';
//import 'dart:js';

import 'package:flutter/material.dart';
import 'package:mtech_stipend/login.dart';

class SplashScreen extends StatefulWidget {
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    Timer(Duration(seconds: 3), () {
      Navigator.pushReplacement(
          context as BuildContext,
          MaterialPageRoute(
            builder: (context) => MyLogin(),
          ));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: Center(
          child: Image.asset('assets/logo.png' ,height: 200,width: 200,),
        ),
        ),
      );
  }
}
