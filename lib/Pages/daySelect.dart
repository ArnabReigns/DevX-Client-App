import 'package:devx_client/Pages/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class DaySelect extends StatelessWidget {
  const DaySelect({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.8,
            height: 50,
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => Home(
                          day: 1,
                            url:
                                "https://script.google.com/macros/s/AKfycbxywsmlPfXnYo6dRQ2b0gGQZ4Q_ZVRDnfBKSGaipH0mmuv3miGEj0jv62CAom-uw4o0/exec")));
              },
              child: Text("Day 1"),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.amber,
                foregroundColor: Colors.black,
              ),
            ),
          ),
          SizedBox(height: 15),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.8,
            height: 50,
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => Home(day:2,url: "https://script.google.com/macros/s/AKfycbzc6CDNPL4ASsHGWUBzCXyxPQm2VY9m2rs777KrZQHifc-IzEdtMEu5QnapSrmIKRt-Vw/exec")));
              },
              child: Text("Day 2"),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.deepPurple,
                foregroundColor: Colors.white,
              ),
            ),
          )
        ],
      )),
    );
  }
}
