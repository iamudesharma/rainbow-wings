import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rainbow_wings/provider/auth_provider.dart';
import 'package:rainbow_wings/routes/routes.gr.dart';

class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  LoginPageState createState() => LoginPageState();
}

class LoginPageState extends ConsumerState<LoginPage> {
  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final _auth = ref.watch(authProvider);
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 10,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(
                height: 20,
              ),
              textFormField(
                emailController,
                hintText: 'Enter The  Email',
                icon: Icons.email,
                label: 'Email',
                isPassword: false,
                textInputAction: TextInputAction.next,
              ),
              const SizedBox(
                height: 20,
              ),
              textFormField(
                passwordController,
                hintText: 'Enter The  Password',
                icon: Icons.email,
                label: 'Password',
                isPassword: true,
                textInputAction: TextInputAction.go,
              ),
              const SizedBox(
                height: 50,
              ),
              ElevatedButton(
                onPressed: () async {
                  if (_auth.isLoading) {
                    return;
                  } else {
                    await _auth.login(
                        email: emailController.text,
                        password: passwordController.text);

                    context.router.navigate(const HomeRoute());
                  }
                },
                child: _auth.isLoading
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    : const Text('Login'),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Don\'t have an account?',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 12,
                    ),
                  ),
                  TextButton(
                    onPressed: () {},
                    child: const Text(
                      'Register',
                      style: TextStyle(
                        color: Colors.blue,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  TextFormField textFormField(
    TextEditingController controller, {
    required String hintText,
    required IconData icon,
    required String label,
    bool isPassword = false,
    TextInputAction? textInputAction,
  }) {
    return TextFormField(
      textInputAction: textInputAction,
      controller: controller,
      obscureText: isPassword,
      decoration: InputDecoration(
        labelText: label,
        border: const UnderlineInputBorder(),
        prefixIcon: Icon(
          icon,
        ),
        hintText: hintText,
      ),
    );
  }
}
