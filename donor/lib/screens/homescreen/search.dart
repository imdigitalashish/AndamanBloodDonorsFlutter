import 'package:donor/screens/homescreen/groups_list.dart';
import 'package:flutter/material.dart';

class SearchTab extends StatefulWidget {
  @override
  _SearchTabState createState() => _SearchTabState();
}

class _SearchTabState extends State<SearchTab> {
  @override
  Widget build(BuildContext context) {
    double widthOfScreen = MediaQuery.of(context).size.width;

    return Container(
      child: ListView(
        children: [
          _row1(context),
          _row2(context),
          _row3(context),
          _row4(context),
        ],
      ),
    );
  }
}

Widget _row1(BuildContext context) {
  return Row(
    children: [
      Expanded(
        child: FlatButton(
          onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (_) => GroupSearchList(bloodGroup: "A+"))),
          child: Container(
            // padding: EdgeInsets.all(20),
            // margin: EdgeInsets.all(20),
            margin: EdgeInsets.only(bottom: 20, top: 20),
            height: 200,
            decoration: new BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              gradient: new LinearGradient(
                colors: [
                  Colors.orange[400],
                  Colors.orange[600],
                ],
              ),
            ),
            child: Center(
              child: Text(
                "A+",
                style: TextStyle(
                    fontSize: 32.0,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ),
      ),
      Expanded(
        child: FlatButton(
          onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (_) => GroupSearchList(bloodGroup: "O+"))),
          child: Container(
            // padding: EdgeInsets.all(20),
            // margin: EdgeInsets.all(20),
            height: 200,
            decoration: new BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              gradient: new LinearGradient(
                colors: [
                  Colors.orange[700],
                  Colors.orange[800],
                ],
              ),
            ),
            child: Center(
              child: Text(
                "O+",
                style: TextStyle(
                    fontSize: 32.0,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ),
      ),
    ],
  );
}

Widget _row2(BuildContext context) {
  return Row(
    children: [
      Expanded(
        child: FlatButton(
          onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (_) => GroupSearchList(bloodGroup: "B+"))),
          child: Container(
            // padding: EdgeInsets.all(20),
            // margin: EdgeInsets.all(20),
            height: 200,
            decoration: new BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              gradient: new LinearGradient(
                colors: [
                  Colors.blue[400],
                  Colors.blue[600],
                ],
              ),
            ),
            child: Center(
              child: Text(
                "B+",
                style: TextStyle(
                    fontSize: 32.0,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ),
      ),
      Expanded(
        child: FlatButton(
          onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (_) => GroupSearchList(bloodGroup: "AB+"))),
          child: Container(
            // margin: EdgeInsets.all(20),
            height: 200,
            decoration: new BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              gradient: new LinearGradient(
                colors: [
                  Colors.green[400],
                  Colors.green[600],
                ],
              ),
            ),
            child: Center(
              child: Text(
                "AB+",
                style: TextStyle(
                    fontSize: 32.0,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ),
      ),
    ],
  );
}

Widget _row3(BuildContext context) {
  return Row(
    children: [
      Expanded(
        child: FlatButton(
          onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (_) => GroupSearchList(bloodGroup: "O-"))),
          child: Container(
            // padding: EdgeInsets.all(20),
            // margin: EdgeInsets.all(20),
            margin: EdgeInsets.only(top: 20),

            height: 200,
            decoration: new BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              gradient: new LinearGradient(
                colors: [
                  Colors.red[200],
                  Colors.red[400],
                ],
              ),
            ),
            child: Center(
              child: Text(
                "O-",
                style: TextStyle(
                    fontSize: 32.0,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ),
      ),
      Expanded(
        child: FlatButton(
          onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (_) => GroupSearchList(bloodGroup: "B-"))),
          child: Container(
            // padding: EdgeInsets.all(20),
            margin: EdgeInsets.only(top: 20),
            height: 200,
            decoration: new BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              gradient: new LinearGradient(
                colors: [
                  Colors.purple[200],
                  Colors.purple[400],
                ],
              ),
            ),
            child: Center(
              child: Text(
                "B-",
                style: TextStyle(
                    fontSize: 32.0,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ),
      ),
    ],
  );
}

Widget _row4(BuildContext context) {
  return Row(
    children: [
      Expanded(
        child: FlatButton(
          onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (_) => GroupSearchList(bloodGroup: "A-"))),
          child: Container(
            // padding: EdgeInsets.all(20),
            // margin: EdgeInsets.all(20),
            margin: EdgeInsets.only(top: 20),

            height: 200,
            decoration: new BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              gradient: new LinearGradient(
                colors: [
                  Colors.blueAccent[200],
                  Colors.blueAccent[400],
                ],
              ),
            ),
            child: Center(
              child: Text(
                "A-",
                style: TextStyle(
                    fontSize: 32.0,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ),
      ),
      Expanded(
        child: FlatButton(
          onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (_) => GroupSearchList(bloodGroup: "AB-"))),
          child: Container(
            // padding: EdgeInsets.all(20),
            margin: EdgeInsets.only(top: 20),
            height: 200,
            decoration: new BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              gradient: new LinearGradient(
                colors: [
                  Colors.orange[500],
                  Colors.orange[700],
                ],
              ),
            ),
            child: Center(
              child: Text(
                "AB-",
                style: TextStyle(
                    fontSize: 32.0,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ),
      ),
    ],
  );
}
