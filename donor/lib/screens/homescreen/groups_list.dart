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
  _getData() async {
    var client = http.Client();
    var response = await client.get(server_url + "get_group?blood_group=AB%2B");
    List<dynamic> responsedata = jsonDecode(response.body.toString());
    List<BloodDonation> donation =
        responsedata.map((e) => BloodDonation.fromJson(e)).toList();
    print(donation[0].bloodGroup);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Container(child: Text(widget.bloodGroup)));
  }
}
