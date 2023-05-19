import 'package:flutter/material.dart';
import 'package:animated_toggle_switch/animated_toggle_switch.dart';

class MyToggle extends StatefulWidget {
  String first;
  String second;
  bool positive;
  Function cb;

  MyToggle(
      {super.key,
      required this.first,
      required this.second,
      required this.cb,
      required this.positive});
  @override
  State<MyToggle> createState() => _MyToggleState();
}

class _MyToggleState extends State<MyToggle> {
  int value = 0;
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return AnimatedToggleSwitch<bool>.dual(
      current: widget.positive,
      first: false,
      second: true,
      dif: 200.0,
      borderColor: Colors.transparent,
      borderWidth: 5.0,
      height: 55,
      boxShadow: const [
        BoxShadow(
          color: Colors.black26,
          spreadRadius: 1,
          blurRadius: 5,
          offset: Offset(0, 0),
        ),
      ],
      onChanged: (e) => widget.cb(e),
      colorBuilder: (b) => b ? Colors.green : Colors.red,
      iconBuilder: (value) => value ? Icon(Icons.done) : Icon(Icons.cancel),
      textBuilder: (value) => value
          ? Center(child: Text(widget.first))
          : Center(child: Text(widget.second)),
    );
  }
}
