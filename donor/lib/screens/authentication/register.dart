import 'dart:convert';

import 'package:donor/screens/authentication/login.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:donor/export_api_url.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toast/toast.dart';

import '../homescreen.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  // Create a text controller and use it to retrieve the current value
  // of the TextField.
  final myController = TextEditingController();
  final lastNameController = TextEditingController();
  final userNameController = TextEditingController();
  final passwordController = TextEditingController();
  final emailController = TextEditingController();

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    myController.dispose();
    super.dispose();
  }

  _submit(mycontext) async {
    FocusScope.of(context).requestFocus(new FocusNode());

    var client = http.Client();
    var uriResponse = await client.get(server_url +
        "signup?first_name=${myController.text}&last_name=${lastNameController.text}&username=${userNameController.text}&password=${passwordController.text}&email=${emailController.text}");
    client.close();
    Map<String, dynamic> resp = jsonDecode(uriResponse.body.toString());
    if (resp["result"] != "Please write carefully") {
      if (resp["result"] != "username or email exists") {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setInt("counter", 1);
        await prefs.setString("username", userNameController.text);
        await prefs.setString("lastName", lastNameController.text);

        await prefs.setString("password", passwordController.text);

        await prefs.setString("firstname", myController.text);
        await prefs.setString("email", emailController.text);

        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (_) => HomeScreen()));
      }
    }

    Toast.show(resp["result"], context,
        duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
    Toast.show("Make sure you are connected to internet", context,
        duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 12.0),
              child: Center(
                child: Text(
                  "Register",
                  style: TextStyle(
                    fontSize: 32.0,
                    fontWeight: FontWeight.bold,
                  ),
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
                  onPressed: () => _submit(context),
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
                color: Colors.green,
                borderRadius: BorderRadius.circular(30.0),
              ),
              child: FlatButton(
                  onPressed: () => Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (_) => LoginScreen())),
                  child: Text(
                    "Log in",
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
