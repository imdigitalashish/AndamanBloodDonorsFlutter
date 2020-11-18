import 'dart:convert';

import 'package:donor/models/blood_donate.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:donor/export_api_url.dart';

class GroupSearchList extends StatefulWidget {
  final String bloodGroup;

  const GroupSearchList({Key key, this.bloodGroup});

  @override
  _GroupSearchListState createState() => _GroupSearchListState();
}

class _GroupSearchListState extends State<GroupSearchList> {
  List<BloodDonation> donation = [];

  int triedtofetched = 0;

  _getData() async {
    try {
      String group = widget.bloodGroup.replaceAll("+", "%2B");
      var client = http.Client();
      var response =
          await client.get(server_url + "get_group?blood_group=$group");
      List<dynamic> responsedata = jsonDecode(response.body.toString());
      donation = responsedata.map((e) => BloodDonation.fromJson(e)).toList();
      triedtofetched = 1;
      setState(() {});
    } catch (e) {
      triedtofetched = 2;
      setState(() {});
    }
  }

  Widget _oneTile(BloodDonation bd) {
    return ExpansionTile(
      leading: Text(bd.gender),
      title: Text(bd.name),
      children: [
        Text("email: ${bd.email}"),
        Text("phone: ${bd.phone}"),
        Text("weight: ${bd.weight}"),
        Text("blood group: ${bd.bloodGroup}"),
      ],
    );
  }

  Widget getWidgets() {
    List<Widget> list = new List<Widget>();
    for (int i = 0; i < donation.length; i++) {
      list.add(_oneTile(donation[i]));
    }
    return new ListView(children: list);
  }

  @override
  void initState() {
    super.initState();
    _getData();
  }

  @override
  Widget build(BuildContext context) {
    if (donation.isEmpty) {
      if (triedtofetched == 0) {
        return Scaffold(
          body: Center(
            child: Text("Loading..."),
          ),
        );
      } else if (triedtofetched == 2) {
        return Scaffold(
          body: Center(
            child: Text("Error: Make sure you are connected to internet"),
          ),
        );
      } else {
        return Scaffold(
          body: Center(
            child: Text("No data found :("),
          ),
        );
      }
    } else {
      return Scaffold(
        body: Container(
          child: getWidgets(),
        ),
      );
    }
  }
}
