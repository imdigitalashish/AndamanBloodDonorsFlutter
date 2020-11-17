import 'package:donor/screens/controller.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(
    MaterialApp(
      home: MainPort(),
    ),
  );
}

class MainPort extends StatefulWidget {
  @override
  MainPortState createState() => MainPortState();
}

class MainPortState extends State<MainPort> {
  @override
  Widget build(BuildContext context) {
    return Controller();
  }
}
