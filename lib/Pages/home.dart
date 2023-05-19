// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'dart:io';

import 'package:devx_client/Pages/analysispage.dart';
import 'package:devx_client/Pages/new_user_page.dart';
import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:http/http.dart' as http;

class Home extends StatefulWidget {
  final url;
  final day;
  Home({super.key, required this.url, required this.day});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  String? result;
  QRViewController? controller;
  String user = "";
  bool fetching = false;

  String getParticipant = "?action=getParticipant";
  // This gets called when the qr is detected
  onQrGet(Barcode qr) async {
    setState(() {
      result = qr.code;
    });

    if (!fetching) {
      setState(() {
        user = "Fetching...";
      });

      setState(() {
        fetching = true;
      });
      // fetch participant
      final uri = Uri.parse("${widget.url}$getParticipant&userId=${qr.code}");
      final response = await http.get(uri, headers: {
        HttpHeaders.acceptHeader: 'application/json',
        HttpHeaders.contentTypeHeader: 'application/x-www-form-urlencoded',
      });
      var data = jsonDecode(response.body);

      if (data['participant']['name'] != null) {
        setState(() {
          user = data['participant']['name'];
        });
        await Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    NewUserPage(user: data['participant'], url: widget.url, day: widget.day)));
      } else {
        setState(() {
          user = "user not found";
        });
      }
      setState(() {
        fetching = false;
      });
    }
  }

  int currentPage = 0;
  PageController pageController =
      PageController(initialPage: 0, keepPage: true);

  @override
  void reassemble() async {
    super.reassemble();

    if (controller != null && currentPage == 0) {
      debugPrint('reassemble : $controller');
      if (Platform.isAndroid) {
        await controller?.pauseCamera();
      } else if (Platform.isIOS) {
        await controller?.resumeCamera();
      }
    }
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (controller != null && currentPage == 0) {
      setState(() {
        controller!.resumeCamera();
      });
    }

    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          actions: [
            if (currentPage == 0)
              IconButton(
                  onPressed: () {
                    controller?.toggleFlash();
                  },
                  icon: Icon(Icons.flash_on))
          ],
          backgroundColor: Color.fromARGB(255, 255, 255, 255),
          elevation: 6,
          foregroundColor: Color.fromARGB(255, 17, 148, 235),
          title: Text("DEVX CLIENT"),
          automaticallyImplyLeading: false,
        ),
        bottomNavigationBar: BottomNavigationBar(
            currentIndex: currentPage,
            onTap: (idx) {
              pageController.animateToPage(idx,
                  duration: Duration(milliseconds: 300), curve: Curves.ease);
            },
            showSelectedLabels: false,
            showUnselectedLabels: false,
            items: [
              BottomNavigationBarItem(icon: Icon(Icons.camera), label: "Scan"),
              BottomNavigationBarItem(
                  icon: Icon(Icons.analytics), label: "Analytics"),
            ]),
        body: PageView(
            controller: pageController,
            onPageChanged: (idx) {
              setState(() {
                currentPage = idx;
              });
            },
            children: [
              Center(
                child: SingleChildScrollView(
                  child: Column(children: [
                    SizedBox(
                      height: 60,
                    ),
                    Text(
                      "Scan The QR",
                      style:
                          TextStyle(fontSize: 27, fontWeight: FontWeight.w600),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      "Scan the E-Ticket send from DevX \nTeam in Email",
                      style: TextStyle(fontSize: 13),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Color.fromARGB(255, 89, 89, 89),
                              offset: Offset(10, 10),
                              blurRadius: 25,
                            ),
                            BoxShadow(
                              color: Colors.white,
                              offset: Offset(-10, -10),
                              blurRadius: 25,
                            )
                          ]),
                      child: Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Container(
                          clipBehavior: Clip.antiAlias,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          width: MediaQuery.of(context).size.width * 0.7,
                          height: MediaQuery.of(context).size.width * 0.7,
                          child: buildQrView(context),
                        ),
                      ),
                    ),
                    SizedBox(height: 80),
                    Text(
                      result != null ? result! : "",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 30),
                    Text(user, style: TextStyle(fontSize: 18)),
                  ]),
                ),
              ),
              AnalysisPage(url:widget.url)
            ]));
  }

  Widget buildQrView(BuildContext context) => QRView(
        key: qrKey,
        onQRViewCreated: _onQRViewCreated,
        overlay: QrScannerOverlayShape(
            borderWidth: 7,
            borderRadius: 10,
            borderColor: Colors.white,
            cutOutHeight: MediaQuery.of(context).size.width * 0.6,
            cutOutWidth: MediaQuery.of(context).size.width * 0.6),
      );

  void _onQRViewCreated(QRViewController controller) {
    setState(() => this.controller = controller);

    bool scanned = false;
    controller.scannedDataStream.listen((code) async {
      if (scanned) {
        return;
      }
      scanned = true;
      await onQrGet(code);
      scanned = false;
    });
  }
}
