import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sample_app/widgets/button_widget.dart';
import 'package:sample_app/widgets/dialog_widget.dart';
import 'package:sample_app/widgets/textformfield_widget.dart';

import '../../services/http/http_post/post_register.dart';

class RegisterPage extends StatefulWidget {
  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  bool isNotHidden = true;

  changeVisibility() async {
    await Future.delayed(const Duration(seconds: 3));
    setState(() {
      isNotHidden = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.pink[200],
        title: const Text('Register'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              Image.network(
                  'https://cdn.dribbble.com/users/5965492/screenshots/14778540/media/98b8be2196e7b039669f2b027a2e6e97.png'),
              const SizedBox(
                height: 20,
              ),
              TextFormFieldWidget(
                  isEmail: false,
                  isPassword: false,
                  inputController: _nameController,
                  label: 'Name',
                  prefixIcon: Icons.person),
              TextFormFieldWidget(
                  isEmail: true,
                  isPassword: false,
                  inputController: _emailController,
                  label: 'Email',
                  prefixIcon: Icons.email),
              TextFormFieldWidget(
                  isEmail: false,
                  isPassword: true,
                  inputController: _passwordController,
                  label: 'Password',
                  prefixIcon: Icons.lock),
              Visibility(
                visible: isNotHidden,
                child: ButtonWidget(
                    onPressed: () {
                      try {
                        register(_emailController.text,
                            _passwordController.text, _nameController.text);
                        GoRouter.of(context).replace('/');
                      } catch (e) {
                        showDialog(
                            context: context,
                            builder: ((context) {
                              return DialogWidget(content: e.toString());
                            }));
                      }
                      setState(() {
                        isNotHidden = false;
                      });
                      changeVisibility();
                    },
                    text: 'Register'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
