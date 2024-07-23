import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

import 'Downstairs_Timer.dart';

class SettingsMain extends StatefulWidget {
  const SettingsMain({Key? key}) : super(key: key);

  @override
  _SettingsDownstairsState createState() => _SettingsDownstairsState();
}

class _SettingsDownstairsState extends State<SettingsMain> {
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
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
                                "Settings Main",
                                style: TextStyle(
                                  fontSize: 42,
                                  //fontFamily: 'Outfit',
                                  fontWeight: FontWeight.w400,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 20),
                          SizedBox(height: 10),
                          _buildImageSet(),
                          SizedBox(height: 20),
                          _buildOperationModeSettings(),
                          SizedBox(height: 10),
                          _buildSmartFeatures(),
                          SizedBox(height: 10),
                          _buildDeviceSettings(),
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

  Widget _buildImageSet() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _buildImageButton(
            'Off at 2:37pm', 'assets/device_Onboard/TimerIcon.png'),
        SizedBox(width: 5),
        _buildImageButton(
            'Usage Stats', 'assets/device_Onboard/InsightsIcon.png'),
        SizedBox(width: 5),
        _buildImageButton(
            'In 6 Routines', 'assets/device_Onboard/RoutinesIcon.png'),
      ],
    );
  }

  Widget _buildImageButton(String text, String imagePath) {
    return ElevatedButton(
      onPressed: () {
        // Add your button functionality here
      },
      style: ElevatedButton.styleFrom(
        primary: Color.fromARGB(255, 0, 0, 0).withOpacity(0.25),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        minimumSize: Size(320, 85),
      ),
      child: Row(
        children: [
          Image.asset(imagePath, width: 50, height: 50, color: Colors.white),
          SizedBox(width: 20),
          Text(
            text,
            textAlign: TextAlign.left,
            style: TextStyle(
                color: Colors.white,
                fontSize: 23,
                fontFamily: 'Outfit',
                fontWeight: FontWeight.w900),
          ),
        ],
      ),
    );
  }

  Widget _buildOperationModeSettings() {
    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            " Operation Mode Settings",
            style: TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18),
          ),
          SizedBox(height: 25),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(width: 1),
              _buildModeButton("Sleep Mode", 'assets/device_Onboard/sleep.png'),
              SizedBox(width: 34),
              _buildModeButton("Auto Mode", 'assets/device_Onboard/Away.png'),
              SizedBox(width: 34),
              _buildModeButton("Eco Mode", 'assets/device_Onboard/Eco.png'),
              SizedBox(width: 34),
              _buildModeButton(
                  "Behaviour Sense", 'assets/device_Onboard/Behind.png'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildModeButton(String text, String imagePath) {
    return ElevatedButton(
      onPressed: () {
        // Add your button functionality here
      },
      style: ElevatedButton.styleFrom(
        primary: Color.fromARGB(255, 0, 0, 0).withOpacity(0.25),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        minimumSize: Size(230, 140),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(imagePath, width: 50, height: 50, color: Colors.white),
          SizedBox(height: 10), // Adjust this value as needed
          Text(
            text,
            textAlign: TextAlign.center,
            style: TextStyle(
                color: Colors.white,
                fontSize: 23,
                fontFamily: 'Outfit',
                fontWeight: FontWeight.w900),
          ),
        ],
      ),
    );
  }

  Widget _buildSmartFeatures() {
    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            " Smart Features",
            style: TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18),
          ),
          SizedBox(height: 20),
          _buildFeatureToggle("Auto Off", "Not set",
              'assets/device_Onboard/Forward Large Icon.png'),
          SizedBox(height: 20),
          _buildFeatureToggle("Brightness Range", "Not set",
              'assets/device_Onboard/Forward Large Icon.png'),
        ],
      ),
    );
  }

  Widget _buildFeatureToggle(String text1, String text2, String imagePath) {
    return ElevatedButton(
      onPressed: () {
        // Add your button functionality here
      },
      style: ElevatedButton.styleFrom(
        primary: Color.fromARGB(255, 0, 0, 0).withOpacity(0.25),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        minimumSize: Size(1022, 85),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                text1,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 23,
                    fontFamily: 'Outfit',
                    fontWeight: FontWeight.w900),
              ),
              SizedBox(height: 5), // Adjust this value as needed
              Text(
                text2,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontFamily: 'Outfit',
                    fontWeight: FontWeight.w700),
              ),
            ],
          ),
          Image.asset(
            imagePath,
            width: 36,
            height: 36,
          ),
        ],
      ),
    );
  }

  Widget _buildDeviceSettings() {
    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            " Device Settings",
            style: TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18),
          ),
          SizedBox(height: 20),
          _buildButton(" Main"),
          SizedBox(height: 20),
          _buildDropdownRowRoom("  Room", "6 Rooms", 6),
          SizedBox(height: 20),
          _buildDropdownRowIcon("  Icon", "", Icons.power_settings_new),
          SizedBox(height: 20),
          _buildFeatureToggle(
              "Combine Devices",
              "Devices will be controlled by one tile.",
              "assets/device_Onboard/Forward Large Icon.png"),
          SizedBox(
            height: 5,
          ),
          _buildDeviceSettingRow(
              "Connected Via: Philips Hue Bridge 00349495", ""),
          SizedBox(
            height: 1,
          ),
          _buildDeviceSettingRow("Wifi Signal Status: Good", ""),
          SizedBox(
            height: 1,
          ),
          _buildDeviceSettingRow("Manufacturer: Philips Hue", ""),
          SizedBox(
            height: 1,
          ),
          _buildDeviceSettingRow("Serial Number: 00112233", ""),
          SizedBox(
            height: 1,
          ),
          _buildDeviceSettingRow("Model: Hue e22 rgb", ""),
          SizedBox(
            height: 1,
          ),
          _buildDeviceSettingRow("Firmware: 6.32", ""),
          SizedBox(
            height: 1,
          ),
          SizedBox(height: 25),
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              primary: Colors.red,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(60.5),
              ),
              minimumSize: Size(200, 50),
            ),
            child: Text(
              "Remove Device",
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'outfit',
                  fontSize: 22),
            ),
          ),
          SizedBox(height: 25),
          //////////
        ],
      ),
    );
  }

  Widget _buildButton(String text) {
    return ElevatedButton(
      onPressed: () {
        // Add your button functionality here
      },
      style: ElevatedButton.styleFrom(
        primary: Color.fromARGB(255, 0, 0, 0).withOpacity(0.25),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(60.5),
        ),
        minimumSize: Size(466, 65),
        alignment: Alignment.centerLeft, // Align content to the left
        padding:
            EdgeInsets.symmetric(horizontal: 15), // Add padding to the left
      ),
      child: Text(
        text,
        style: TextStyle(
            color: Colors.white,
            fontSize: 22,
            fontFamily: 'outfit',
            fontWeight: FontWeight.w600),
      ),
    );
  }

  Widget _buildDropdownRowRoom(String title, String value, int numberOfRooms) {
    String selectedValue = "1  Rooms";
    List<String> roomList =
        List.generate(numberOfRooms, (index) => "${index + 1}  Rooms");

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: double.infinity,
                  child: Text(
                    title,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 23,
                      fontFamily: 'Outfit',
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ),
                SizedBox(
                    height: 5), // Add some space between title and subtitle
                Container(
                  padding: const EdgeInsets.only(
                      left: 12.0), // Add left padding for indentation
                  child: Text(
                    "Rooms assignment set via zones",
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.7),
                      fontSize: 16,
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(width: 10), // Add space between the text and the dropdown
          Container(
            width: 300,
            height: 80,
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.25),
              borderRadius: BorderRadius.circular(60.5),
            ),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                dropdownColor: Colors.black.withOpacity(0.7),
                value: selectedValue,
                items: roomList.map((String room) {
                  return DropdownMenuItem<String>(
                    value: room,
                    child: Row(
                      children: [
                        SizedBox(width: 20),
                        Image.asset(
                          'assets/device_Onboard/downarrow.png',
                          width: 40,
                          height: 40,
                        ),
                        SizedBox(width: 50),
                        Text(
                          room,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 22,
                              fontFamily: 'outfit',
                              fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                  );
                }).toList(),
                onChanged: (newValue) {
                  setState(() {
                    selectedValue = newValue!;
                  });
                },
                icon: SizedBox.shrink(),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDropdownRowIcon(String title, String value, IconData icon) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 3),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 20),
                Text(
                  title,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 23,
                    fontFamily: 'Outfit',
                    fontWeight: FontWeight.w900,
                  ),
                ),
                SizedBox(
                    height: 5), // Add some space between title and subtitle
              ],
            ),
          ),
          SizedBox(width: 10), // Add space between the text and the dropdown
          Container(
            width: 300,
            height: 80,
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.25),
              borderRadius: BorderRadius.circular(60.5),
            ),
            child: Row(
              children: [
                SizedBox(width: 20),
                Image.asset(
                  'assets/device_Onboard/downarrow.png',
                  width: 40,
                  height: 40,
                ),
                SizedBox(width: 70),
                Image.asset(
                  'assets/device_Onboard/PowerIcon.png',
                  width: 40,
                  height: 40,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDeviceSettingRow(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 13.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 23,
                    fontFamily: 'Outfit',
                    fontWeight: FontWeight.w900,
                  ),
                ),
                Text(
                  value,
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.7),
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
