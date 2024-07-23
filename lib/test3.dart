import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_switch/flutter_switch.dart';

class SettingsDownstairs1 extends StatefulWidget {
  final String initialScreenName;
  const SettingsDownstairs1({Key? key, required this.initialScreenName})
      : super(key: key);

  @override
  _SettingsDownstairsState createState() => _SettingsDownstairsState();
}

class _SettingsDownstairsState extends State<SettingsDownstairs1> {
  late String currentScreen;
  late PageController _pageController;
  late String currentConnectingDeviceName = "";
  bool _isDelayedNavigationTriggered = false;
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
      case 'AcControl':
        return 0;
      default:
        return 0;
    }
  }

  void _navigateToScreen(String screenName) {
    int pageIndex = 0;
    switch (screenName) {
      case 'AC':
        pageIndex = 0;
        break;
      case 'DownstairTimer':
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

  bool _isSleepModeEnabled = false;
  bool _isSleepModeEnabledAway = false;
  bool turnOnWhenZoneTurnedOn1 = true;
  bool turnOnWhenZoneTurnedOn2 = true;
  bool turnOnWhenZoneTurnedOn3 = true;
  bool useIntelligentAuto = false;
  bool _isSetPointLimitEnabledEco = false;
  bool _isWeatherAdaptionEnabledEco = true;
  bool _isAdvancedWeatherAdaptionEnabledEco = false;

  int selectedHour = 1;
  int selectedMinute = 00;
  bool isPm = false;

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
        style: GoogleFonts.outfit(color: Colors.white),
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
        style: GoogleFonts.outfit(
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
                      child: PageView(
                        controller: _pageController,
                        physics: NeverScrollableScrollPhysics(),
                        children: [
                          _buildAC(context),
                          _buildDownstairTimer(context),
                          _buildSleepMode(context),
                          _buildAwayMode(context),
                          _buildEcoMode(context),
                          _buildSetTimer(context),
                          _buildUsage(context),
                          _buildRoute(context),
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
  Widget _buildAC(BuildContext context) {
    return SingleChildScrollView(
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
                "Settings Downstairs",
                style: GoogleFonts.outfit(
                  fontSize: 42,
                  // fontFamily: 'Outfit',
                  fontWeight: FontWeight.w400,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          SizedBox(height: 20),
          _buildServiceInfo(),
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

  Widget _buildServiceInfo() {
    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              SizedBox(width: 20),
              Image.asset(
                'assets/device_Onboard/Layer_1.png',
                width: 120,
                height: 120,
              ),
              SizedBox(width: 20),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Upcoming Service Due - 11/10/24",
                    style: GoogleFonts.outfit(
                      color: Colors.white,
                      fontSize: 23,
                      fontWeight: FontWeight.w200,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    "Bob's AirCon Services - 0118 999 881",
                    style: GoogleFonts.outfit(
                      color: Colors.white,
                      fontWeight: FontWeight.w400,
                      fontSize: 24,
                    ),
                  ),
                ],
              ),
            ],
          ),
          Row(
            children: [
              ElevatedButton(
                onPressed: () {
                  // Add your reminder functionality here
                },
                child: Text(
                  "Remind me later",
                  style: GoogleFonts.outfit(
                      fontSize: 20,
                      fontWeight: FontWeight.w400,
                      color: Colors.white // Adjust the font size here
                      ),
                ),
                style: ElevatedButton.styleFrom(
                  primary: Color.fromARGB(255, 0, 0, 0).withOpacity(0.25),
                  onPrimary: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(60.5),
                  ),
                  minimumSize: Size(190, 65),
                ),
              ),
              SizedBox(width: 25), // Adjust the width as needed
            ],
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
        if (text.toLowerCase().contains('off')) {
          _navigateToScreen('SetTimer');
        }
        if (text == 'Usage Stats') {
          _navigateToScreen('Usage');
        }
        if (text == 'In 6 Routines') {
          _navigateToScreen('Route');
        }
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
                color: Colors.white, fontSize: 23, fontWeight: FontWeight.w400),
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
                color: Colors.white, fontWeight: FontWeight.w200, fontSize: 24),
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
        if (text == 'Sleep Mode') _navigateToScreen('SleepMode');
        if (text == 'Away Mode') _navigateToScreen('AwayMode');
        if (text == 'Eco Mode') _navigateToScreen('EcoMode');
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
                color: Colors.white, fontWeight: FontWeight.w200, fontSize: 24),
          ),
          SizedBox(height: 20),
          _buildFeatureToggle("Auto Off", "Not set",
              'assets/device_Onboard/Forward Large Icon.png'),
          SizedBox(height: 20),
          _buildFeatureToggle(
              "Set Point Range",
              "Cooling 19-28°, Heating 16-28°",
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
                    fontSize: 23,
                    fontWeight: FontWeight.w400),
              ),
              SizedBox(height: 5), // Adjust this value as needed
              Text(
                text2,
                style: GoogleFonts.outfit(
                    color: Colors.white,
                    fontSize: 18,
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
                color: Colors.white, fontWeight: FontWeight.w200, fontSize: 24),
          ),
          SizedBox(height: 20),
          _buildButton(" Downstairs"),
          SizedBox(height: 20),
          _buildDropdownRowRoom("  Room", "6 Rooms", 6),
          SizedBox(height: 20),
          _buildDropdownRowIcon("  Icon", "", Icons.power_settings_new),
          SizedBox(height: 20),
          _buildToggle("Turn On Air Conditioner when a Zone is Turned On",
              turnOnWhenZoneTurnedOn1, (value1) {
            setState(() {
              turnOnWhenZoneTurnedOn1 = value1;
            });
          }),
          _buildToggle(
              "Turn Off Air Conditioner when the last Zone is Turned Off",
              turnOnWhenZoneTurnedOn2, (value2) {
            setState(() {
              turnOnWhenZoneTurnedOn2 = value2;
            });
          }),
          _buildToggle("Use Intelligent Auto", turnOnWhenZoneTurnedOn3,
              (value3) {
            setState(() {
              turnOnWhenZoneTurnedOn3 = value3;
            });
          }),
          SizedBox(height: 20),
          _buildFeatureToggle("Zones", "6 Zones assigned",
              "assets/device_Onboard/Forward Large Icon.png"),
          SizedBox(
            height: 20,
          ),
          _buildFeatureToggle("Sensors", "1 set, 3 available",
              "assets/device_Onboard/Forward Large Icon.png"),
          SizedBox(
            height: 20,
          ),
          _buildConsoleVersionRow("Console Version 1.1.5",
              "Main Module Version 2.0.0.2", "Check for Update"),
          SizedBox(
            height: 5,
          ),
          _buildDeviceSettingRow("Manufacturer: AirTouch", "ID:00112233 "),
          SizedBox(
            height: 20,
          ),
          _buildFeatureToggle("Installer Setting", "",
              "assets/device_Onboard/Forward Large Icon.png"),
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
          ElevatedButton(
            onPressed: () {
              _navigateToScreen('DownstairTimer');
            },
            style: ElevatedButton.styleFrom(
              primary: Colors.red,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(60.5),
              ),
              minimumSize: Size(200, 50),
            ),
            child: Text(
              "Navigate",
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'outfit',
                  fontSize: 22),
            ),
          ),
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
        minimumSize: Size(464, 72),
        alignment: Alignment.centerLeft, // Align content to the left
        padding:
            EdgeInsets.symmetric(horizontal: 15), // Add padding to the left
      ),
      child: Text(
        text,
        style: GoogleFonts.outfit(
            color: Colors.white, fontSize: 24, fontWeight: FontWeight.w400),
      ),
    );
  }

  Widget _buildDropdownRowRoom(String title, String value, int numberOfRooms) {
    String selectedValue = "1  Rooms";
    List<String> roomList =
        List.generate(numberOfRooms, (index) => "${index + 1}  Rooms");

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 10),
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
                    style: GoogleFonts.outfit(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                SizedBox(
                    height: 5), // Add some space between title and subtitle
                Container(
                  padding: const EdgeInsets.only(
                      left: 11.0), // Add left padding for indentation
                  child: Text(
                    "Rooms assignment set via zones",
                    style: GoogleFonts.outfit(
                        color: Colors.white.withOpacity(0.8),
                        fontSize: 20,
                        fontWeight: FontWeight.w300),
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
      padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 10),
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

  Widget _buildToggle(String text, bool value, ValueChanged<bool> onChanged) {
    bool isIntelligentAuto = text == "Use Intelligent Auto";
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 6),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(
                      left: 11.0), // Adjust the left padding as needed
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        text,
                        style: GoogleFonts.outfit(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      SizedBox(height: 5),
                      if (isIntelligentAuto) // Condition to display the additional text
                        Text(
                          "Auto fan speed will be calculated based on the size of your ducting or room size.",
                          style: TextStyle(
                            color: Colors.white.withOpacity(0.7),
                            fontSize: 16,
                          ),
                        ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    right: 16.0), // Adjust the right padding as needed
                child: Container(
                  width: 96,
                  height: 70, // Adjust to your desired size
                  child: FlutterSwitch(
                    width: 92,
                    height: 38,
                    value: value,
                    onToggle: onChanged,
                    activeColor: Colors.white,
                    toggleColor: Colors.black,
                    borderRadius: 60.5,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDeviceSettingRow(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 2),
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
                    fontSize: 24,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                Text(
                  value,
                  style: GoogleFonts.outfit(
                    color: Colors.white.withOpacity(0.7),
                    fontSize: 18,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildConsoleVersionRow(
      String consoleVersion, String mainModuleVersion, String buttonText) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 2),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(
                  left: 11.0), // Added padding inside the Expanded widget
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 7),
                  Text(
                    consoleVersion,
                    style: GoogleFonts.outfit(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  Text(
                    mainModuleVersion,
                    style: GoogleFonts.outfit(
                      color: Colors.white.withOpacity(0.7),
                      fontSize: 18,
                    ),
                  ),
                ],
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              // Add your update check functionality here
            },
            style: ElevatedButton.styleFrom(
              primary: Color.fromARGB(255, 0, 0, 0).withOpacity(0.25),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(60.5),
              ),
              minimumSize: Size(300, 70),
              alignment: Alignment.center, // Align content to the left
              padding: EdgeInsets.symmetric(
                  horizontal: 20), // Add padding to the left
            ),
            child: Text(
              buttonText,
              style: GoogleFonts.outfit(
                color: Colors.white,
                fontSize: 22,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
        ],
      ),
    );
  }

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
  @override
  Widget _buildDownstairTimer(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
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
              Text(
                "Downstairs Timer",
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
                        fontWeight: FontWeight.w400, // Reduced font weight
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
                          (i) => "${i.toString().padLeft(2, '0')}",
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
              primary: Color.fromARGB(255, 0, 0, 0).withOpacity(0.25),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(60.5),
                side: BorderSide(
                    color: Color.fromARGB(255, 228, 38, 25), width: 3.5),
              ),
              minimumSize: Size(500, 80),
              padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
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
    );
  }

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
  @override
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
                  "Downstairs Sleep Mode",
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
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Include AC in Sleep Mode",
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
          ),
          SizedBox(height: 30),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Text(
              "Sleep Comfort Temperature",
              style: GoogleFonts.outfit(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.w400),
            ),
          ),
          SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Text(
              "Auto adjustments of sleep mode will not exceed the following comfort temperatures.",
              style: GoogleFonts.outfit(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.w300),
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
                  minimumSize: Size(225, 64),
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
                  minimumSize: Size(225, 64),
                ),
              ),
            ],
          ),
          SizedBox(height: 25),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Text(
              "Sleep Mode will increase the set point by 1 degree every hour for 3 hours or until it reaches the comfort temperature. The displayed temperature will remain at your chosen temperature. After 3 hours, the AC will remain at the adjusted set point until Sleep Mode is cancelled. Adjusting device settings will cancel applied sleep settings.",
              style: GoogleFonts.outfit(
                color: Colors.white,
                fontSize: 20,

                fontWeight: FontWeight.w300,
                height: 1.5, // Increase line spacing
              ),
              textAlign: TextAlign.justify, // Justify text
            ),
          ),
        ],
      ),
    );
  }

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
  Widget _buildAwayMode(BuildContext context) {
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
                  "Downstairs Away Mode",
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
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Include AC in Away Mode",
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
          ),
          SizedBox(height: 5),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Text(
              "Set a range you would like your house to stay within while away.",
              style: GoogleFonts.outfit(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.w300),
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
                      "Minimum: 15º",
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
                  minimumSize: Size(172, 64),
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
                      "Maximum: 27º",
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
                  minimumSize: Size(172, 64),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
  Widget _buildEcoMode(BuildContext context) {
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
                  "Downstairs Eco Mode",
                  style: GoogleFonts.outfit(
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
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Set Point Limit",
                  style: GoogleFonts.outfit(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.w400),
                ),
                FlutterSwitch(
                  value: _isSetPointLimitEnabledEco,
                  onToggle: (val) {
                    setState(() {
                      _isSetPointLimitEnabledEco = val;
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
              "Eco set point can be set independently of the master set point limit.",
              style: GoogleFonts.outfit(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.w300),
            ),
          ),
          SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 0.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
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
                            "Cooling (min): 19º",
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
                        minimumSize: Size(214, 64),
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
                            "Heating (max): 24º",
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
                        minimumSize: Size(230, 64),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
          SizedBox(height: 30),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Weather Adaption",
                  style: GoogleFonts.outfit(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.w400),
                ),
                FlutterSwitch(
                  value: _isWeatherAdaptionEnabledEco,
                  onToggle: (val) {
                    setState(() {
                      _isWeatherAdaptionEnabledEco = val;
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
              "AirTouch will automatically turn off your air conditioner when the weather is mild.",
              style: GoogleFonts.outfit(
                  color: Colors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.w300),
            ),
          ),
          SizedBox(height: 30),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Advanced Weather Adaption",
                  style: GoogleFonts.outfit(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.w400),
                ),
                FlutterSwitch(
                  value: _isAdvancedWeatherAdaptionEnabledEco,
                  onToggle: (val) {
                    setState(() {
                      _isAdvancedWeatherAdaptionEnabledEco = val;
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
              "AirTouch will adjust your set point based on the weather to help reduce energy usage.",
              style: GoogleFonts.outfit(
                  color: Colors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.w300),
            ),
          ),
          SizedBox(height: 30),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 0.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
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
                            "Cooling: Differential: 3º, Comfort: 25º",
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
                        minimumSize: Size(418, 64),
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
                            "Heating: Differential: 3º, Comfort: 18º",
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
                        minimumSize: Size(417, 64),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

  Widget _buildSetTimer(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
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
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Settings Downstairs",
                    style: GoogleFonts.outfit(
                      fontSize: 42,
                      fontWeight: FontWeight.w400,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    "Quick Tip: Hold the power button of any device to access the timer.",
                    textAlign: TextAlign.left,
                    style: GoogleFonts.outfit(
                      fontSize: 20,
                      fontWeight: FontWeight.w300,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: 40),
          Container(
            width: MediaQuery.of(context).size.width * 0.4,
            height: MediaQuery.of(context).size.height * 0.5,
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.55),
              borderRadius: BorderRadius.circular(30),
            ),
            child: Column(
              children: [
                SizedBox(height: 30),
                Text(
                  "Set timer to turn device Off at:",
                  style: GoogleFonts.outfit(
                    color: Colors.white,
                    fontSize: 28,
                    fontWeight: FontWeight.w400,
                  ),
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
                        return Center(
                          child: Text(
                            "$hour",
                            style: GoogleFonts.outfit(
                              color: Colors.white,
                              fontSize: 26, // Increased text size
                              fontWeight:
                                  FontWeight.w400, // Reduced font weight
                            ),
                          ),
                        );
                      },
                      looping: true, // Looping for hours
                    ),
                    SizedBox(width: 20), // Added spacing
                    Text(
                      ":",
                      style: GoogleFonts.outfit(
                        color: Colors.white,
                        fontSize: 32, // Increased text size
                        fontWeight: FontWeight.w400, // Reduced font weight
                      ),
                    ),
                    SizedBox(width: 25), // Added spacing
                    _buildTimeSelector(
                      itemCount: 60,
                      itemExtent: 55, // Increased itemExtent
                      onSelectedItemChanged: _onMinuteChanged,
                      itemBuilder: (context, index) {
                        int minute = index % 60;
                        return Center(
                          child: Text(
                            "${minute.toString().padLeft(2, '0')}",
                            style: GoogleFonts.outfit(
                              color: Colors.white,
                              fontSize: 26, // Increased text size
                              fontWeight:
                                  FontWeight.w400, // Reduced font weight
                            ),
                          ),
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
                        return Center(
                          child: Text(
                            amPm,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 26, // Increased text size
                              fontWeight:
                                  FontWeight.w400, // Reduced font weight
                            ),
                          ),
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
              primary: Color.fromARGB(255, 14, 106, 255),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(60.5),
              ),
              minimumSize: Size(500, 80),
              padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
            ),
            child: Text(
              "Set Timer",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'outfit'),
            ),
          ),
        ],
      ),
    );
  }
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

  Widget _buildUsage(BuildContext context) {
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
                  "Downstairs Usage",
                  style: GoogleFonts.outfit(
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
                  minimumSize: Size(250, 72),
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
                  style: GoogleFonts.outfit(
                      color: Colors.white,
                      fontSize: 28,
                      fontWeight: FontWeight.w400),
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
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                  height: MediaQuery.of(context).size.height * 0.48,
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
                        "Smart Usage",
                        style: GoogleFonts.outfit(
                            color: Colors.white,
                            fontSize: 28,
                            fontWeight: FontWeight.w400),
                      ),
                      SizedBox(height: 5),
                      Text(
                        "Last 7 days",
                        style: GoogleFonts.outfit(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.w400),
                      ),
                      Expanded(
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Column(
                                children: [
                                  Text(
                                    "17",
                                    style: GoogleFonts.outfit(
                                        color: Colors.white,
                                        fontSize: 60,
                                        fontWeight: FontWeight.w400),
                                  ),
                                  Text(
                                    "Routine Actions",
                                    style: GoogleFonts.outfit(
                                        color: Colors.white,
                                        fontSize: 20,
                                        fontWeight: FontWeight.w300),
                                  ),
                                ],
                              ),
                              SizedBox(height: 30),
                              Column(
                                children: [
                                  Text(
                                    "32",
                                    style: GoogleFonts.outfit(
                                        color: Colors.white,
                                        fontSize: 60,
                                        fontWeight: FontWeight.w400),
                                  ),
                                  Text(
                                    "Scene Activations",
                                    style: GoogleFonts.outfit(
                                        color: Colors.white,
                                        fontSize: 20,
                                        fontWeight: FontWeight.w300),
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
                  height: MediaQuery.of(context).size.height * 0.48,
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
                        "Control Log",
                        style: GoogleFonts.outfit(
                            color: Colors.white,
                            fontSize: 28,
                            fontWeight: FontWeight.w400),
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
    );
  }

  ///////////////////////////////////////////////////////////////////////////
  int _selectedDayIndex = DateTime.now().weekday % 7;
  // Current day index

  final List<Routine> _routines = [
    Routine(
      timeOrImage: "8:45am",
      title: "Leave Home",
      icons: [
        'assets/device_Onboard/Vector.png',
        'assets/device_Onboard/Light_Icon.png',
        'assets/device_Onboard/Speaker_Icon.png'
      ],
      days: [0, 1, 2, 3, 4, 5, 6], // All days
    ),
    Routine(
      timeOrImage: "5:15pm",
      title: "Home from Work",
      icons: [
        'assets/device_Onboard/Vector.png',
        'assets/device_Onboard/Light_Icon.png',
        'assets/device_Onboard/Speaker_Icon.png'
      ],
      days: [1, 2, 3, 4, 5, 0], // Weekdays
    ),
    Routine(
      timeOrImage: "assets/device_Onboard/Behaviour_Sense_Icon.png",
      title: "Sunset",
      icons: [
        'assets/device_Onboard/Vector.png',
        'assets/device_Onboard/Light_Icon.png',
        'assets/device_Onboard/Speaker_Icon.png'
      ],
      days: [6, 0], // Weekend and All
    ),
    Routine(
      timeOrImage: "assets/device_Onboard/Away_Icon.png",
      title: "When Someone is Detected",
      icons: [
        'assets/device_Onboard/Vector.png',
        'assets/device_Onboard/Light_Icon.png',
        'assets/device_Onboard/Speaker_Icon.png'
      ],
      days: [0, 3, 5], // All, Wednesday, Friday
    ),
  ];

  Widget _buildRoute(BuildContext context) {
    List<String> days = ['All', 'Mo', 'Tu', 'We', 'Th', 'Fr', 'Sa', 'Su'];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
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
            Text(
              "Downstairs Routines",
              style: TextStyle(
                fontSize: 42,
                fontWeight: FontWeight.w400,
                color: Colors.white,
              ),
            ),
          ],
        ),
        const SizedBox(height: 35),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: List.generate(days.length, (index) {
            return GestureDetector(
              onTap: () {
                setState(() {
                  _selectedDayIndex = index;
                });
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: _selectedDayIndex == index
                        ? Colors.white
                        : Colors.transparent,
                    shape: BoxShape.circle,
                  ),
                  padding: const EdgeInsets.all(10),
                  child: Text(
                    days[index],
                    style: TextStyle(
                      color: _selectedDayIndex == index
                          ? Colors.black
                          : Colors.white,
                      fontSize: 20,
                    ),
                  ),
                ),
              ),
            );
          }),
        ),
        const SizedBox(height: 40),
        Expanded(
          child: ListView.builder(
            itemCount: _routines.length,
            itemBuilder: (context, index) {
              Routine routine = _routines[index];
              // Show routine only if it matches the selected day or if the selected day is "All"
              if (routine.days.contains(_selectedDayIndex)) {
                return RoutineContainer(routine: routine);
              } else {
                return SizedBox.shrink();
              }
            },
          ),
        ),
      ],
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
                    style: GoogleFonts.outfit(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.w300),
                  ),
                  SizedBox(width: 30),
                  SizedBox(height: 30),
                  Text(
                    user,
                    style: GoogleFonts.outfit(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.w300),
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

class Routine {
  final String timeOrImage;
  final String title;
  final List<String> icons;
  final List<int> days;

  Routine({
    required this.timeOrImage,
    required this.title,
    required this.icons,
    required this.days,
  });
}

class RoutineContainer extends StatelessWidget {
  final Routine routine;

  const RoutineContainer({Key? key, required this.routine}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 15),
      padding: const EdgeInsets.all(15),
      height: MediaQuery.of(context).size.height * 0.12,
      decoration: BoxDecoration(
        color: const Color(0xFF1E1E1E),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              // First column
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8, vertical: 20),
                child: routine.timeOrImage.endsWith('.png')
                    ? Image.asset(routine.timeOrImage, width: 70, height: 30)
                    : Text(
                        routine.timeOrImage,
                        style:
                            const TextStyle(color: Colors.white, fontSize: 20),
                      ),
              ),
              const SizedBox(width: 40),
              // Second column
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(vertical: 2),
                      child: Text(
                        routine.title,
                        style:
                            const TextStyle(color: Colors.white, fontSize: 23),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: routine.icons.map((icon) {
                        return Padding(
                          padding: const EdgeInsets.only(right: 5),
                          child: Image.asset(icon, width: 20, height: 20),
                        );
                      }).toList(),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
