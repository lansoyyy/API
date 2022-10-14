import 'package:flutter/material.dart';
import 'package:sample_app/screens/auth/login_screen.dart';
import 'package:sample_app/screens/home_screen.dart';
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

  getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.getString('token');
  }

  @override
  Widget build(BuildContext context) {
    print(getToken());
    return getToken() == "" ? LoginScreen() : const HomeScreen();
  }
}
