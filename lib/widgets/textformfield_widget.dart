import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:sample_app/widgets/text_widget.dart';

class TextFormFieldWidget extends StatelessWidget {
  late TextEditingController inputController;

  late String label;

  late IconData? prefixIcon;

  late bool isPassword;
  late bool isEmail;

  TextFormFieldWidget({
    required this.inputController,
    required this.label,
    this.prefixIcon,
    required this.isPassword,
    required this.isEmail,
  });

  @override
  Widget build(BuildContext context) {
    return Form(
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(30, 0, 30, 10),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(5),
          ),
          child: TextFormField(
            obscureText: isPassword ? true : false,
            validator: (value) {
              isEmail
                  ? EmailValidator.validate(value!) == false
                      ? "Input valid email address"
                      : null
                  : null;
              if (value == null) {
                return "$label field is required";
              } else {
                return 'Enter this field';
              }
            },
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
      ),
    );
  }
}
