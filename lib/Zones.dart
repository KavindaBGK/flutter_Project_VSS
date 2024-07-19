import 'dart:ui';
import 'package:flutter/material.dart';

class DownstairsZones extends StatefulWidget {
  const DownstairsZones({Key? key}) : super(key: key);

  @override
  _DownstairsZonesState createState() => _DownstairsZonesState();
}

class _DownstairsZonesState extends State<DownstairsZones> {
  final List<Zone> _zones = [
    Zone(
      imagePath: 'assets/device_Onboard/Vector1.png',
      name: "Lounge",
      status: "On, 75%",
      temperature: "",
      damper: "Damper 1",
    ),
    Zone(
      imagePath: 'assets/device_Onboard/Vector1.png',
      name: "Dining",
      status: "On",
      temperature: "24.5°",
      damper: "Damper 2,3",
    ),
    Zone(
      imagePath: 'assets/device_Onboard/Vector1.png',
      name: "Kitchen",
      status: "Off",
      temperature: "",
      damper: "Damper 4",
    ),
    Zone(
      imagePath: 'assets/device_Onboard/Vector1.png',
      name: "Master",
      status: "Off",
      temperature: "22.1°",
      damper: "Damper 5",
    ),
    Zone(
      imagePath: 'assets/device_Onboard/Vector1.png',
      name: "Josh",
      status: "On, 25%",
      temperature: "",
      damper: "Damper 6",
    ),
  ];

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
                                "Downstairs Zones",
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
                                  Image.asset(
                                    'assets/device_Onboard/setting.png',
                                    width: 32,
                                    height: 32,
                                  ),
                                  SizedBox(width: 15),
                                  Text(
                                    "Save Changes",
                                    style: TextStyle(
                                      fontSize: 23,
                                      fontFamily: 'Outfit',
                                      fontWeight: FontWeight.w900,
                                      color: Colors.black,
                                    ),
                                  ),
                                ],
                              ),
                              style: ElevatedButton.styleFrom(
                                primary: Colors.white,
                                onPrimary: Colors.black,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(60.5),
                                ),
                                minimumSize: Size(200, 60),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 35),
                        Expanded(
                          child: ListView.builder(
                            itemCount: _zones.length,
                            itemBuilder: (context, index) {
                              Zone zone = _zones[index];
                              return ZoneContainer(zone: zone);
                            },
                          ),
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

class Zone {
  final String imagePath;
  final String name;
  final String status;
  final String temperature;
  final String damper;

  Zone({
    required this.imagePath,
    required this.name,
    required this.status,
    required this.temperature,
    required this.damper,
  });
}

class ZoneContainer extends StatelessWidget {
  final Zone zone;

  const ZoneContainer({Key? key, required this.zone}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 15),
      padding: const EdgeInsets.all(15),
      height: MediaQuery.of(context).size.height * 0.11,
      decoration: BoxDecoration(
        color: const Color(0xFF1E1E1E),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          Image.asset(zone.imagePath, width: 50, height: 50),
          const SizedBox(width: 40),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  zone.name,
                  style: const TextStyle(color: Colors.white, fontSize: 20),
                ),
                SizedBox(
                  height: 8,
                ),
                Text(
                  "${zone.status} ${zone.temperature}",
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w300),
                ),
              ],
            ),
          ),
          Text(
            zone.damper,
            style: const TextStyle(
                color: Colors.white, fontSize: 16, fontWeight: FontWeight.w300),
          ),
          const SizedBox(width: 20),
          IconButton(
            onPressed: () {
              // Add your functionality here
            },
            icon: Image.asset(
              'assets/device_Onboard/rightarrow.png',
              width: 25,
              height: 25,
            ),
            iconSize: 25,
          ),
        ],
      ),
    );
  }
}
