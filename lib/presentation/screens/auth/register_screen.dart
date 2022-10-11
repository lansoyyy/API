import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sample_app/presentation/widgets/button_widget.dart';
import 'package:sample_app/presentation/widgets/textformfield_widget.dart';

import '../../../data/services/http/http_post/post_register.dart';

class RegisterPage extends StatefulWidget {
  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

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
                  inputController: _nameController,
                  label: 'Name',
                  prefixIcon: Icons.person),
              TextFormFieldWidget(
                  inputController: _emailController,
                  label: 'Email',
                  prefixIcon: Icons.email),
              TextFormFieldWidget(
                  inputController: _passwordController,
                  label: 'Password',
                  prefixIcon: Icons.lock),
              ButtonWidget(
                  onPressed: () {
                    register(_emailController.text, _passwordController.text,
                        _nameController.text);
                    GoRouter.of(context).replace('/');
                  },
                  text: 'Register'),
            ],
          ),
        ),
      ),
    );
  }
}
