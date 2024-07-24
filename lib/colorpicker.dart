import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:google_fonts/google_fonts.dart';
import 'POWER.dart';
import 'Remove.dart';
import 'Room_Select.dart';
import 'Select_Icon_RGB.dart';

class ColorControl extends StatefulWidget {
  final String initialScreenName;
  const ColorControl({Key? key, required this.initialScreenName})
      : super(key: key);

  @override
  _ColorControlState createState() => _ColorControlState();
}

class _ColorControlState extends State<ColorControl> {
  late String currentScreen;
  late PageController _pageController;
  Color currentColor = Colors.orange;
  double brightness = 85.0;
  double hue = 340.0;
  double temp = 6700;
  double _value = 0.0;
  bool isToggled = true;
  double opacity = 0.8;

  bool _isSleepModeEnabled = true;
  bool _isSleepModeEnabledAway = false;
  bool _MaxBrightness = true;
  bool _NightLight = false;

  @override
  void initState() {
    super.initState();
    currentScreen = widget.initialScreenName;
    _pageController = PageController(initialPage: _initialPageIndex());
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  int _initialPageIndex() {
    switch (widget.initialScreenName) {
      case 'ColorPicker':
        return 0;
      default:
        return 0;
    }
  }

  void _navigateToScreen(String screenName) {
    int pageIndex = 0;
    switch (screenName) {
      case 'ColorPicker':
        pageIndex = 0;
        break;
      case 'SettingMain':
        pageIndex = 1;
        break;
      case 'SleepMode':
        pageIndex = 2;
        break;
      case 'AwayMode':
        pageIndex = 3;
        break;
      case 'EcoMode':
        pageIndex = 4;
        break;
      case 'SetTimer':
        pageIndex = 5;
        break;
      case 'Usage':
        pageIndex = 6;
        break;
      case 'Route':
        pageIndex = 7;
        break;
      default:
        pageIndex = 0;
    }
    _pageController.jumpToPage(
        pageIndex); // Use jumpToPage instead of animateToPage whenOutsideReports
    setState(() {
      currentScreen = screenName;
    });
  }

  void changeColor(double color) {
    setState(() {
      _value = color;
      currentColor = HSVColor.fromAHSV(1.0, _value * 360, 1.0, 1.0).toColor();
    });
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
                      child: PageView(
                        controller: _pageController,
                        physics: NeverScrollableScrollPhysics(),
                        children: [
                          _buildColorPicker(context),
                          _buildSettingMain(context),
                          _buildSleepMode(context),
                          _buildAwaypMode(context),
                          _buildEcoMode(context),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ));
  }

  @override
  Widget _buildColorPicker(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
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
              const SizedBox(width: 20),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Main",
                    style: GoogleFonts.outfit(
                      fontSize: 42,
                      fontWeight: FontWeight.w400,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    "Light",
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
              const Spacer(),
              Row(
                children: [
                  Image.asset(
                    'assets/device_Onboard/Timer_Icon.png',
                    width: 38,
                    height: 38,
                  ),
                  const SizedBox(width: 5),
                  const Text(
                    "Off at 2:37pm",
                    style: TextStyle(
                        fontSize: 24,
                        color: Colors.white,
                        fontWeight: FontWeight.w400),
                  ),
                ],
              ),
              const SizedBox(width: 20),
              ElevatedButton(
                onPressed: () {
                  _navigateToScreen('SettingMain');
                },
                child: Row(
                  children: [
                    Image.asset(
                      'assets/device_Onboard/Hamburger_Icon.png',
                      width: 32,
                      height: 32,
                    ),
                    SizedBox(width: 20),
                    Text(
                      "More",
                      style: GoogleFonts.outfit(
                        fontSize: 24,
                        fontWeight: FontWeight.w400,
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
                  minimumSize: Size(144, 72),
                ),
              ),
            ],
          ),
          const SizedBox(height: 80),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CustomPowerButton(
                isPowerOn: false,
                onPressed: () {},
                buttonSize: 110,
                gradientColors: [
                  Color.fromARGB(255, 212, 202, 202),
                  currentColor
                ],
                iconImage: "assets/device_Onboard/test.png",
              ), // Example icon
              const SizedBox(width: 150),
              Text(
                "${brightness.toInt()}%",
                style: GoogleFonts.outfit(
                  fontSize: 100,
                  fontWeight: FontWeight.w400,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          const SizedBox(height: 55),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                width: 32,
              ),
              Text(
                "Brightness",
                style: GoogleFonts.outfit(
                  fontSize: 18,
                  fontWeight: FontWeight.w300,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          SizedBox(
            height: 80, // Set your desired height here
            child: SliderTheme(
              data: SliderTheme.of(context).copyWith(
                activeTrackColor: currentColor, // Set to currentColor
                inactiveTrackColor:
                    Colors.grey[988], // Inactive track color (dark grey)
                trackHeight: 16.0, // Track height
                thumbColor: Colors.white, // Thumb color
                thumbShape: RoundSliderThumbShape(
                  enabledThumbRadius: 25.0, // Thumb shape and size
                ),
                overlayColor: Color(0x29FF9800), // Overlay color
                overlayShape: RoundSliderOverlayShape(
                  overlayRadius: 30.0, // Overlay shape and size
                ),
              ),
              child: Slider(
                value: brightness,
                min: 0,
                max: 100,
                onChanged: (double value) {
                  setState(() {
                    brightness = value;
                  });
                },
              ),
            ),
          ),
          const SizedBox(height: 50),
          Row(
            children: [
              const SizedBox(width: 25),
              GestureDetector(
                onTap: () {
                  setState(() {
                    isToggled = !isToggled;
                  });
                },
                child: Container(
                  width: 144,
                  height: 64,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(60),
                    color: Colors.black, // Always black background
                  ),
                  child: Stack(
                    children: [
                      Positioned(
                        left: isToggled
                            ? 80
                            : 0, // Adjusted position based on the width of the toggle
                        child: Container(
                          width: 64,
                          height: 64,
                          decoration: BoxDecoration(
                            color: Colors.white, // Always white toggle
                            shape: BoxShape.circle,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(
                                16.0), // Adjusted padding for better image fit
                            /*child: Image.asset(
                                              'assets/device_Onboard/setting.png', // Change the path for different images if needed
                                              fit: BoxFit.contain,
                                            ),*/
                          ),
                        ),
                      ),
                      Positioned(
                        left: 12,
                        top: 12,
                        child: Image.asset(
                          'assets/device_Onboard/temp.png', // Change the path for different images if needed
                          width: 40,
                          height: 40,
                        ),
                      ),
                      Positioned(
                        right: 12,
                        top: 12,
                        child: Image.asset(
                          'assets/device_Onboard/Colour.png', // Change the path for different images if needed
                          width: 40,
                          height: 40,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 0),
              const Spacer(),
              if (isToggled) ...[
                Text(
                  "${hue.toInt()}°",
                  style: GoogleFonts.outfit(
                      fontSize: 42,
                      color: Colors.white,
                      fontWeight: FontWeight.w400),
                ),
                SizedBox(
                  width: 22,
                ),
                Container(
                  width: 684,
                  height: 10,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Colors.red,
                        Colors.deepOrange,
                        Colors.orange,
                        Colors.amber,
                        Colors.yellow,
                        Colors.lime,
                        Colors.lightGreen,
                        Colors.green,
                        Colors.teal,
                        Colors.cyan,
                        Colors.lightBlue,
                        Colors.blue,
                        Colors.indigo,
                        Colors.purple,
                        Colors.deepPurple,
                        Colors.pink,
                      ],
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: SliderTheme(
                    data: SliderTheme.of(context).copyWith(
                      trackHeight: 20,
                      thumbShape: RoundSliderThumbShape(
                        enabledThumbRadius: 15,
                      ),
                      overlayShape: RoundSliderOverlayShape(
                        overlayRadius: 30,
                      ),
                      thumbColor: Colors.white,
                      overlayColor: Colors.white.withOpacity(0.2),
                      activeTrackColor: Colors.transparent,
                      inactiveTrackColor: Colors.transparent,
                    ),
                    child: Slider(
                      min: 0.0,
                      max: 1.0,
                      value: _value,
                      onChanged: (value) {
                        setState(() {
                          _value = value;
                          currentColor =
                              HSVColor.fromAHSV(1.0, _value * 360, 1.0, 1.0)
                                  .toColor();
                        });
                      },
                    ),
                  ),
                ),
              ] else ...[
                Text(
                  "${temp.toInt()}K",
                  style: GoogleFonts.outfit(
                      fontSize: 42,
                      color: Colors.white,
                      fontWeight: FontWeight.w400),
                ),
                SizedBox(
                  width: 22,
                ),
                Container(
                  width: 684,
                  height: 10,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Color.fromARGB(255, 2, 124, 224),
                        Colors.white,
                        Colors.orange,
                        Colors.deepOrange,
                      ],
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: SliderTheme(
                    data: SliderTheme.of(context).copyWith(
                      trackHeight: 20,
                      thumbShape: RoundSliderThumbShape(
                        enabledThumbRadius: 15,
                      ),
                      overlayShape: RoundSliderOverlayShape(
                        overlayRadius: 30,
                      ),
                      thumbColor: Colors.white,
                      overlayColor: Colors.white.withOpacity(0.2),
                      activeTrackColor: Colors.transparent,
                      inactiveTrackColor: Colors.transparent,
                    ),
                    child: Slider(
                      min: 0.0,
                      max: 9999.0,
                      value: temp,
                      onChanged: (value) {
                        setState(() {
                          temp = value;
                        });
                      },
                    ),
                  ),
                ),
              ],
              const SizedBox(width: 30)
            ],
          ),
          const SizedBox(height: 50),
          Row(
            children: [
              SizedBox(
                width: 25,
              ),
              ElevatedButton(
                onPressed: () {
                  // Add your reminder functionality here
                },
                child: Row(),
                style: ElevatedButton.styleFrom(
                  primary: currentColor,
                  onPrimary: currentColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(80),
                  ),
                  minimumSize: Size(141, 64),
                ),
              ),
              const SizedBox(width: 60),
              if (isToggled) ...[
                Expanded(
                  child: Text(
                    "${(opacity * 100).toInt()}%",
                    style: GoogleFonts.outfit(
                        fontSize: 42,
                        color: Colors.white,
                        fontWeight: FontWeight.w400),
                  ),
                ),
                Container(
                  width: 684,
                  height: 10,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Colors.white, currentColor],
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: SliderTheme(
                    data: SliderTheme.of(context).copyWith(
                      trackHeight: 20,
                      thumbShape: RoundSliderThumbShape(enabledThumbRadius: 15),
                      overlayShape: RoundSliderOverlayShape(overlayRadius: 30),
                      thumbColor: Colors.white,
                      overlayColor: Colors.white.withOpacity(0.2),
                      activeTrackColor: Colors.transparent,
                      inactiveTrackColor: Colors.transparent,
                    ),
                    child: Slider(
                      min: 0.0,
                      max: 1.0,
                      value: opacity,
                      onChanged: (value) {
                        setState(() {
                          opacity = value;
                        });
                      },
                    ),
                  ),
                ),
              ],
              const SizedBox(width: 30)
            ],
          ),
        ],
      ),
    );
  }

  //////////////////////////////////////////////////////////////////////////
  Widget _buildSettingMain(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              IconButton(
                onPressed: () {
                  _navigateToScreen('ColorPicker');
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
                style: GoogleFonts.outfit(
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
            style: GoogleFonts.outfit(
                color: Colors.white, fontSize: 24, fontWeight: FontWeight.w400),
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
            style: GoogleFonts.outfit(
                color: Colors.white, fontWeight: FontWeight.w300, fontSize: 20),
          ),
          SizedBox(height: 25),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(width: 1),
              _buildModeButton("Sleep Mode", 'assets/device_Onboard/sleep.png'),
              SizedBox(width: 34),
              _buildModeButton("Away Mode", 'assets/device_Onboard/Away.png'),
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
        if (text == 'Sleep Mode') {
          _navigateToScreen('SleepMode');
        }
        if (text == 'Away Mode') {
          _navigateToScreen('AwayMode');
        }
        if (text == 'Eco Mode') {
          _navigateToScreen('EcoMode');
        }
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
            style: GoogleFonts.outfit(
                color: Colors.white, fontSize: 24, fontWeight: FontWeight.w400),
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
            style: GoogleFonts.outfit(
                color: Colors.white, fontWeight: FontWeight.w300, fontSize: 20),
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
                style: GoogleFonts.outfit(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.w400),
              ),
              SizedBox(height: 5), // Adjust this value as needed
              Text(
                text2,
                style: GoogleFonts.outfit(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w300),
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
            style: GoogleFonts.outfit(
                color: Colors.white, fontWeight: FontWeight.w300, fontSize: 20),
          ),
          SizedBox(height: 20),
          _buildButton(" Main"),
          SizedBox(height: 20),
          _buildDropdownRowRoom("  Lounge"),
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
          SizedBox(height: 5),
          ElevatedButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return RemoveDeviceControl();
                },
              );
            },
            style: ElevatedButton.styleFrom(
              primary: Color.fromARGB(255, 0, 0, 0).withOpacity(0.25),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(60.5),
                side: BorderSide(
                    color: Color.fromARGB(255, 228, 38, 25), width: 2.5),
              ),
              minimumSize: Size(200, 50),
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
        style: GoogleFonts.outfit(
            color: Colors.white, fontSize: 22, fontWeight: FontWeight.w400),
      ),
    );
  }

  Widget _buildDropdownRowRoom(String title) {
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
                  "   Room",
                  style: GoogleFonts.outfit(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                SizedBox(
                    height: 5), // Add some space between title and subtitle
              ],
            ),
          ),
          SizedBox(width: 10), // Add space between the text and the dropdown
          InkWell(
            onTap: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return SelectRoom();
                },
              );
            },
            borderRadius: BorderRadius.circular(60.5),
            child: Container(
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
                  Text(
                    title,
                    style: GoogleFonts.outfit(
                      color: Colors.white,
                      fontSize: 23,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
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
                  "   Icon",
                  style: GoogleFonts.outfit(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                SizedBox(
                    height: 5), // Add some space between title and subtitle
              ],
            ),
          ),
          // Add space between the text and the dropdown
          SizedBox(width: 10),
          InkWell(
            onTap: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return SelectDeviceRGBControl();
                },
              );
            },
            borderRadius: BorderRadius.circular(60.5),
            child: Container(
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
                  SizedBox(width: 90),
                  Image.asset(
                    'assets/device_Onboard/test.png',
                    width: 40,
                    height: 40,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDeviceSettingRow(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 1.0),
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
                  style: GoogleFonts.outfit(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.w300,
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
//////////////////////////////////////////////////////////////////////////////////////////////////////////////

  Widget _buildSleepMode(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                onPressed: () {
                  _navigateToScreen('AC');
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
                  "Main Sleep Mode",
                  style: GoogleFonts.outfit(
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
                      style: GoogleFonts.outfit(
                        fontSize: 24,
                        fontWeight: FontWeight.w400,
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
          Column(
            children: [
              IgnorePointer(
                ignoring: _NightLight,
                child: Opacity(
                  opacity: !_NightLight ? 1.0 : 0.5,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Adjust colour temperature",
                                  style: GoogleFonts.outfit(
                                      color: Colors.white,
                                      fontSize: 24,
                                      fontWeight: FontWeight.w400),
                                ),
                                FlutterSwitch(
                                  value: _isSleepModeEnabledAway,
                                  onToggle: (val) {
                                    setState(() {
                                      _isSleepModeEnabledAway = val;
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
                            SizedBox(height: 5),
                            Text(
                              "If the device’s colour is set using temperature, the temperature value will become warmer.",
                              style: GoogleFonts.outfit(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w300),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 20),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Max Brightness",
                                  style: GoogleFonts.outfit(
                                      color: Colors.white,
                                      fontSize: 24,
                                      fontWeight: FontWeight.w400),
                                ),
                                FlutterSwitch(
                                  value: _MaxBrightness,
                                  onToggle: (val) {
                                    setState(() {
                                      _MaxBrightness = val;
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
                            SizedBox(height: 5),
                            Text(
                              "Set a comfortable brightness for sleep mode.",
                              style: GoogleFonts.outfit(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w300),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 20),
                    ],
                  ),
                ),
              ),
            ],
          ),
          if (!_NightLight) ...[
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
                        "Max: 60%",
                        style: GoogleFonts.outfit(
                          fontSize: 22,
                          fontWeight: FontWeight.w400,
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
                    minimumSize: Size(138, 64),
                  ),
                ),
              ],
            ),
          ],
          SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Use as nightlight",
                  style: GoogleFonts.outfit(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.w400),
                ),
                FlutterSwitch(
                  value: _NightLight,
                  onToggle: (val) {
                    setState(() {
                      _NightLight = val;
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
          SizedBox(height: 5),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Text(
              "Device will set to an amber colour and 5% brightness when in sleep mode.",
              style: GoogleFonts.outfit(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.w300),
            ),
          ),
          SizedBox(height: 20),
          if (_NightLight) ...[
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Nightlight behaviour",
                    style: GoogleFonts.outfit(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.w400),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
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
                        "Turn On Manually",
                        style: GoogleFonts.outfit(
                          fontSize: 22,
                          fontWeight: FontWeight.w400,
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
                    minimumSize: Size(312, 80),
                  ),
                ),
                SizedBox(
                  width: 40,
                ),
                ElevatedButton(
                  onPressed: () {
                    // Add your cooling functionality here
                  },
                  child: Row(
                    children: [
                      Text(
                        "Turn On with Sleep Mode",
                        style: GoogleFonts.outfit(
                          fontSize: 22,
                          fontWeight: FontWeight.w400,
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
                    minimumSize: Size(312, 80),
                  ),
                ),
                SizedBox(
                  width: 40,
                ),
                ElevatedButton(
                  onPressed: () {
                    // Add your cooling functionality here
                  },
                  child: Row(
                    children: [
                      Text(
                        "Use Motion Sensor",
                        style: GoogleFonts.outfit(
                          fontSize: 22,
                          fontWeight: FontWeight.w400,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.white.withOpacity(0.95),
                    onPrimary: Colors.black,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(60.5),
                    ),
                    minimumSize: Size(312, 78),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  width: 22,
                ),
                Text(
                  "This device will turn on for 5 minutes when a sensor in [lounge] detects motion.",
                  style: GoogleFonts.outfit(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.w300),
                ),
              ],
            ),
          ]
        ],
      ),
    );
  }

  //////////////////////////////////////////////////////////////////////////////////
  Widget _buildAwaypMode(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                onPressed: () {
                  _navigateToScreen('SettingMain');
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
                  "Main Away Mode",
                  style: GoogleFonts.outfit(
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
                      style: GoogleFonts.outfit(
                        fontSize: 24,
                        fontWeight: FontWeight.w400,
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
          Column(
            children: [
              Column(children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Turn Off while Away",
                            style: GoogleFonts.outfit(
                                color: Colors.white,
                                fontSize: 24,
                                fontWeight: FontWeight.w400),
                          ),
                          FlutterSwitch(
                            value: _isSleepModeEnabledAway,
                            onToggle: (val) {
                              setState(() {
                                _isSleepModeEnabledAway = val;
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
                      SizedBox(height: 5),
                      Text(
                        "Light will turn off 5 minutes after Away mode is activated.",
                        style: GoogleFonts.outfit(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.w300),
                      ),
                    ],
                  ),
                ),
              ]),
            ],
          ),
        ],
      ),
    );
  }

  /////////////////////////////////////////////////////////////////////////////////////
  Widget _buildEcoMode(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              IconButton(
                onPressed: () {
                  _navigateToScreen('SettingMain');
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
                  SizedBox(height: 15),
                  Text(
                    "Downstairs Sensors",
                    style: TextStyle(
                      fontSize: 42,
                      fontWeight: FontWeight.w400,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    "Select Eco Mode settings for this Air Conditioner ",
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
              Column(crossAxisAlignment: CrossAxisAlignment.end, children: []),
              SizedBox(
                width: 383,
              ),
              ElevatedButton(
                onPressed: () {
                  // Add your export functionality here
                },
                child: Row(
                  children: [
                    Text(
                      "Save Changes",
                      style: GoogleFonts.outfit(
                        fontSize: 24,
                        fontWeight: FontWeight.w400,
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
          SizedBox(height: 50),
          Column(
            children: [
              Column(children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Max Brightness",
                            style: GoogleFonts.outfit(
                                color: Colors.white,
                                fontSize: 24,
                                fontWeight: FontWeight.w400),
                          ),
                          FlutterSwitch(
                            value: _isSleepModeEnabledAway,
                            onToggle: (val) {
                              setState(() {
                                _isSleepModeEnabledAway = val;
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
                      SizedBox(height: 5),
                      Text(
                        "Limit the brightness of your devices to avoid excess usage.",
                        style: GoogleFonts.outfit(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.w300),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
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
                            "Max: 60%",
                            style: GoogleFonts.outfit(
                              fontSize: 22,
                              fontWeight: FontWeight.w400,
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
                        minimumSize: Size(138, 64),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Eco Auto Off",
                            style: GoogleFonts.outfit(
                                color: Colors.white,
                                fontSize: 24,
                                fontWeight: FontWeight.w400),
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
                      SizedBox(height: 5),
                      Text(
                        "Auto Off after a set period of time when in eco mode.",
                        style: GoogleFonts.outfit(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.w300),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
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
                            "After 1hr, 20min",
                            style: GoogleFonts.outfit(
                              fontSize: 22,
                              fontWeight: FontWeight.w400,
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
                        minimumSize: Size(138, 64),
                      ),
                    ),
                  ],
                ),
              ]),
            ],
          ),
        ],
      ),
    );
  }
}
