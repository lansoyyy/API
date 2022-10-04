import 'package:flutter/material.dart';



class LoginPage extends StatelessWidget {



  late String username;
  late String password;

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
            
          ],
        ),
      ),
    );
  }
}