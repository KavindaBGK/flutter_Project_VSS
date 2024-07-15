import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'dart:ui';

class SleepModeControl extends StatefulWidget {
  const SleepModeControl({Key? key}) : super(key: key);

  @override
  _SleepModeControlState createState() => _SleepModeControlState();
}

class _SleepModeControlState extends State<SleepModeControl> {
  bool _isSleepModeEnabled = false;

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
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              IconButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                icon: Image.asset(
                                  'assets/device_Onboard/white_back_arrow.png',
                                  width: 38,
                                  height: 38,
                                ),
                                iconSize: 38,
                              ),
                              SizedBox(width: 20),
                              Expanded(
                                child: Text(
                                  "Downstairs Sleep Mode",
                                  style: TextStyle(
                                    fontSize: 42,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  // Add your export functionality here
                                },
                                child: Row(
                                  children: [
                                    Text(
                                      "Save Changes",
                                      style: TextStyle(
                                        fontSize: 24,
                                        fontFamily: 'Outfit',
                                        fontWeight: FontWeight.w900,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                ),
                                style: ElevatedButton.styleFrom(
                                  primary: Color.fromARGB(255, 14, 106, 255),
                                  onPrimary: Colors.white,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(60.5),
                                  ),
                                  minimumSize: Size(200, 65),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 60),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 20.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Include AC in Sleep Mode",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 29,
                                      fontFamily: 'Outfit',
                                      fontWeight: FontWeight.w900),
                                ),
                                FlutterSwitch(
                                  value: _isSleepModeEnabled,
                                  onToggle: (val) {
                                    setState(() {
                                      _isSleepModeEnabled = val;
                                    });
                                  },
                                  width: 85.0,
                                  height: 45.0,
                                  toggleSize: 30.0,
                                  borderRadius: 60.0,
                                  padding: 8.0,
                                  activeColor: Colors.white,
                                  toggleColor: Colors.black,
                                  inactiveColor: Colors.grey,
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 30),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 20.0),
                            child: Text(
                              "Sleep Comfort Temperature",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 28,
                                  fontFamily: 'Outfit',
                                  fontWeight: FontWeight.w900),
                            ),
                          ),
                          SizedBox(height: 10),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 20.0),
                            child: Text(
                              "Auto adjustments of sleep mode will not exceed the following comfort temperatures.",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 19,
                                  fontFamily: 'Outfit',
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                          SizedBox(height: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              SizedBox(
                                width: 10,
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  // Add your cooling functionality here
                                },
                                child: Row(
                                  children: [
                                    Text(
                                      "Cooling (max): 25°",
                                      style: TextStyle(
                                        fontSize: 24,
                                        fontFamily: 'Outfit',
                                        fontWeight: FontWeight.w900,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                ),
                                style: ElevatedButton.styleFrom(
                                  primary: Color(0xFF000000).withOpacity(0.25),
                                  onPrimary: Colors.white,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(60.5),
                                  ),
                                  minimumSize: Size(250, 70),
                                ),
                              ),
                              SizedBox(width: 20),
                              ElevatedButton(
                                onPressed: () {
                                  // Add your heating functionality here
                                },
                                child: Row(
                                  children: [
                                    Text(
                                      "Heating (min): 18°",
                                      style: TextStyle(
                                        fontSize: 24,
                                        fontFamily: 'Outfit',
                                        fontWeight: FontWeight.w900,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                ),
                                style: ElevatedButton.styleFrom(
                                  primary: Color(0xFF000000).withOpacity(0.25),
                                  onPrimary: Colors.white,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(60.5),
                                  ),
                                  minimumSize: Size(250, 70),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 30),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 20.0),
                            child: Text(
                              "Sleep Mode will increase the set point by 1 degree every hour for 3 hours or until it reaches the comfort temperature. The displayed temperature will remain at your chosen temperature. After 3 hours, the AC will remain at the adjusted set point until Sleep Mode is cancelled. Adjusting device settings will cancel applied sleep settings.",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 19,
                                fontFamily: 'Outfit',
                                fontWeight: FontWeight.w600,
                                height: 1.5, // Increase line spacing
                              ),
                              textAlign: TextAlign.justify, // Justify text
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
