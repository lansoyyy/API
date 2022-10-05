import 'package:flutter/material.dart';
import 'package:sample_app/auth/register_page.dart';
import 'package:sample_app/widgets/button_widget.dart';



class LoginPage extends StatelessWidget {



  late String username;
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

           }, text: 'Login'),
           SizedBox(height: 30,),
           Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('No Account?'),
              TextButton(onPressed: () {
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