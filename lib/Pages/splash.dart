import 'dart:async';

import 'package:devx_client/Pages/daySelect.dart';
import 'package:devx_client/Pages/home.dart';
import 'package:flutter/material.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    super.initState();

    Timer(Duration(seconds: 2), () {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => DaySelect()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Spacer(flex: 2),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "DevX Client",
                  style: TextStyle(fontSize: 35),
                ),
                SizedBox(height: 210),
                Text(
                  "By Arnab Chatterjee",
                  style: TextStyle(fontSize: 15),
                ),
              ],
            ),
            Spacer(flex: 1),
          ],
        ),
      ),
    );
  }
}
