import 'dart:ui';
import 'package:flutter/material.dart';

class Routines extends StatefulWidget {
  const Routines({Key? key}) : super(key: key);

  @override
  _RoutinesState createState() => _RoutinesState();
}

class _RoutinesState extends State<Routines> {
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

  @override
  Widget build(BuildContext context) {
    List<String> days = ['All', 'Mo', 'Tu', 'We', 'Th', 'Fr', 'Sa', 'Su'];

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
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10.0),
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
