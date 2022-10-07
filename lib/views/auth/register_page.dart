import 'package:flutter/material.dart';
import 'package:sample_app/views/auth/login_page.dart';
import 'package:sample_app/views/widgets/button_widget.dart';

import '../../services/http/http_post/post_register.dart';

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
        backgroundColor: Colors.pink[200],
        title: const Text('Register'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              Image.network(
                  'https://cdn.dribbble.com/users/5965492/screenshots/14778540/media/98b8be2196e7b039669f2b027a2e6e97.png'),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(30, 10, 30, 10),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: TextFormField(
                    onChanged: (input) {
                      name = input;
                    },
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      label: const Text('Name'),
                      prefixIcon: Icon(
                        Icons.person,
                        color: Colors.pink[200],
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(30, 10, 30, 10),
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
                padding: const EdgeInsets.fromLTRB(30, 10, 30, 30),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: TextFormField(
                    obscureText: true,
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
              ButtonWidget(
                  onPressed: () {
                    register(email, password, name);
                    Navigator.of(context).pushReplacement(
                        MaterialPageRoute(builder: (context) => LoginPage()));
                  },
                  text: 'Register'),
            ],
          ),
        ),
      ),
    );
  }
}
