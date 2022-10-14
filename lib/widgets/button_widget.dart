import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

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
      child: Container(
        child: Text(
          text,
          style: GoogleFonts.fuzzyBubbles(
            textStyle: const TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18),
          ),
        ),
      ),
    );
  }
}
