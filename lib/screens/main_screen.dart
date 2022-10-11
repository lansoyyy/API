import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:sample_app/screens/auth/login_screen.dart';
import 'package:sample_app/screens/home_screen.dart';

class MainScreen extends StatelessWidget {
  final box = GetStorage();

  @override
  Widget build(BuildContext context) {
    return box.read('token') == "" ? LoginPage() : const HomePage();
  }
}
