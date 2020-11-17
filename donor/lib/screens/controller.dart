import 'package:donor/screens/authentication/register.dart';
import 'package:donor/screens/homescreen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Controller extends StatefulWidget {
  @override
  _ControllerState createState() => _ControllerState();
}

class _ControllerState extends State<Controller> {
  int count = 2;

  _getPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    count = (prefs.getInt("counter"));
    print(count);
    if (count == null) {
      count = 2;
    }
    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getPreferences();
  }

  @override
  Widget build(BuildContext context) {
    if (count == 1) {
      return HomeScreen();
    } else if (count == 2) {
      return Register();
    } else {
      return Scaffold();
    }
  }
}
