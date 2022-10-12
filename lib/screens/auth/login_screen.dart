import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sample_app/services/http/http_get/get_product_list.dart';
import 'package:sample_app/widgets/button_widget.dart';
import 'package:http/http.dart' as http;
import 'package:get_storage/get_storage.dart';
import 'package:sample_app/widgets/dialog_widget.dart';
import 'package:sample_app/widgets/text_widget.dart';
import 'package:sample_app/widgets/textformfield_widget.dart';
import '../../utils/api_config.dart';

class LoginPage extends StatefulWidget {
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final box = GetStorage();

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  bool isNotHidden = true;

  changeVisibility() async {
    await Future.delayed(const Duration(seconds: 3));
    setState(() {
      isNotHidden = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(
                height: 20,
              ),
              Image.network(
                  'https://cdn.dribbble.com/users/5965492/screenshots/14778540/media/98b8be2196e7b039669f2b027a2e6e97.png'),
              const SizedBox(
                height: 20,
              ),
              TextFormFieldWidget(
                isEmail: true,
                isPassword: false,
                inputController: _emailController,
                label: 'Email',
                prefixIcon: Icons.email,
              ),
              TextFormFieldWidget(
                  isEmail: false,
                  isPassword: true,
                  inputController: _passwordController,
                  label: 'Passowrd',
                  prefixIcon: Icons.lock),
              const SizedBox(
                height: 30,
              ),
              Visibility(
                visible: isNotHidden,
                child: ButtonWidget(
                  onPressed: () async {
                    try {
                      final box = GetStorage();
                      var jsonResponse;

                      Map data = {
                        'email': _emailController.text,
                        'password': _passwordController.text,
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

                      GoRouter.of(context).replace('/home');
                    } catch (e) {
                      showDialog(
                          context: context,
                          builder: ((context) {
                            return DialogWidget(content: e.toString());
                          }));
                    }

                    setState(() {
                      isNotHidden = false;
                    });
                    changeVisibility();
                  },
                  text: 'Login',
                ),
              ),
              const SizedBox(
                height: 80,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextWidget(
                      text: 'No Account?',
                      color: Colors.grey,
                      fontSize: 14,
                      fontWeight: FontWeight.normal),
                  TextButton(
                    onPressed: () async {
                      GoRouter.of(context).push('/signup');
                    },
                    child: TextWidget(
                        text: 'Create now',
                        color: Colors.pink[200]!,
                        fontSize: 14,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
