import 'package:flutter/material.dart';
import 'package:sample_app/screens/loading_screens/loading_screen_toHome.dart';
import 'package:sample_app/screens/loading_screens/loading_screen_toLogin.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MainScreen extends StatefulWidget {
  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  void initState() {
    // TODO: implement initState
    getToken();

    super.initState();
  }

  String? token;

  Future<String?> getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.getString('token');
  }

  @override
  Widget build(BuildContext context) {
    getToken().then((value) {
      setState(() {
        token = value;
      });
    });

    return token == "" ? LoadingScreenToLogin() : LoadingScreenToHome();
  }
}
