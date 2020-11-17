import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeTab extends StatefulWidget {
  @override
  _HomeTabState createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  String name = "";

  _getUsername() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    name = prefs.getString("firstname");
    setState(() {
      name = name;
    });
  }

  @override
  void initState() {
    super.initState();
    _getUsername();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          _makeHomeScreen(name),
        ],
      ),
    );
  }
}

Widget _makeHomeScreen(name) {
  return Container(
    width: double.infinity,
    height: 200,
    margin: EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      color: Colors.black,
      image: DecorationImage(
          fit: BoxFit.fill,
          image: NetworkImage(
              "https://wallpaperforu.com/wp-content/uploads/2020/07/vector-wallpaper-20071218240131.jpg")),
      borderRadius: BorderRadius.circular(20),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: EdgeInsets.only(top: 30.0, left: 20.0),
          child: Text(
            "Welcome,",
            style: TextStyle(
              fontSize: 32.0,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.only(left: 60.0),
          child: Text(
            name,
            style: TextStyle(
              fontSize: 32.0,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
      ],
    ),
  );
}
