import 'dart:ui';
import 'package:flutter/material.dart';

class TileControlPopupDialog extends StatefulWidget {
  const TileControlPopupDialog({Key? key}) : super(key: key);

  @override
  _TileControlPopupDialogState createState() => _TileControlPopupDialogState();
}

class _TileControlPopupDialogState extends State<TileControlPopupDialog> {
  int selectedHour = 3;
  int selectedMinute = 17;
  bool isPm = true;

  void _onHourChanged(int index) {
    setState(() {
      selectedHour = (index % 12) + 1;
      print('Selected Hour: $selectedHour');
    });
  }

  void _onMinuteChanged(int index) {
    setState(() {
      selectedMinute = index % 60;
      print('Selected Minute: $selectedMinute');
    });
  }

  void _onAmPmChanged(int index) {
    setState(() {
      isPm = index == 1;
      print('Selected AM/PM: ${isPm ? "PM" : "AM"}');
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

  Widget _buildTimeSelector({
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

  Widget _buildTimePickerItem(BuildContext context, int index,
      int selectedValue, int totalItems, String Function(int) valueFormatter) {
    final isSelected = index == selectedValue;
    final color = isSelected ? Colors.white : Colors.black;

    return Center(
      child: Text(
        valueFormatter(index),
        style: TextStyle(
          color: color,
          fontSize: 26, // Increased text size
          fontWeight: FontWeight.w400, // Reduced font weight
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
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Row(
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
                              Text(
                                "Settings Downstairs",
                                style: TextStyle(
                                  fontSize: 42,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 40),
                          Container(
                            width: MediaQuery.of(context).size.width * 0.4,
                            height: MediaQuery.of(context).size.height * 0.5,
                            padding: EdgeInsets.all(20),
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.85),
                              borderRadius: BorderRadius.circular(30),
                            ),
                            child: Column(
                              children: [
                                SizedBox(height: 30),
                                Text(
                                  "Device will turn Off at:",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 30,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'outfit'),
                                ),
                                SizedBox(height: 20),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    _buildTimeSelector(
                                      itemCount: 12,
                                      itemExtent: 55, // Increased itemExtent
                                      onSelectedItemChanged: _onHourChanged,
                                      itemBuilder: (context, index) {
                                        int hour = (index % 12) + 1;
                                        return _buildTimePickerItem(
                                          context,
                                          index,
                                          selectedHour - 1,
                                          12,
                                          (i) => "$hour",
                                        );
                                      },
                                      looping: true, // Looping for hours
                                    ),
                                    SizedBox(width: 20), // Added spacing
                                    Text(
                                      ":",
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 30, // Increased text size
                                        fontWeight: FontWeight
                                            .w400, // Reduced font weight
                                      ),
                                    ),
                                    SizedBox(width: 25), // Added spacing
                                    _buildTimeSelector(
                                      itemCount: 60,
                                      itemExtent: 55, // Increased itemExtent
                                      onSelectedItemChanged: _onMinuteChanged,
                                      itemBuilder: (context, index) {
                                        return _buildTimePickerItem(
                                          context,
                                          index,
                                          selectedMinute,
                                          60,
                                          (i) =>
                                              "${i.toString().padLeft(2, '0')}",
                                        );
                                      },
                                      looping: true, // Looping for minutes
                                    ),
                                    SizedBox(width: 30), // Added spacing
                                    _buildTimeSelector(
                                      itemCount: 2,
                                      itemExtent: 55, // Increased itemExtent
                                      onSelectedItemChanged: _onAmPmChanged,
                                      itemBuilder: (context, index) {
                                        String amPm = index == 0 ? "am" : "pm";
                                        return _buildTimePickerItem(
                                          context,
                                          index,
                                          isPm ? 1 : 0,
                                          2,
                                          (i) => amPm,
                                        );
                                      },
                                      looping: false, // Non-looping for AM/PM
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 40),
                          ElevatedButton(
                            onPressed: () {
                              // Add your cancel timer functionality here
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
                              minimumSize: Size(500, 80),
                              padding: EdgeInsets.symmetric(
                                  horizontal: 40, vertical: 15),
                            ),
                            child: Text(
                              "Cancel Timer",
                              style: TextStyle(
                                  color: Color.fromARGB(255, 228, 38, 25),
                                  fontSize: 26,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'outfit'),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
