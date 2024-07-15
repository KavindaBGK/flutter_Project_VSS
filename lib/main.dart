import 'package:flutter/material.dart';
import 'package:test1/Away_Mode.dart';
import 'package:test1/Setting_Downstairs.dart';
import 'dart:ui';

import 'Downstairs_Timer.dart';
import 'Eco_Mode.dart';
import 'Sleep_Mode.dart';
import 'Timer2.dart';
import 'Usage.dart';

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
      body: Center(
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
            ),
            SizedBox(height: 20), // Adds space between the buttons
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
            SizedBox(height: 20), // Adds space between the buttons
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
          ],
        ),
      ),
    );
  }
}
