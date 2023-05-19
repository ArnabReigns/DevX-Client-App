import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class UserDetails extends StatefulWidget {
  final user;
  final url;

  const UserDetails({super.key, required this.user, required this.url});

  @override
  State<UserDetails> createState() => _UserDetailsState();
}

class _UserDetailsState extends State<UserDetails> {
  bool register = false;
  bool food = false;
  bool swag = false;

  setRegister() async {
    var uri = Uri.parse("${widget.url}?action=registration");
    var response = await http.post(uri,
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode({
          "row": widget.user['row'].toString(),
          "toggle": register.toString()
        }));
  }

  setFood() async {
    var uri = Uri.parse("${widget.url}?action=food");
    var response = await http.post(uri,
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(
            {"row": widget.user['row'].toString(), "toggle": food.toString()}));
  }

  setSwags() async {
    var uri = Uri.parse("${widget.url}?action=swags");
    var response = await http.post(uri,
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(
            {"row": widget.user['row'].toString(), "toggle": swag.toString()}));
  }

  @override
  void initState() {
    setState(() {
      register = widget.user['registration'];
      food = widget.user['food'];
      swag = widget.user['swags'];
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Color.fromARGB(255, 223, 223, 223),
      appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.white,
          elevation: 5,
          foregroundColor: Colors.black,
          title: Text('USER DETAILS')),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 10),
              Text("INFO",
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 2, 2, 2))),
              Divider(),
              SizedBox(height: 10),
              ListItem(
                text: widget.user['name'],
                lable: "Name",
              ),
              ListItem(
                text: widget.user['email'],
                lable: "Email",
              ),
              ListItem(
                text: widget.user['dr'],
                lable: "Food",
              ),
              ListItem(
                text: widget.user['ts'],
                lable: "Tshirt",
              ),
              ListItem(
                text: widget.user['row'].toString(),
                lable: "Row",
              ),
              SizedBox(height: 20),
              Text("ACTIONS",
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 0, 0, 0))),
              Divider(),
              SizedBox(height: 10),
              Column(
                children: [
                  Container(
                    margin: EdgeInsets.only(bottom: 10),
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    decoration: BoxDecoration(
                        color: Color.fromARGB(255, 255, 255, 255),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.grey,
                              blurRadius: 5,
                              spreadRadius: -1)
                        ],
                        borderRadius: BorderRadius.circular(10)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Register",
                          style: TextStyle(fontSize: 18),
                        ),
                        Switch(
                            value: register,
                            onChanged: (e) {
                              setState(() => {register = e});
                              setRegister();
                            }),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(bottom: 10),
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    decoration: BoxDecoration(
                        color: Color.fromARGB(255, 255, 255, 255),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.grey,
                              blurRadius: 5,
                              spreadRadius: -1)
                        ],
                        borderRadius: BorderRadius.circular(10)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Food",
                          style: TextStyle(fontSize: 18),
                        ),
                        Switch(
                            value: food,
                            onChanged: (e) {
                              setState(() => food = e);
                              setFood();
                            }),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(bottom: 10),
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    decoration: BoxDecoration(
                        color: Color.fromARGB(255, 255, 255, 255),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.grey,
                              blurRadius: 5,
                              spreadRadius: -1)
                        ],
                        borderRadius: BorderRadius.circular(10)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Swag",
                          style: TextStyle(fontSize: 18),
                        ),
                        Switch(
                            value: swag,
                            onChanged: (e) {
                              setState(() => swag = e);
                              setSwags();
                            }),
                      ],
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

class ListItem extends StatelessWidget {
  ListItem({super.key, required this.text, required this.lable});

  String text;
  String lable;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
          // gradient: LinearGradient(colors: [
          //   Color.fromARGB(255, 22, 166, 244),
          //   Color.fromARGB(255, 108, 28, 213)
          // ]),
          boxShadow: [
            BoxShadow(color: Colors.grey, blurRadius: 5, spreadRadius: -1)
          ],
          color: Color.fromARGB(255, 255, 255, 255),
          borderRadius: BorderRadius.circular(5)),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: SizedBox(
            width: double.infinity,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  Icon(Icons.person),
                  Text(
                    "$lable: ",
                    style: TextStyle(
                        color: Color.fromARGB(255, 0, 0, 0),
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    text,
                    style: TextStyle(
                        color: Color.fromARGB(255, 35, 35, 35),
                        fontSize: 16,
                        fontWeight: FontWeight.normal),
                  ),
                  // Spacer(flex: 1,),
                ],
              ),
            )),
      ),
    );
  }
}
