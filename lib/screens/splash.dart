import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:async';

import 'package:recipeapp/screens/botton_navbars.dart';
class Splash extends StatefulWidget {
  @override
  State<Splash> createState() => _MyAppState();
}

class _MyAppState extends State<Splash> {
  automate() {
    Timer(Duration(seconds: 4), () {
        setState(() {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => NavScreen()));
      });
    });
  }

  @override
  void initState() {
    super.initState();
    automate();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF252c4a),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            child: Image.asset('assets/images/splash2.png'),
          ),
          CupertinoActivityIndicator(
            radius: 20,color: Colors.white
            ,
          ),
        ],
      ),
    );
  }
}