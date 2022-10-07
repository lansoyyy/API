import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:sample_app/services/http/http_get/get_product_list.dart';
import 'package:sample_app/views/auth/register_page.dart';
import 'package:sample_app/views/pages/home_page.dart';
import 'package:sample_app/views/widgets/button_widget.dart';
import 'package:http/http.dart' as http;
import 'package:get_storage/get_storage.dart';
import '../../services/config/api_config.dart';

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
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey[200],
        body: SingleChildScrollView(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.network(
                    'https://cdn.dribbble.com/users/5965492/screenshots/14778540/media/98b8be2196e7b039669f2b027a2e6e97.png'),
                const SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(30, 0, 30, 10),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: TextFormField(
                      onChanged: (input) {
                        email = input;
                      },
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        label: const Text('Email'),
                        prefixIcon: Icon(
                          Icons.email,
                          color: Colors.pink[200],
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(30, 0, 30, 10),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: TextFormField(
                      onChanged: (input) {
                        password = input;
                      },
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        label: const Text('Password'),
                        prefixIcon: Icon(
                          Icons.key,
                          color: Colors.pink[200],
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 30,
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
                    var url = '${APIConfig().baseUrl}/login';
                    var response = await http.post(
                      Uri.parse(url),
                      body: body,
                      headers: {
                        "Content-Type": "application/json",
                        "accept": "application/json",
                        "Access-Control-Allow-Origin": "*"
                      },
                    ).timeout(const Duration(seconds: 10));

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

                    await Future.delayed(const Duration(seconds: 1));

                    print(box.read('token'));

                    GetProductList().getPageLength('/products');

                    box.write('page', 1);

                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: (context) => const HomePage()));
                  },
                  text: 'Login',
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'No Account?',
                      style: TextStyle(fontWeight: FontWeight.w400),
                    ),
                    TextButton(
                        onPressed: () async {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => RegisterPage()));
                        },
                        child: Text(
                          'Create Now',
                          style: TextStyle(
                            color: Colors.pink[200],
                            fontWeight: FontWeight.bold,
                          ),
                        ))
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
