import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sample_app/services/api_call_handling.dart';
import 'package:sample_app/services/http/http_post/post_login.dart';
import 'package:sample_app/widgets/button_widget.dart';
import 'package:get_storage/get_storage.dart';
import 'package:sample_app/widgets/dialog_widget.dart';
import 'package:sample_app/widgets/text_widget.dart';
import 'package:sample_app/widgets/textformfield_widget.dart';

class LoginPage extends StatefulWidget {
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final box = GetStorage();

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  bool isNotHidden = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(
                height: 20,
              ),
              Image.network(
                  'https://cdn.dribbble.com/users/5965492/screenshots/14778540/media/98b8be2196e7b039669f2b027a2e6e97.png'),
              const SizedBox(
                height: 20,
              ),
              TextFormFieldWidget(
                isEmail: true,
                isPassword: false,
                inputController: _emailController,
                label: 'Email',
                prefixIcon: Icons.email,
              ),
              TextFormFieldWidget(
                  isEmail: false,
                  isPassword: true,
                  inputController: _passwordController,
                  label: 'Password',
                  prefixIcon: Icons.lock),
              const SizedBox(
                height: 30,
              ),
              Visibility(
                visible: isNotHidden,
                child: ButtonWidget(
                  onPressed: () async {
                    try {
                      login(_emailController.text, _passwordController.text);

                      GoRouter.of(context).replace('/home');
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
                    ApiCallHandling().putDelay(isNotHidden);
                  },
                  text: 'Login',
                ),
              ),
              const SizedBox(
                height: 80,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextWidget(
                      text: 'No Account?',
                      color: Colors.grey,
                      fontSize: 14,
                      fontWeight: FontWeight.normal),
                  TextButton(
                    onPressed: () async {
                      GoRouter.of(context).push('/signup');
                    },
                    child: TextWidget(
                        text: 'Create now',
                        color: Colors.pink[200]!,
                        fontSize: 14,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
