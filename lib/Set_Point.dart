import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'dart:ui';

class SetPointRControl extends StatefulWidget {
  const SetPointRControl({Key? key}) : super(key: key);

  @override
  _SetPointControlState createState() => _SetPointControlState();
}

class _SetPointControlState extends State<SetPointRControl> {
  bool _isSetPointLimitEnabled = false;
  bool _isWeatherAdaptionEnabled = true;
  bool _isAdvancedWeatherAdaptionEnabled = false;

  int selectedTemperatureMaxCool = 27;
  int selectedTemperatureMinCool = 25;
  int selectedTemperatureMaxHot = 27;
  int selectedTemperatureMinHot = 25;

  void _onTemperatureMaxChangedCool(int index) {
    setState(() {
      selectedTemperatureMaxCool = (index % 30);
      print('Selected Max Temperature: $selectedTemperatureMaxCool');
    });
  }

  void _onTemperatureMinChangedCool(int index) {
    setState(() {
      selectedTemperatureMinCool = index % 30;
      print('Selected Min Temperature: $selectedTemperatureMinCool');
    });
  }

  void _onTemperatureMaxChangedHot(int index) {
    setState(() {
      selectedTemperatureMaxHot = (index % 30);
      print('Selected Max Temperature: $selectedTemperatureMaxHot');
    });
  }

  void _onTemperatureMinChangedHot(int index) {
    setState(() {
      selectedTemperatureMinHot = index % 30;
      print('Selected Min Temperature: $selectedTemperatureMinHot');
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
        height: itemExtent * 4, // Adjust the height to show more rows
        width: 60, // Adjust the width as needed
        child: ListWheelScrollView.useDelegate(
          itemExtent: itemExtent,
          perspective: 0.005,
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
        width: 60, // Adjust the width as needed
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
                                  "Downstairs Set Point Range",
                                  style: TextStyle(
                                    fontSize: 42,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  // Add your save functionality here
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
                          SizedBox(height: 100),
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
                                      MediaQuery.of(context).size.height * 0.52,
                                  padding: EdgeInsets.all(20),
                                  decoration: BoxDecoration(
                                    color: Colors.black.withOpacity(0.55),
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                  child: Column(
                                    children: [
                                      SizedBox(height: 40),
                                      Text(
                                        "Cooling Range:",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 30,
                                            fontWeight: FontWeight.bold,
                                            fontFamily: 'outfit'),
                                      ),
                                      SizedBox(height: 35),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          SizedBox(width: 55),
                                          Text(
                                            "Min",
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 20,
                                              fontWeight: FontWeight.w400,
                                            ),
                                          ),
                                          SizedBox(width: 15),
                                          _buildTemperatureSelector(
                                            itemCount: 30,
                                            itemExtent: 55,
                                            onSelectedItemChanged:
                                                _onTemperatureMinChangedCool,
                                            itemBuilder: (context, index) {
                                              int temperature = (index % 30);
                                              return Center(
                                                child: Text(
                                                  "${temperature.toString().padLeft(2, '0')}°",
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
                                          SizedBox(width: 45),
                                          Text(
                                            "Max",
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 20,
                                              fontWeight: FontWeight.w400,
                                            ),
                                          ),
                                          SizedBox(width: 15),
                                          _buildTemperatureSelector(
                                            itemCount: 30,
                                            itemExtent: 55,
                                            onSelectedItemChanged:
                                                _onTemperatureMaxChangedCool,
                                            itemBuilder: (context, index) {
                                              int temperature = (index % 30);
                                              return Center(
                                                child: Text(
                                                  "${temperature.toString().padLeft(2, '0')}°",
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
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.37,
                                  height:
                                      MediaQuery.of(context).size.height * 0.52,
                                  padding: EdgeInsets.all(20),
                                  decoration: BoxDecoration(
                                    color: Colors.black.withOpacity(0.55),
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                  child: Column(
                                    children: [
                                      SizedBox(height: 40),
                                      Text(
                                        "Heating Range:",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 30,
                                            fontWeight: FontWeight.bold,
                                            fontFamily: 'outfit'),
                                      ),
                                      SizedBox(height: 35),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          SizedBox(width: 55),
                                          Text(
                                            "Min",
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 20,
                                              fontWeight: FontWeight.w400,
                                            ),
                                          ),
                                          SizedBox(width: 15),
                                          _buildTemperatureSelector(
                                            itemCount: 30,
                                            itemExtent: 55,
                                            onSelectedItemChanged:
                                                _onTemperatureMinChangedHot,
                                            itemBuilder: (context, index) {
                                              int temperature = (index % 30);
                                              return Center(
                                                child: Text(
                                                  "${temperature.toString().padLeft(2, '0')}°",
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
                                          SizedBox(width: 45),
                                          Text(
                                            "Max",
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 20,
                                              fontWeight: FontWeight.w400,
                                            ),
                                          ),
                                          SizedBox(width: 15),
                                          _buildTemperatureSelector(
                                            itemCount: 30,
                                            itemExtent: 55,
                                            onSelectedItemChanged:
                                                _onTemperatureMaxChangedHot,
                                            itemBuilder: (context, index) {
                                              int temperature = (index % 30);
                                              return Center(
                                                child: Text(
                                                  "${temperature.toString().padLeft(2, '0')}°",
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
