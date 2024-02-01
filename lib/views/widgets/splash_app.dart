import 'package:flutter/material.dart';

class SplashApp extends StatefulWidget {
  const SplashApp({Key? key}) : super(key: key);

  @override
  State<SplashApp> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashApp> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 4), () {
      Navigator.pushReplacementNamed(context, 'login');
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FlutterLogo(size: 100),
            SizedBox(height: 20),
            CircularProgressIndicator(),
          ],
        ),
      ),
    );
  }
}
