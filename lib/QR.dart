import 'dart:ui';
import 'package:flutter/material.dart';

class QRControle extends StatefulWidget {
  @override
  _QRControleState createState() => _QRControleState();
}

class _QRControleState extends State<QRControle> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black.withOpacity(0.15),
      body: Stack(
        children: [
          GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              color: Colors.transparent,
            ),
          ),
          Center(
            child: Material(
              color: Colors.transparent,
              child: ClipRect(
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.85,
                    height: MediaQuery.of(context).size.height * 0.88,
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: const Color(0xFF101010).withOpacity(0.5),
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          spreadRadius: 1,
                          blurRadius: 3,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              IconButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                icon: Image.asset(
                                  'assets/device_Onboard/white_back_arrow.png',
                                  width: 48,
                                  height: 48,
                                ),
                                iconSize: 48,
                              ),
                              SizedBox(width: 20),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Downstairs Sensors",
                                    style: TextStyle(
                                      fontSize: 42,
                                      fontWeight: FontWeight.w400,
                                      color: Colors.white,
                                    ),
                                  ),
                                  SizedBox(height: 10),
                                  Text(
                                    "Select a primary sensor to control this device. The average is used when multiple are selected.",
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w400,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          SizedBox(height: 90),
                          Image.asset(
                            'assets/device_Onboard/QR.png',
                            width: 200,
                            height: 200,
                          ),
                          SizedBox(height: 20),
                          Text(
                            "1234-567-8901",
                            style: TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.w400,
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(height: 30),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              ElevatedButton(
                                onPressed: () {
                                  // Save QR code action
                                },
                                style: ElevatedButton.styleFrom(
                                  primary: const Color(0xFF101010),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(60),
                                  ),
                                  minimumSize: Size(240, 80),
                                ),
                                child: Text(
                                  "Save QR",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 22,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                              SizedBox(width: 20),
                              ElevatedButton(
                                onPressed: () {
                                  // Copy code action
                                },
                                style: ElevatedButton.styleFrom(
                                  primary: Color.fromARGB(255, 14, 106, 255),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(60),
                                  ),
                                  minimumSize: Size(240, 80),
                                ),
                                child: Text(
                                  "Copy Code",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 22,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 20),
                          Text(
                            "This code is only valid for 10 minutes.",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w400,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
