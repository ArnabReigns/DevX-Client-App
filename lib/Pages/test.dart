
import 'package:flutter/material.dart';

class Test extends StatelessWidget {
  const Test({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.orange,
      body: Column(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                margin: EdgeInsets.only(top:MediaQuery.of(context).viewPadding.top),
                height: 100,
                color: Colors.white,
              ),
              Container(
                height: 100,
                color: Colors.white,
              )
            ],
          ),
        ],
      ),
    );
  }
}
