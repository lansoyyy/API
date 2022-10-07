import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:sample_app/services/http/http_get/get_product_list.dart';
import 'package:sample_app/views/auth/register_page.dart';
import 'package:sample_app/views/pages/home_page.dart';
import 'package:sample_app/views/widgets/button_widget.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:get_storage/get_storage.dart';
import '../../services/config/api_config.dart';
import '../../services/http/http_post/post_login.dart';

class LoginPage extends StatefulWidget {
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final box = GetStorage();
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
                onPressed: () async {
                  final box = GetStorage();
                  var jsonResponse;

                  Map data = {
                    'email': email,
                    'password': password,
                  };

                  String body = json.encode(data);
                  var url = APIConfig().baseUrl + '/login';
                  var response = await http.post(
                    Uri.parse(url),
                    body: body,
                    headers: {
                      "Content-Type": "application/json",
                      "accept": "application/json",
                      "Access-Control-Allow-Origin": "*"
                    },
                  ).timeout(Duration(seconds: 10));

                  // print(response.body["token"]);
                  // prefs.setString("token", jsonResponse['response']['token']);

                  print(response.statusCode);

                  if (response.statusCode == 201) {
                    jsonResponse = json.decode(response.body.toString());
                    print(
                        'login access token is -> ${json.decode(response.body)['token']}');

                    // ignore: avoid_print
                    print('success');
                  } else {
                    print('error');
                  }
                  box.write('token', json.decode(response.body)['token']);

                  await Future.delayed(Duration(seconds: 1));

                  print(box.read('token'));

                  GetProductList().getPageLength('/products');

                  box.write('page', 1);

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
