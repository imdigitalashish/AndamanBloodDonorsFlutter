import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:donor/export_api_url.dart';
import 'package:toast/toast.dart';

class FormPage extends StatefulWidget {
  @override
  _FormPageState createState() => _FormPageState();
}

class _FormPageState extends State<FormPage> {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final weightController = TextEditingController();
  String blood_group;
  String username;
  final List<String> _blood_group_list = [
    "A+",
    "O+",
    "B+",
    "AB+",
    "O-",
    "B-",
    "A-",
    "AB-"
  ];
  String gender;
  final List<String> _gender_list = [
    "male",
    "female",
    "rather not to say",
  ];

  _autofill() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    nameController.text = prefs.getString("firstname");
    emailController.text = prefs.getString("email");
    username = prefs.getString("username");
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _autofill();
  }

  _donateBlood() async {
    FocusScope.of(context).requestFocus(new FocusNode());

    try {
      var client = http.Client();
      String group = blood_group.replaceAll("+", "%2B");

      var response = await client.get(server_url +
          "donate_blood?username=$username&name=${nameController.text}&gender=${gender}&email=${emailController.text}&phone=${phoneController.text}&weight=${weightController.text}&blood_group=${group}");
      Map<String, dynamic> results = jsonDecode(response.body.toString());
      Toast.show(results["result"], context,
          duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
    } catch (e) {
      Toast.show("Error: Make sure you are connected to internet", context,
          duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          children: [
            Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "Fill in Below Details",
                  style: TextStyle(
                    fontSize: 32.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            _inputWidets(nameController, "Name"),
            _inputWidets(emailController, "Email"),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                keyboardType: TextInputType.number,
                controller: phoneController,
                decoration: InputDecoration(
                  labelText: "Phone Number",
                  labelStyle: TextStyle(fontSize: 18.0),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                keyboardType: TextInputType.number,
                controller: weightController,
                decoration: InputDecoration(
                  labelText: "Weight",
                  labelStyle: TextStyle(fontSize: 18.0),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: DropdownButtonFormField(
                isDense: true,
                icon: Icon(Icons.arrow_drop_down_circle),
                iconSize: 22.0,
                iconEnabledColor: Theme.of(context).primaryColor,
                items: _blood_group_list.map(
                  (String priority) {
                    return DropdownMenuItem(
                        value: priority,
                        child: Text(
                          priority,
                          style: TextStyle(color: Colors.black, fontSize: 18.0),
                        ));
                  },
                ).toList(),
                style: TextStyle(
                  fontSize: 18.0,
                ),
                decoration: InputDecoration(
                  labelText: "Blood Group",
                  labelStyle: TextStyle(fontSize: 18.0),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
                onChanged: (value) {
                  setState(() {
                    blood_group = value;
                  });
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: DropdownButtonFormField(
                isDense: true,
                icon: Icon(Icons.arrow_drop_down_circle),
                iconSize: 22.0,
                iconEnabledColor: Theme.of(context).primaryColor,
                items: _gender_list.map(
                  (String priority) {
                    return DropdownMenuItem(
                        value: priority,
                        child: Text(
                          priority,
                          style: TextStyle(color: Colors.black, fontSize: 18.0),
                        ));
                  },
                ).toList(),
                style: TextStyle(
                  fontSize: 18.0,
                ),
                decoration: InputDecoration(
                  labelText: "Gender",
                  labelStyle: TextStyle(fontSize: 18.0),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
                onChanged: (value) {
                  setState(() {
                    gender = value;
                  });
                },
              ),
            ),
            Container(
              margin: EdgeInsets.all(16.0),
              padding: EdgeInsets.all(16.0),
              height: 60.0,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                borderRadius: BorderRadius.circular(30.0),
              ),
              child: FlatButton(
                  onPressed: () => _donateBlood(),
                  child: Text(
                    "Donate Blood",
                    style: TextStyle(color: Colors.white, fontSize: 20.0),
                  )),
            ),
          ],
        ),
      ),
    );
  }
}

Widget _inputWidets(TextEditingController controllers, String text) {
  return Padding(
    padding: const EdgeInsets.all(16.0),
    child: TextField(
      controller: controllers,
      decoration: InputDecoration(
        labelText: text,
        labelStyle: TextStyle(fontSize: 18.0),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
    ),
  );
}
