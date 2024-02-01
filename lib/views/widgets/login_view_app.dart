import 'package:flutter/material.dart';
import 'package:full_stack_app/views/login_view.dart';

class LoginViewApp extends StatelessWidget {
  const LoginViewApp({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Login',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.blue[900],
      ),
      body: const Center(child: LoginView()),
    );
  }
}
