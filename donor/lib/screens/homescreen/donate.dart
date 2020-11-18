import 'package:donor/screens/homescreen/donate_blood/form.dart';
import 'package:donor/screens/homescreen/donate_blood/view_donations.dart';
import 'package:flutter/material.dart';

class DonateTab extends StatefulWidget {
  @override
  _DonateTabState createState() => _DonateTabState();
}

class _DonateTabState extends State<DonateTab> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.all(16.0),
            child: Text(
              "Select one from below",
              style: TextStyle(fontSize: 32),
            ),
          ),
          Container(
            margin: EdgeInsets.all(16.0),
            padding: EdgeInsets.all(16.0),
            height: 60.0,
            width: double.infinity,
            decoration: BoxDecoration(
              gradient: new LinearGradient(
                colors: [
                  Colors.red[300],
                  Colors.red[500],
                ],
              ),
              borderRadius: BorderRadius.circular(30.0),
            ),
            child: FlatButton(
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => FormPage(),
                ),
              ),
              child: Text(
                "Donate",
                style: TextStyle(color: Colors.white, fontSize: 20.0),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.all(16.0),
            padding: EdgeInsets.all(16.0),
            height: 60.0,
            width: double.infinity,
            decoration: BoxDecoration(
              gradient: new LinearGradient(
                colors: [
                  Colors.blue[500],
                  Colors.blue[700],
                ],
              ),
              borderRadius: BorderRadius.circular(30.0),
            ),
            child: FlatButton(
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => ViewDonations(),
                ),
              ),
              child: Text(
                "View Your Donation",
                style: TextStyle(color: Colors.white, fontSize: 20.0),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
