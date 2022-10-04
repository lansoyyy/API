import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:sample_app/views/home_page.dart';

class RegisterPage extends StatefulWidget {


  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  late String name = '';

    late String email = '';

      late String password = '';

Future <void> postData(String  email, password) async {
    var jsonResponse ;
    Map data = {

      'email': email,
      'password': password,

    };
    print(data);

     String body = json.encode(data);
    var url = 'https://api-001.emberspec.com/api/login';
    var response = await http.post(
      Uri.parse(url),
      body: body,
      headers: {
        "Content-Type": "application/json",
        "accept": "application/json",
        "Access-Control-Allow-Origin": "*"
      },
    ).timeout(Duration(seconds: 10));

    print(response.body);
    print(response.statusCode);

    if (response.statusCode == 201) {
       jsonResponse = json.decode(response.body.toString());

        Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => HomePage()));
      // ignore: avoid_print
      print('success');
    } else {
      print('error');
    }



}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                decoration: InputDecoration(
                  label: Text('Name')
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(30, 0, 30, 10),
              child: TextFormField(
                 onChanged: (_input) {
                  email = _input;
                },
                decoration: InputDecoration(
                  label: Text('Email')
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(30, 0, 30, 50),
              child: TextFormField(
                 onChanged: (_input) {
                  password = _input;
                },
                decoration: InputDecoration(
                  label: Text('Password')
                ),
              ),
            ),
            MaterialButton(
              child: Text('Register',
              style: TextStyle(
                color: Colors.white,
              ),),
              minWidth: 200,
              color: Colors.teal,
              onPressed: () {
                postData(email, password);
              },),
          ],
        ),
      ),
    );
  }
}