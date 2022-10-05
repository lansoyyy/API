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


        register() async {
    var client = http.Client();
                var url = Uri.parse('http://api-001.emberspec.com/api/login');
    
    var _headers = {
      
      
      'accept': "application/json",
      "Access-Control-Allow-Origin": "*",
      
    };

    var response = await client.post(url, body: {
            'username': email,
             'password': password,
             'name': name,
      
    }, headers: _headers);
    if (response.statusCode == 200) {


      var mydata = json.encode(response.body);
      print(mydata);
      return mydata;
    } else {
      //throw exception and catch it in UI
    }
  }



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

                register();
                Navigator.of(context).pushReplacement(
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                 HomePage()));
              },),
          ],
        ),
      ),
    );
  }
}