import 'package:flutter/material.dart';
import 'package:full_stack_app/helpers/navigator_global.dart';
import 'package:full_stack_app/helpers/snackbar_global.dart';
import 'package:full_stack_app/views/widgets/home_app.dart';
import 'package:full_stack_app/views/widgets/login_view_app.dart';
import 'package:full_stack_app/views/widgets/splash_app.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Full Stack App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      // home: const MyHomePage(title: 'Flutter Demo Home Page'),
      // home: const LoginViewApp(),
      routes: {
        'login': (_) => const LoginViewApp(),
        'home': (_) => const HomeApp(),
      },
      home: const SplashApp(),
      builder: (context, child) => SafeArea(child: child!),
      scaffoldMessengerKey: snackbarKey,
      navigatorKey: navigatorKey,
    );
  }
}
