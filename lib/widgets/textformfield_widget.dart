import 'package:flutter/material.dart';
import 'package:sample_app/widgets/text_widget.dart';

class TextFormFieldWidget extends StatelessWidget {
  late TextEditingController inputController;

  late String label;

  late IconData? prefixIcon;

  TextFormFieldWidget(
      {required this.inputController, required this.label, this.prefixIcon});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(30, 0, 30, 10),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(5),
        ),
        child: TextFormField(
          controller: inputController,
          decoration: InputDecoration(
            border: InputBorder.none,
            prefixIcon: Icon(
              prefixIcon,
              color: Colors.pink[200],
            ),
            label: TextWidget(
                text: label,
                color: Colors.black,
                fontSize: 14,
                fontWeight: FontWeight.normal),
          ),
        ),
      ),
    );
  }
}
