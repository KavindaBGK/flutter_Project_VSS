import 'package:flutter/material.dart';
import 'package:test1/Away_Mode.dart';
import 'package:test1/Set_Point.dart';
import 'package:test1/Setting_Downstairs.dart';
import 'package:test1/Update.dart';
import 'dart:ui';

import 'Auto_off.dart';
import 'Downstairs_Timer.dart';
import 'Eco_Mode.dart';
import 'Min_setpoint.dart';
import 'Routines.dart';
import 'Select_Icon.dart';
import 'Sensors.dart';
import 'Sleep_Mode.dart';
import 'Timer2.dart';
import 'Usage.dart';
import 'Weather_Adapatation_Hot.dart';
import 'Weather_Adaptation_cool.dart';
import 'Zones.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Popup Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Popup Example'),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              ElevatedButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return const Downstairstage();
                    },
                  );
                },
                child: Text("Show TileControlPopupDialog"),
              ),
              ElevatedButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return const CustomPopupDialog();
                    },
                  );
                },
                child: Text("Timer2"),
              ),
              ElevatedButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return const TileControlPopupDialog();
                    },
                  );
                },
                child: Text("Timer1"),
              ), // Adds space between the buttons
              ElevatedButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return const SettingsDownstairs();
                    },
                  );
                },
                child: Text("Show SettingsDownstairs"),
              ),
              // Adds space between the buttons
              ElevatedButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return const SleepModeControl();
                    },
                  );
                },
                child: Text("Sleep Mode"),
              ),
              ElevatedButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return const AwayModeControl();
                    },
                  );
                },
                child: Text("Away Mode"),
              ),
              ElevatedButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return const EcoModeControl();
                    },
                  );
                },
                child: Text("Eco Mode"),
              ),
              ElevatedButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return const Routines();
                    },
                  );
                },
                child: Text("Routines"),
              ),
              ElevatedButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return const AutoOffControl();
                    },
                  );
                },
                child: Text("Auto Off"),
              ),
              ElevatedButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return SetPointRControl();
                    },
                  );
                },
                child: Text("Set point"),
              ),
              ElevatedButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return DownstairsZones();
                    },
                  );
                },
                child: Text("Downstairs Zones"),
              ),
              ElevatedButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return SensorDialog();
                    },
                  );
                },
                child: Text("Sensors"),
              ),
              ElevatedButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return MinSetPointRControl();
                    },
                  );
                },
                child: Text("Min set"),
              ),
              ElevatedButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return WeatherAdaptationControl();
                    },
                  );
                },
                child: Text("Weather Adaptation cool"),
              ),
              ElevatedButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return WeatherAdaptationHotControl();
                    },
                  );
                },
                child: Text("Weather Adaptation Hot"),
              ),
              ElevatedButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return SelectDeviceControl();
                    },
                  );
                },
                child: Text("Select device"),
              ),
              ElevatedButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return UpdateControle();
                    },
                  );
                },
                child: Text("Update"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
