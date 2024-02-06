import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:full_stack_app/helpers/provider_global.dart';
import 'package:full_stack_app/views/widgets/snackbar.dart';

class SplashApp extends ConsumerStatefulWidget {
  const SplashApp({Key? key}) : super(key: key);

  @override
  ConsumerState<SplashApp> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashApp> {
  @override
  void initState() {
    super.initState();
  }

  Future<void> _startApp() async {
    try {
      var userRepository = ref.watch(userRepositoryProvider);
      var user = await userRepository.getCurrentUser();
      if (user == null) {
        if (!context.mounted) return;
        Navigator.pushReplacementNamed(context, 'login');
      } else {
        if (!context.mounted) return;
        Navigator.pushReplacementNamed(context, 'home');
      }
    } catch (ex, stackTrace) {
      showError('${ex.toString()} ${stackTrace.toString()}');
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _startApp();
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
