import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:sample_app/auth/register_page.dart';
import 'package:sample_app/widgets/button_widget.dart';
import 'package:http/http.dart' as http;


class LoginPage extends StatelessWidget {



  late String username;
  late String password;


  login() async {
    var client = http.Client();
                var url = Uri.parse('http://api-001.emberspec.com/api/login');
    
    var _headers = {
      
      
      'accept': "application/json",
      "Access-Control-Allow-Origin": "*",
      
    };

    var response = await client.post(url, body: {
            'username': username,
             'password': password,
      
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
                  username = _input;
                },
                decoration: InputDecoration(
                  label: Text('Username')
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(30, 0, 30, 10),
              child: TextFormField(
                onChanged: (_input) {
                  password = _input;
                },
                decoration: InputDecoration(
                  label: Text('Password')
                ),
              ),
            ),
            SizedBox(height: 50,),
           ButtonWidget(onPressed: () {
            login();
            Navigator.of(context).pushReplacement(
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                 LoginPage()));
           }, text: 'Login'),
           SizedBox(height: 30,),
           Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('No Account?'),
              TextButton(onPressed: () async {
                    
                Navigator.of(context).pushReplacement(
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                 RegisterPage()));
              }, child: Text('Create Now',
              style: TextStyle(
                color: Colors.teal
              ),))
            ],
           )
            
          ],
        ),
      ),
    );
  }
}