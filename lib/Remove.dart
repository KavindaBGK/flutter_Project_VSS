import 'package:flutter/material.dart';
import 'dart:ui';

import 'package:google_fonts/google_fonts.dart';

class RemoveDeviceControl extends StatefulWidget {
  @override
  _SelectDeviceControlState createState() => _SelectDeviceControlState();
}

class _SelectDeviceControlState extends State<RemoveDeviceControl> {
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
                    width: MediaQuery.of(context).size.width * 0.52,
                    height: MediaQuery.of(context).size.height * 0.41,
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: const Color(0xFF101010).withOpacity(0.8),
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
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          "Remove Device",
                          style: GoogleFonts.outfit(
                            fontSize: 32,
                            fontWeight: FontWeight.w400,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(height: 30),
                        Text(
                          "Are you sure you want to remove the device:",
                          style: GoogleFonts.outfit(
                            fontSize: 24,
                            fontWeight: FontWeight.w200,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          "[downstairs]?",
                          style: GoogleFonts.outfit(
                            fontSize: 24,
                            fontWeight: FontWeight.w200,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(height: 30),
                        Text(
                          "This cannot be undone.",
                          style: GoogleFonts.outfit(
                            fontSize: 24,
                            fontWeight: FontWeight.w200,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(height: 30),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            ElevatedButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              style: ElevatedButton.styleFrom(
                                primary: Colors.black.withOpacity(0.6),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(60),
                                ),
                                minimumSize: Size(150, 67),
                              ),
                              child: Text(
                                "Cancel",
                                style: GoogleFonts.outfit(
                                    color: Colors.white,
                                    fontSize: 22,
                                    fontWeight: FontWeight.w400),
                              ),
                            ),
                            SizedBox(width: 10),
                            ElevatedButton(
                              onPressed: () {
                                // Save QR code action
                              },
                              style: ElevatedButton.styleFrom(
                                primary: Color.fromARGB(255, 0, 0, 0)
                                    .withOpacity(0.25),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(60.5),
                                  side: BorderSide(
                                      color: Color.fromARGB(255, 228, 38, 25),
                                      width: 3.5),
                                ),
                                minimumSize: Size(200, 61),
                              ),
                              child: Text(
                                "Remove Device",
                                style: GoogleFonts.outfit(
                                  color: Color.fromARGB(255, 228, 38, 25),
                                  fontSize: 22,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
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
