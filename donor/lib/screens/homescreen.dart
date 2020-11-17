import 'package:donor/screens/homescreen/donate.dart';
import 'package:donor/screens/homescreen/home.dart';
import 'package:donor/screens/homescreen/profile.dart';
import 'package:donor/screens/homescreen/search.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String name = "";

  _getUsername() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    name = prefs.getString("username");
    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getUsername();
  }

  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            if (_currentIndex == 0) HomeTab(),
            if (_currentIndex == 1) ProfileTab(),
            if (_currentIndex == 2) DonateTab(),
            if (_currentIndex == 3) ProfileTab(),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        // backgroundColor: Colors.blue,
        currentIndex: _currentIndex,
        // type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
            backgroundColor: Colors.blue[400],
            icon: Icon(Icons.home),
            label: "Home",
          ),
          BottomNavigationBarItem(
            backgroundColor: Colors.blue[500],
            icon: Icon(Icons.search),
            label: "Search",
          ),
          BottomNavigationBarItem(
            backgroundColor: Colors.blue[600],
            icon: Icon(Icons.donut_large),
            label: "Donate",
          ),
          BottomNavigationBarItem(
            backgroundColor: Colors.blue[700],
            icon: Icon(Icons.person),
            label: "Profile",
          ),
        ],
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }
}
