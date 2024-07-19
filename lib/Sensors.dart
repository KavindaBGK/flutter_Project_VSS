import 'dart:ui';
import 'package:flutter/material.dart';

class SensorDialog extends StatefulWidget {
  const SensorDialog({Key? key}) : super(key: key);

  @override
  _SensorDialogState createState() => _SensorDialogState();
}

class _SensorDialogState extends State<SensorDialog> {
  // Initialize _isSelected as a Map<String, bool>
  Map<String, bool> _isSelected = {
    'sensor1': false,
    'sensor2': false,
    'sensor3': false,
    'sensor4': false,
    'sensor5': false,
    'sensor6': false,
    'sensor7': false,
  };

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
                                  width: 38,
                                  height: 38,
                                ),
                                iconSize: 38,
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
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          SizedBox(height: 30),
                          Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  " Device Sensors",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w400,
                                      fontSize: 17),
                                ),
                              ]),
                          SizedBox(height: 10),
                          _buildFeatureBox(
                              "Downstairs Sensor",
                              "Temperature, Humidity",
                              "Controlling 1 other device",
                              "sensor1"),
                          SizedBox(height: 15),
                          Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  " Wired Sensors",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w400,
                                      fontSize: 17),
                                ),
                              ]),
                          SizedBox(height: 10),
                          _buildFeatureBox(
                              "Wired Sensor #1", "Temperature", "", "sensor2"),
                          SizedBox(height: 10),
                          _buildFeatureBox(
                              "Wired Sensor #2", "Temperature", "", "sensor3"),
                          SizedBox(
                            height: 15,
                          ),
                          Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  " AirTouch Sensors",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w400,
                                      fontSize: 17),
                                ),
                              ]),
                          SizedBox(height: 10),
                          _buildFeatureBox(
                              "ITS Lounge",
                              "Zone Switch, Temperature",
                              "Controlling 1 other device",
                              "sensor4"),
                          SizedBox(height: 10),
                          _buildFeatureBox(
                              "ITS Dining",
                              "Zone Switch,AC Switch, Temperature",
                              "Controlling 1 other device",
                              "sensor5"),
                          SizedBox(height: 10),
                          _buildFeatureBox(
                              "ITS Kitchen",
                              "Zone Switch, Temperature",
                              "Controlling 1 other device",
                              "sensor6"),
                          SizedBox(
                            height: 15,
                          ),
                          Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  " Third Party Sensors",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w400,
                                      fontSize: 17),
                                ),
                              ]),
                          SizedBox(height: 10),
                          _buildFeatureBox(
                              "Eve Temperature",
                              "Temperature, Humidity",
                              "Controlling 1 other device",
                              "sensor7"),
                          SizedBox(height: 15),
                          Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  " Control sensor is set to Auto.",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w400,
                                      fontSize: 17),
                                ),
                              ]),
                          SizedBox(height: 15),
                          Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  " Air Conditioner control will use a sensor value from an On zone that has the largest disparity between set point and measured value.",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w400,
                                      fontSize: 17),
                                ),
                              ]),
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

  Widget _buildFeatureBox(
      String text1, String text2, String text3, String identifier) {
    return Container(
      decoration: BoxDecoration(
        color: Color.fromARGB(255, 0, 0, 0).withOpacity(0.25),
        borderRadius: BorderRadius.circular(10),
      ),
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      margin: EdgeInsets.symmetric(vertical: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Transform.scale(
                scale:
                    1.5, // Adjust this value to increase the size of the radio button
                child: Radio<bool>(
                  value: true,
                  groupValue: _isSelected[identifier] ?? false,
                  activeColor: Colors.white, // Set the active color to white
                  onChanged: (bool? value) {
                    setState(() {
                      _isSelected[identifier] = value ?? false;
                      print(
                          "Radio button ($identifier) value: ${_isSelected[identifier]}");
                    });
                  },
                ),
              ),
              SizedBox(width: 10), // Adjust this value as needed
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    text1,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        //fontFamily: 'Outfit',
                        fontWeight: FontWeight.w600),
                  ),
                  SizedBox(height: 5), // Adjust this value as needed
                  Text(
                    text2,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontFamily: 'Outfit',
                        fontWeight: FontWeight.w700),
                  ),
                ],
              ),
            ],
          ),
          Text(
            text3,
            style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontFamily: 'Outfit',
                fontWeight: FontWeight.w700),
          ),
        ],
      ),
    );
  }
}
