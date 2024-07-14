import 'dart:ui';
import 'package:flutter/material.dart';

class Downstairstage extends StatefulWidget {
  const Downstairstage({Key? key}) : super(key: key);

  @override
  _DownstairstageState createState() => _DownstairstageState();
}

class _DownstairstageState extends State<Downstairstage> {
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
                                  "Downstairs Usage",
                                  style: TextStyle(
                                    fontSize: 42,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  // Add your reminder functionality here
                                },
                                child: Row(
                                  children: [
                                    Image.asset(
                                      'assets/device_Onboard/Export_Icon.png',
                                      width: 32,
                                      height: 32,
                                    ),
                                    SizedBox(width: 20),
                                    Text(
                                      "Export Data",
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
                          SizedBox(height: 20),
                          Container(
                            padding: const EdgeInsets.all(15),
                            height: MediaQuery.of(context).size.height * 0.19,
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
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "On Time Last 24 hrs",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 26,
                                  ),
                                ),
                                SizedBox(height: 20),
                                // Assuming TimeUsageBar is a custom widget you have defined
                                TimeUsageBar(usageRanges: [
                                  RangeValues(0.00, 6.00),
                                  RangeValues(13.25, 18.12),
                                  RangeValues(20.00, 23.59)
                                ]),
                                SizedBox(height: 15),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "-24 hrs",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 17,
                                      ),
                                    ),
                                    Text(
                                      "-12 hrs",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 17,
                                      ),
                                    ),
                                    Text(
                                      "Now",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 17,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 20),
                          Row(
                            children: [
                              SizedBox(
                                width: MediaQuery.of(context).size.width *
                                    0.24, // Adjust width as needed
                                child: Container(
                                  padding: const EdgeInsets.all(15),
                                  height:
                                      MediaQuery.of(context).size.height * 0.48,
                                  decoration: BoxDecoration(
                                    color: const Color(0xFF101010)
                                        .withOpacity(0.5),
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Smart Usage",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 30,
                                        ),
                                      ),
                                      SizedBox(height: 5),
                                      Text(
                                        "Last 7 days",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 20,
                                        ),
                                      ),
                                      Expanded(
                                        child: Center(
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Column(
                                                children: [
                                                  Text(
                                                    "17",
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 60,
                                                    ),
                                                  ),
                                                  Text(
                                                    "Routine Actions",
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 20,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              SizedBox(height: 30),
                                              Column(
                                                children: [
                                                  Text(
                                                    "32",
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 60,
                                                    ),
                                                  ),
                                                  Text(
                                                    "Scene Activations",
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 20,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(width: 20),
                              SizedBox(
                                width: MediaQuery.of(context).size.width *
                                    0.56, // Adjust width as needed
                                child: Container(
                                  padding: const EdgeInsets.all(15),
                                  height:
                                      MediaQuery.of(context).size.height * 0.48,
                                  decoration: BoxDecoration(
                                    color: const Color(0xFF101010)
                                        .withOpacity(0.5),
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Control Log",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 31,
                                        ),
                                      ),
                                      SizedBox(height: 10),
                                      Expanded(
                                        child: ListView(
                                          children: [
                                            ControlLogEntry(
                                              date: "05/10/24 - 12:47pm",
                                              user: "Jane",
                                              value: "24° → 23°",
                                            ),
                                            ControlLogEntry(
                                              date: "05/10/24 - 12:39pm",
                                              user: "Console",
                                              value: "24° → 23°",
                                            ),
                                            ControlLogEntry(
                                              date: "04/10/24 - 8:04pm",
                                              user: "John",
                                              value: "24° → 23°",
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
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
          ),
        ],
      ),
    );
  }
}

class TimeUsageBar extends StatelessWidget {
  final List<RangeValues> usageRanges;

  const TimeUsageBar({Key? key, required this.usageRanges}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        gradient: LinearGradient(
          colors: [Colors.grey.shade700, Colors.grey.shade900],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
      ),
      child: LayoutBuilder(
        builder: (context, constraints) {
          double totalWidth = constraints.maxWidth;

          return Stack(
            children: [
              // Usage ranges
              ...usageRanges.map((range) {
                double startPercentage = range.start / 23.0;
                double endPercentage = range.end / 23.0;
                double start = startPercentage * totalWidth;
                double end = endPercentage * totalWidth;
                double width = end - start;

                return Positioned(
                  left: start,
                  width: width,
                  child: Container(
                    height: 40,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Colors.lightBlue,
                          Color.fromARGB(255, 4, 91, 161)
                        ],
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                      ),
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                );
              }).toList(),

              // Vertical white lines
              ...List.generate(7, (index) {
                double left = totalWidth /
                    8 *
                    (index +
                        1); // Divide the width into 8 parts and use 7 lines

                return Positioned(
                  left: left,
                  child: Container(
                    width: 0.5,
                    height: 40,
                    color: Colors.white,
                  ),
                );
              }),
            ],
          );
        },
      ),
    );
  }
}

class ControlLogEntry extends StatelessWidget {
  final String date;
  final String user;
  final String value;

  const ControlLogEntry({
    Key? key,
    required this.date,
    required this.user,
    required this.value,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    date,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 23,
                        fontFamily: 'outfit',
                        fontWeight: FontWeight.w600),
                  ),
                  SizedBox(width: 30),
                  SizedBox(height: 30),
                  Text(
                    user,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 23,
                        fontFamily: 'outfit',
                        fontWeight: FontWeight.w600),
                  ),
                ],
              ),
            ],
          ),
          Row(
            children: [
              Image.asset(
                'assets/device_Onboard/Small.png',
                width: 50,
                height: 50,
              ),
              SizedBox(width: 10),
              Icon(
                Icons.arrow_forward,
                color: Colors.white,
                size: 24,
              ),
              SizedBox(width: 10),
              Image.asset(
                'assets/device_Onboard/Small.png',
                width: 50,
                height: 50,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
