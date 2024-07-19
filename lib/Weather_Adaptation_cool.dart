
import 'package:flutter/material.dart';
import 'dart:ui';

class WeatherAdaptationControl extends StatefulWidget {
  @override
  _WeatherAdaptationControlState createState() =>
      _WeatherAdaptationControlState();
}

class _WeatherAdaptationControlState extends State<WeatherAdaptationControl> {
  int selectedTemperature = 17;
  int selectedComfortTemperature = 25;

  void _onTemperatureChanged(int index) {
    setState(() {
      selectedTemperature = (index % 21) + 1;
    });
  }

  void _onComfortTemperatureChanged(int index) {
    setState(() {
      selectedComfortTemperature = (index % 21) + 20;
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
        height: itemExtent * 4,
        width: 65,
        child: ListWheelScrollView.useDelegate(
          itemExtent: itemExtent,
          perspective: 0.0065,
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
        height: itemExtent * 3,
        width: 65,
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
            _buildListWheelScrollView(
              itemCount: itemCount,
              itemExtent: itemExtent,
              onSelectedItemChanged: onSelectedItemChanged,
              itemBuilder: itemBuilder,
              looping: looping,
            ),
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
                    width: MediaQuery.of(context).size.width * 0.65,
                    height: MediaQuery.of(context).size.height * 0.68,
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
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Advanced Weather Adaption for Cooling",
                          style: TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.w500,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(height: 50),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            // First Column
                            Container(
                              width: MediaQuery.of(context).size.width * 0.3,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          "Temperature Differential",
                                          style: TextStyle(
                                            fontSize: 25,
                                            fontWeight: FontWeight.w400,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ]),
                                  SizedBox(height: 20),
                                  Center(
                                    child: _buildTemperatureSelector(
                                      itemCount: 21,
                                      itemExtent: 50,
                                      onSelectedItemChanged:
                                          _onTemperatureChanged,
                                      itemBuilder: (context, index) {
                                        final temperature = (index % 21) + 1;
                                        return Center(
                                          child: Text(
                                            " $temperature°",
                                            style: TextStyle(
                                              color: temperature ==
                                                      selectedTemperature
                                                  ? Colors.white
                                                  : Colors.grey,
                                              fontSize: 31,
                                            ),
                                          ),
                                        );
                                      },
                                      looping: true,
                                    ),
                                  ),
                                  SizedBox(height: 20),
                                  Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal:
                                            16.0), // Adjust the value as needed
                                    child: Text(
                                      "This is the amount AirTouch will adjust your set point based on the outdoor temperature.",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 18,
                                      ),
                                      textAlign: TextAlign.justify,
                                    ),
                                  )
                                ],
                              ),
                            ),
                            // Second Column
                            Container(
                              width: MediaQuery.of(context).size.width * 0.3,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          "Comfort Temperature",
                                          style: TextStyle(
                                            fontSize: 25,
                                            fontWeight: FontWeight.w400,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ]),
                                  SizedBox(height: 20),
                                  Center(
                                    child: _buildTemperatureSelector(
                                      itemCount: 21,
                                      itemExtent: 50,
                                      onSelectedItemChanged:
                                          _onComfortTemperatureChanged,
                                      itemBuilder: (context, index) {
                                        final temperature = (index % 21) + 20;
                                        return Center(
                                          child: Text(
                                            " $temperature°",
                                            style: TextStyle(
                                              color: temperature ==
                                                      selectedComfortTemperature
                                                  ? Colors.white
                                                  : Colors.grey,
                                              fontSize: 31,
                                            ),
                                          ),
                                        );
                                      },
                                      looping: true,
                                    ),
                                  ),
                                  SizedBox(height: 20),
                                  Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal:
                                            16.0), // Adjust the value as needed
                                    child: Text(
                                      "The maximum value that the set point can be adjusted to.",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 18,
                                      ),
                                      textAlign: TextAlign.justify,
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 50,
                        ),
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
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w400),
                              ),
                            ),
                            SizedBox(width: 10),
                            ElevatedButton(
                              onPressed: () {
                                // Handle "Confirm" button press
                              },
                              style: ElevatedButton.styleFrom(
                                primary: Color.fromARGB(255, 14, 106, 255),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(60),
                                ),
                                minimumSize: Size(150, 67),
                              ),
                              child: Text(
                                "Confirm",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w400),
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
