import 'dart:convert';

import 'package:donor/screens/authentication/register.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:donor/export_api_url.dart';
import 'package:toast/toast.dart';

class ProfileTab extends StatefulWidget {
  @override
  _ProfileTabState createState() => _ProfileTabState();
}

class _ProfileTabState extends State<ProfileTab> {
  final myController = TextEditingController();
  final lastNameController = TextEditingController();
  final userNameController = TextEditingController();
  final passwordController = TextEditingController();
  final emailController = TextEditingController();

  int primaryKey;

  _updateControllers() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    myController.text = sharedPreferences.getString("firstname");
    lastNameController.text = sharedPreferences.getString("lastName");
    userNameController.text = sharedPreferences.getString("username");
    passwordController.text = sharedPreferences.getString("password");
    emailController.text = sharedPreferences.getString("email");
    String username = sharedPreferences.getString("username");
    print(username);
    var client = http.Client();
    var response = await client.get(server_url + "get_pk?username=$username");
    Map<String, dynamic> resp = jsonDecode(response.body.toString());
    print(resp);
    primaryKey = resp["result"];
    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _updateControllers();
  }

  _updateUser() async {
    FocusScope.of(context).requestFocus(new FocusNode());

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String currentUsername = prefs.getString("username");
    String currentEmail = prefs.getString("email");
    var client = http.Client();
    var response = await client.get(server_url +
        "update_user?pk=$primaryKey&name=${myController.text}&currentuser=$currentUsername&currentemail=$currentEmail&lastname=${lastNameController.text}&username=${userNameController.text}&password=${passwordController.text}&email=${emailController.text}");
    Map<String, dynamic> userResponse = jsonDecode(response.body.toString());
    if (userResponse != "username or email exists") {
      await prefs.setInt("counter", 1);
      await prefs.setString("username", userNameController.text);
      await prefs.setString("lastName", lastNameController.text);

      await prefs.setString("password", passwordController.text);

      await prefs.setString("firstname", myController.text);
      await prefs.setString("email", emailController.text);
    }
    Toast.show(userResponse["result"], context,
        duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
  }

  _logoutUser() async {
    FocusScope.of(context).requestFocus(new FocusNode());

    SharedPreferences prefs = await SharedPreferences.getInstance();

    await prefs.setInt("counter", 2);
    await prefs.setString("username", userNameController.text);
    await prefs.setString("lastName", lastNameController.text);

    await prefs.setString("password", passwordController.text);

    await prefs.setString("firstname", myController.text);
    await prefs.setString("email", emailController.text);

    Toast.show("Logging out", context,
        duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (_) => Register()));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              "Edit Profile",
              style: TextStyle(
                fontSize: 32.0,
                fontFamily: 'Roboto',
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          _inputWidets(myController, "First Name"),
          _inputWidets(lastNameController, "Last Name"),
          _inputWidets(userNameController, "Username"),
          _inputWidets(passwordController, "Password"),
          _inputWidets(emailController, "Email"),
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
                onPressed: () => _updateUser(),
                child: Text(
                  "Register",
                  style: TextStyle(color: Colors.white, fontSize: 20.0),
                )),
          ),
          Container(
            margin: EdgeInsets.all(16.0),
            padding: EdgeInsets.all(16.0),
            height: 60.0,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.red,
              borderRadius: BorderRadius.circular(30.0),
            ),
            child: FlatButton(
                onPressed: () => _logoutUser(),
                child: Text(
                  "Logout",
                  style: TextStyle(color: Colors.white, fontSize: 20.0),
                )),
          ),
        ],
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
