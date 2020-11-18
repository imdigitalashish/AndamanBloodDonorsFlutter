import 'dart:convert';

import 'package:donor/models/user.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toast/toast.dart';
import 'package:http/http.dart' as http;
import 'package:donor/export_api_url.dart';
import '../homescreen.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  // Create a text controller and use it to retrieve the current value
  // of the TextField.

  final userNameController = TextEditingController();
  final passwordController = TextEditingController();

  _submit() async {
    FocusScope.of(context).requestFocus(new FocusNode());
    Toast.show("LOGGING YOU IN...", context,
        duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);

    try {
      var client = http.Client();
      var uriResponse = await client.get(server_url +
          "login?username=${userNameController.text}&password=${passwordController.text}");
      client.close();
      Map<String, dynamic> user = jsonDecode(uriResponse.body.toString());
      print(user);
      if (user["result"] != "Invalid Credentials") {
        User currentuser = User.fromJson(user);
        print(currentuser.emailHeader);
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setInt("counter", 1);
        await prefs.setString("username", currentuser.username);
        await prefs.setString("lastName", currentuser.lastname);

        await prefs.setString("password", currentuser.password);

        await prefs.setString("firstname", currentuser.firstname);
        await prefs.setString("email", currentuser.emailHeader);

        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (_) => HomeScreen()));
      } else {
        Toast.show(user["result"], context,
            duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
      }
    } catch (e) {
      Toast.show("Error: Make sure you are connected to internet", context,
          duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
    }

    // Toast.show(resp["result"], context,
    //     duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 12.0),
              child: Text(
                "Log in",
                style: TextStyle(
                  fontSize: 32.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            _inputWidets(userNameController, "Username"),
            _inputWidets(passwordController, "Password"),
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
                  onPressed: () => _submit(),
                  child: Text(
                    "Log In",
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
                    "Or Register First",
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
