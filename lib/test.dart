import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class TileControlPopupDialog extends StatefulWidget {
  const TileControlPopupDialog({Key? key}) : super(key: key);

  @override
  _TileControlPopupDialogState createState() => _TileControlPopupDialogState();
}

class _TileControlPopupDialogState extends State<TileControlPopupDialog> {
  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      GestureDetector(
        onTap: () {
          Navigator.pop(context);
        },
        child: Container(
          color: Color.fromARGB(255, 255, 255, 255)
              .withOpacity(0.15), // Set the barrier color here
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
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
              padding: const EdgeInsets.fromLTRB(0, 20, 0, 20),
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
            ),
          ),
        ),
      ))
    ]);
  }
}
