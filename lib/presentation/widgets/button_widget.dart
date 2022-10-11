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
          borderRadius: BorderRadius.circular(100),
        ),
        minWidth: 250,
        color: Colors.pink[200],
        onPressed: onPressed,
        child: Text(
          text,
          style: const TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18),
        ));
  }
}
