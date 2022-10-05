import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:sample_app/auth/register_page.dart';
import 'package:sample_app/views/home_page.dart';
import 'package:sample_app/widgets/button_widget.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../services/http_post/login.dart';

class LoginPage extends StatefulWidget {
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late String email;

  late String password;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: Text('Login'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(30, 0, 30, 10),
              child: TextFormField(
                onChanged: (_input) {
                  email = _input;
                },
                decoration: InputDecoration(label: Text('Email')),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(30, 0, 30, 10),
              child: TextFormField(
                onChanged: (_input) {
                  password = _input;
                },
                decoration: InputDecoration(label: Text('Password')),
              ),
            ),
            SizedBox(
              height: 50,
            ),
            ButtonWidget(
                onPressed: () {
                  LoginOfuser(email, password);
                  Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (context) => HomePage()));
                },
                text: 'Login'),
            SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('No Account?'),
                TextButton(
                    onPressed: () async {
                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                          builder: (context) => RegisterPage()));
                    },
                    child: Text(
                      'Create Now',
                      style: TextStyle(color: Colors.teal),
                    ))
              ],
            )
          ],
        ),
      ),
    );
  }
}
