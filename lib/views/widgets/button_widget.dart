import 'package:flutter/material.dart';

class ButtonWidget extends StatelessWidget {
  late VoidCallback onPressed;

  late String text;

  ButtonWidget({
    required this.onPressed,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5),
        ),
        child: Text(
          text,
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18),
        ),
        minWidth: 250,
        color: Colors.teal,
        onPressed: onPressed);
  }
}
