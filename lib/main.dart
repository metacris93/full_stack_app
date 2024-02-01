import 'package:flutter/material.dart';
import 'package:full_stack_app/helpers/navigator_global.dart';
import 'package:full_stack_app/helpers/snackbar_global.dart';
import 'package:full_stack_app/views/widgets/home_app.dart';
import 'package:full_stack_app/views/widgets/login_view_app.dart';
import 'package:full_stack_app/views/widgets/splash_app.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Full Stack App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
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
