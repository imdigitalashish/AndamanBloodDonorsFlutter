import 'dart:convert';

import 'package:donor/models/blood_donate.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:donor/export_api_url.dart';
import 'package:toast/toast.dart';

class ViewDonations extends StatefulWidget {
  @override
  _ViewDonationsState createState() => _ViewDonationsState();
}

class _ViewDonationsState extends State<ViewDonations> {
  List<BloodDonation> donation = [];

  int triedtofetched = 0;

  _getData() async {
    try {
      var client = http.Client();
      var response =
          await client.get(server_url + "get_user_donated?username=dspashish");
      List<dynamic> responsedata = jsonDecode(response.body.toString());
      donation = responsedata.map((e) => BloodDonation.fromJson(e)).toList();
      triedtofetched = 1;
      setState(() {});
    } catch (e) {
      triedtofetched = 2;
      setState(() {});
    }
  }

  _deleteMyDonation(pk) async {
    var client = http.Client();
    var response = await client.get(server_url + "delete_blood_group?pk=$pk");
    Map<String, dynamic> results = jsonDecode(response.body.toString());

    Toast.show(results["result"], context,
        duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
    _getData();
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
        Container(
          margin: EdgeInsets.all(20.0),
          decoration: BoxDecoration(
            color: Colors.red,
            borderRadius: BorderRadius.circular(15.0),
          ),
          child: FlatButton(
            onPressed: () => _deleteMyDonation(bd.pk),
            child: Text("DELETE",
                style: TextStyle(
                    color: Colors.white, fontWeight: FontWeight.bold)),
          ),
        )
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
          appBar: AppBar(title: Text("Your Donations")),
          body: Center(
            child: Text("Loading..."),
          ),
        );
      } else if (triedtofetched == 2) {
        return Scaffold(
          appBar: AppBar(title: Text("Your Donations")),
          body: Center(
            child: Text("Error: Make sure you are connected to internet"),
          ),
        );
      } else {
        return Scaffold(
          appBar: AppBar(title: Text("Your Donations")),
          body: Center(
            child: Text("No haven't donated yet :("),
          ),
        );
      }
    } else {
      return Scaffold(
        appBar: AppBar(title: Text("Your Donations")),
        body: Container(
          child: getWidgets(),
        ),
      );
    }
  }
}
