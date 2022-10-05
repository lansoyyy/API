import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:sample_app/views/auth/login_page.dart';
import 'package:sample_app/views/home_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../services/http_post/post_register.dart';

class RegisterPage extends StatefulWidget {
  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  late String name = '';

  late String email = '';

  late String password = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: Text('Register'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(30, 0, 30, 10),
              child: TextFormField(
                onChanged: (_input) {
                  name = _input;
                },
                decoration: InputDecoration(label: Text('Name')),
              ),
            ),
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
              padding: const EdgeInsets.fromLTRB(30, 0, 30, 50),
              child: TextFormField(
                onChanged: (_input) {
                  password = _input;
                },
                decoration: InputDecoration(label: Text('Password')),
              ),
            ),
            MaterialButton(
              child: Text(
                'Register',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              minWidth: 200,
              color: Colors.teal,
              onPressed: () {
                register(email, password, name);
                Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => LoginPage()));
              },
            ),
          ],
        ),
      ),
    );
  }
}
