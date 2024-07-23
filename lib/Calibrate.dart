import 'package:flutter/material.dart';
import 'dart:ui';

class CalibrateControl extends StatefulWidget {
  const CalibrateControl({Key? key}) : super(key: key);

  @override
  _CalibrateControlState createState() => _CalibrateControlState();
}

class _CalibrateControlState extends State<CalibrateControl> {
  bool _isSetPointLimitEnabled = false;
  bool _isWeatherAdaptionEnabled = true;
  bool _isAdvancedWeatherAdaptionEnabled = false;

  int selectedTemperature = 17;
  int selectedTemperatureDecimal = 5;
  int selectedHumidity = 67;
  int selectedHumidityDecimal = 3;
  void _onTemperatureChanged(int index) {
    setState(() {
      selectedTemperature = (index % 21) + 10; // Range 10-30
      print('Selected Temperature: $selectedTemperature');
    });
  }

  void _onTemperatureDecimalChanged(int index) {
    setState(() {
      selectedTemperatureDecimal = (index % 10); // Range 0-9
      print('Selected Temperature Decimal: $selectedTemperatureDecimal');
    });
  }

  void _onHumidityChanged(int index) {
    setState(() {
      selectedHumidity = (index % 31) + 50; // Range 50-80
      print('Selected Humidity: $selectedHumidity');
    });
  }

  void _onHumidityDecimalChanged(int index) {
    setState(() {
      selectedHumidityDecimal = (index % 10); // Range 0-9
      print('Selected Humidity Decimal: $selectedHumidityDecimal');
    });
  }

  List<Widget> _buildListWheelChildren({
    required int itemCount,
    required IndexedWidgetBuilder itemBuilder,
  }) {
    return List.generate(
      itemCount,
      (index) => itemBuilder(context, index),
    );
  }

  Widget _buildListWheelScrollView({
    required int itemCount,
    required void Function(int) onSelectedItemChanged,
    required IndexedWidgetBuilder itemBuilder,
    required double itemExtent,
    bool looping = false,
  }) {
    if (looping) {
      return SizedBox(
        height: itemExtent * 5, // Adjust the height to show more rows
        width: 63, // Adjust the width as needed
        child: ListWheelScrollView.useDelegate(
          itemExtent: itemExtent,
          perspective: 0.002,
          diameterRatio: 2,
          physics: FixedExtentScrollPhysics(),
          onSelectedItemChanged: onSelectedItemChanged,
          childDelegate: ListWheelChildLoopingListDelegate(
            children: _buildListWheelChildren(
              itemCount: itemCount,
              itemBuilder: itemBuilder,
            ),
          ),
        ),
      );
    } else {
      return SizedBox(
        height: itemExtent * 5, // Adjust the height to show more rows
        width: 63, // Adjust the width as needed
        child: ListWheelScrollView(
          itemExtent: itemExtent,
          physics: FixedExtentScrollPhysics(),
          onSelectedItemChanged: onSelectedItemChanged,
          children: _buildListWheelChildren(
            itemCount: itemCount,
            itemBuilder: itemBuilder,
          ),
        ),
      );
    }
  }

  Widget _buildTemperatureSelector({
    required int itemCount,
    required double itemExtent,
    required void Function(int) onSelectedItemChanged,
    required IndexedWidgetBuilder itemBuilder,
    bool looping = false,
  }) {
    return Container(
      padding: EdgeInsets.all(1.0),
      decoration: BoxDecoration(
        color: Color.fromARGB(255, 104, 103, 103).withOpacity(0.60),
        shape: BoxShape.circle,
      ),
      child: DefaultTextStyle(
        style: TextStyle(color: Colors.white),
        child: Column(
          children: [
            // ListWheelScrollView
            _buildListWheelScrollView(
              itemCount: itemCount,
              itemExtent: itemExtent,
              onSelectedItemChanged: onSelectedItemChanged,
              itemBuilder: itemBuilder,
              looping: looping,
            ),
            // Lower row
          ],
        ),
      ),
    );
  }

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
                                  "Calibrate Sensors",
                                  style: TextStyle(
                                    fontSize: 42,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 80),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 40.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.37,
                                  height:
                                      MediaQuery.of(context).size.height * 0.62,
                                  padding: EdgeInsets.all(20),
                                  decoration: BoxDecoration(
                                    color: Colors.black.withOpacity(0.55),
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                  child: Column(
                                    children: [
                                      SizedBox(height: 30),
                                      Text(
                                        "Set Calibrated Temperature",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 30,
                                            fontWeight: FontWeight.bold,
                                            fontFamily: 'outfit'),
                                      ),
                                      SizedBox(height: 50),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          SizedBox(width: 125),
                                          _buildTemperatureSelector(
                                            itemCount: 21,
                                            itemExtent: 50,
                                            onSelectedItemChanged:
                                                _onTemperatureChanged,
                                            itemBuilder: (context, index) {
                                              int temperature =
                                                  (index % 21) + 10;
                                              return Center(
                                                child: Text(
                                                  " ${temperature.toString().padLeft(2, '0')}°",
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 28,
                                                    fontWeight: FontWeight.w400,
                                                  ),
                                                ),
                                              );
                                            },
                                            looping: true,
                                          ),
                                          SizedBox(width: 20),
                                          Text(
                                            ".",
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 28,
                                              fontWeight: FontWeight.w400,
                                            ),
                                          ),
                                          SizedBox(width: 20),
                                          _buildTemperatureSelector(
                                            itemCount: 10,
                                            itemExtent: 50,
                                            onSelectedItemChanged:
                                                _onTemperatureDecimalChanged,
                                            itemBuilder: (context, index) {
                                              int temperatureDecimal =
                                                  (index % 10);
                                              return Center(
                                                child: Text(
                                                  temperatureDecimal.toString(),
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 28,
                                                    fontWeight: FontWeight.w400,
                                                  ),
                                                ),
                                              );
                                            },
                                            looping: true,
                                          ),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Text(
                                            "°",
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 28,
                                              fontWeight: FontWeight.w400,
                                            ),
                                          )
                                        ],
                                      ),
                                      SizedBox(height: 30),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          ElevatedButton(
                                            onPressed: () {
                                              // Save QR code action
                                            },
                                            style: ElevatedButton.styleFrom(
                                              primary:
                                                  Color.fromARGB(255, 0, 0, 0)
                                                      .withOpacity(0.25),
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(60.5),
                                                side: BorderSide(
                                                    color: Color.fromARGB(
                                                        255, 228, 38, 25),
                                                    width: 3.5),
                                              ),
                                              minimumSize: Size(190, 61),
                                            ),
                                            child: Text(
                                              "Reset",
                                              style: TextStyle(
                                                  color: Color.fromARGB(
                                                      255, 228, 38, 25),
                                                  fontSize: 26,
                                                  fontWeight: FontWeight.bold,
                                                  fontFamily: 'outfit'),
                                            ),
                                          ),
                                          SizedBox(width: 30),
                                          ElevatedButton(
                                            onPressed: () {
                                              // Copy code action
                                            },
                                            style: ElevatedButton.styleFrom(
                                              primary: Color.fromARGB(
                                                  255, 14, 106, 255),
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(60),
                                              ),
                                              minimumSize: Size(190, 65),
                                            ),
                                            child: Text(
                                              "Save Changes",
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 22,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.37,
                                  height:
                                      MediaQuery.of(context).size.height * 0.62,
                                  padding: EdgeInsets.all(20),
                                  decoration: BoxDecoration(
                                    color: Colors.black.withOpacity(0.55),
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                  child: Column(
                                    children: [
                                      SizedBox(height: 30),
                                      Text(
                                        "Set Calibrated Humidity",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 30,
                                            fontWeight: FontWeight.bold,
                                            fontFamily: 'outfit'),
                                      ),
                                      SizedBox(height: 50),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          SizedBox(width: 125),
                                          _buildTemperatureSelector(
                                            itemCount: 31,
                                            itemExtent: 50,
                                            onSelectedItemChanged:
                                                _onHumidityChanged,
                                            itemBuilder: (context, index) {
                                              int humidity = (index % 31) + 50;
                                              return Center(
                                                child: Text(
                                                  humidity.toString(),
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 28,
                                                    fontWeight: FontWeight.w400,
                                                  ),
                                                ),
                                              );
                                            },
                                            looping: true,
                                          ),
                                          SizedBox(
                                            width: 15,
                                          ),
                                          Text(
                                            ".",
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 28,
                                              fontWeight: FontWeight.w400,
                                            ),
                                          ),
                                          SizedBox(width: 15),
                                          _buildTemperatureSelector(
                                            itemCount: 10,
                                            itemExtent: 50,
                                            onSelectedItemChanged:
                                                _onHumidityDecimalChanged,
                                            itemBuilder: (context, index) {
                                              int humidityDecimal =
                                                  (index % 10);
                                              return Center(
                                                child: Text(
                                                  humidityDecimal.toString(),
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 28,
                                                    fontWeight: FontWeight.w400,
                                                  ),
                                                ),
                                              );
                                            },
                                            looping: true,
                                          ),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Text(
                                            "%",
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 28,
                                              fontWeight: FontWeight.w400,
                                            ),
                                          )
                                        ],
                                      ),
                                      SizedBox(height: 30),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          ElevatedButton(
                                            onPressed: () {
                                              // Save QR code action
                                            },
                                            style: ElevatedButton.styleFrom(
                                              primary:
                                                  Color.fromARGB(255, 0, 0, 0)
                                                      .withOpacity(0.25),
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(60.5),
                                                side: BorderSide(
                                                    color: Color.fromARGB(
                                                        255, 228, 38, 25),
                                                    width: 3.5),
                                              ),
                                              minimumSize: Size(190, 61),
                                            ),
                                            child: Text(
                                              "Reset",
                                              style: TextStyle(
                                                  color: Color.fromARGB(
                                                      255, 228, 38, 25),
                                                  fontSize: 26,
                                                  fontWeight: FontWeight.bold,
                                                  fontFamily: 'outfit'),
                                            ),
                                          ),
                                          SizedBox(width: 30),
                                          ElevatedButton(
                                            onPressed: () {
                                              // Copy code action
                                            },
                                            style: ElevatedButton.styleFrom(
                                              primary: Color.fromARGB(
                                                  255, 14, 106, 255),
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(60),
                                              ),
                                              minimumSize: Size(190, 65),
                                            ),
                                            child: Text(
                                              "Save Changes",
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 22,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          // Add more settings and functionalities here for AutoOffControl
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
