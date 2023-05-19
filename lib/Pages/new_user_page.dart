import 'dart:convert';

import 'package:devx_client/components/Toggle.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class NewUserPage extends StatefulWidget {
  final user;
  final url;
  final day;
  const NewUserPage(
      {super.key, required this.user, required this.url, required this.day});

  @override
  State<NewUserPage> createState() => _NewUserPageState();
}

class _NewUserPageState extends State<NewUserPage> {
  Color iconColor = Color.fromRGBO(255, 255, 255, 1);
  bool registered = false;
  bool food = false;
  bool swags = true;

  setRegister(bool e) async {
    var uri = Uri.parse(widget.url + "?action=registration");
    var response = await http.post(uri,
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(
            {"row": widget.user['row'].toString(), "toggle": e.toString()}));
  }

  setFood(bool e) async {
    var uri = Uri.parse("${widget.url}?action=food");
    var response = await http.post(uri,
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(
            {"row": widget.user['row'].toString(), "toggle": e.toString()}));
  }

  setSwags(bool e) async {
    var uri = Uri.parse("${widget.url}?action=swags");
    var response = await http.post(uri,
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(
            {"row": widget.user['row'].toString(), "toggle": e.toString()}));
  }

  @override
  void initState() {
    setState(() {
      registered = widget.user['registration'];
      food = widget.user['food'];
      swags = widget.user['swags'];
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(27, 134, 225, 1),
      body: SafeArea(
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 50),
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        padding: EdgeInsets.all(3),
                        decoration: BoxDecoration(
                          color: Color.fromARGB(255, 255, 255, 255),
                          borderRadius: BorderRadius.circular(100),
                        ),
                        child: CircleAvatar(
                          radius: 35,
                          foregroundImage: NetworkImage(
                              'https://api.multiavatar.com/${widget.user['name'].split(' ')[0]}.png'),
                          backgroundImage: NetworkImage(
                              'https://www.birlawhite.com/storage/blogs/October2022/shutterstock_601690796-min.jpg'),
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        widget.user['name'],
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                      SizedBox(height: 7),
                      Text(
                        widget.user['email'],
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.normal,
                            color: Color.fromARGB(255, 220, 220, 220)),
                      ),
                      SizedBox(height: 35),
                      SizedBox(
                        height: 80,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Column(
                              children: [
                                Image.network(
                                  'https://img.icons8.com/ios-filled/35/google-sheets.png',
                                  color: iconColor,
                                ),
                                SizedBox(height: 7),
                                Text(
                                  widget.user['row'].toString(),
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 16),
                                ),
                              ],
                            ),
                            VerticalDivider(color: Colors.white),
                            Column(
                              children: [
                                Image.network(
                                  'https://img.icons8.com/ios-filled/35/kawaii-pizza.png',
                                  color: iconColor,
                                ),
                                SizedBox(height: 7),
                                Text(
                                  widget.user['dr'].substring(0, 3),
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 16),
                                ),
                              ],
                            ),
                            VerticalDivider(color: Colors.white),
                            (widget.user['school'] == null || !widget.user['school'])  ?
                            ( Column(
                               children: [
                                Image.network(
                                  'https://img.icons8.com/material-rounded/35/t-shirt.png',
                                  color: iconColor,
                                ),
                                SizedBox(height: 7),
                                Text(
                                  widget.user['ts'].toString().substring(0, 3),
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 16),
                                ),
                              ],
                            )) : Column(
                              children: [
                                Image.network(
                                  'https://img.icons8.com/ios-glyphs/35/student-center.png',
                                  color: iconColor,
                                ),
                                SizedBox(height: 7),
                                Text(
                                  'ST',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 16),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                      SizedBox(height: 20),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    children: [
                      // Here is a unintesional gap
                      Expanded(
                        child: Container(
                            width: double.infinity,
                            padding: EdgeInsets.only(top: 30),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.vertical(
                                  top: Radius.circular(30)),
                              color: Colors.white,
                            ),
                            child: Center(
                              child: SingleChildScrollView(
                                child: Column(
                                  children: [
                                    MyToggle(
                                      first: "Registered",
                                      second: "Not Registered",
                                      positive: registered,
                                      cb: (b) async {
                                        await setRegister(b);
                                        setState(() {
                                          registered = b;
                                        });
                                      },
                                    ),
                                    SizedBox(height: 20),
                                    MyToggle(
                                      first: "Food Gained",
                                      second: "Food Not Gained",
                                      positive: food,
                                      cb: (b) async {
                                        await setFood(b);
                                        setState(() {
                                          food = b;
                                        });
                                      },
                                    ),
                                    SizedBox(height: 20),
                                    MyToggle(
                                      first: "Swags gained",
                                      second: "Swags not gained",
                                      positive: swags,
                                      cb: (b) async {
                                        await setSwags(b);
                                        setState(() {
                                          swags = b;
                                        });
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            )),
                      ),
                    ],
                  ),
                )
              ],
            ),
            Positioned(
                top: 20,
                left: 20,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Row(
                    children: [
                      Icon(Icons.arrow_back_ios_new, size: 13),
                      SizedBox(width: 5),
                      Text(
                        "Back",
                        style: TextStyle(fontSize: 16),
                      )
                    ],
                  ),
                )),
          ],
        ),
      ),
    );
  }
}
