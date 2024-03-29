import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:full_stack_app/helpers/constant.dart';
import 'package:full_stack_app/helpers/provider_global.dart';
import 'package:full_stack_app/http/api_response.dart';
import 'package:full_stack_app/http/backend_api.dart';
import 'package:full_stack_app/models/login.dart';
import 'package:full_stack_app/models/user_sign_in.dart';
import 'package:full_stack_app/views/widgets/snackbar.dart';

class LoginView extends ConsumerStatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  ConsumerState<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends ConsumerState<LoginView> {
  bool _isLoading = false;
  final TextEditingController _username = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _username.dispose();
    _password.dispose();
    super.dispose();
  }

  Widget _getWidget() {
    if (_isLoading) {
      return Column(children: [
        const Center(
            child: Text(
          GeneralConstants.loading,
          // style: Theme.of(context).primaryColor,
        )),
        Center(
            child: Padding(
          padding: const EdgeInsets.only(top: 16.0),
          child: Center(
            child: SpinKitChasingDots(
              color: Theme.of(context).primaryColor,
              size: 50.0,
            ),
          ),
        ))
      ]);
    } else {
      return Container(
        height: 50,
        width: 250,
        decoration: BoxDecoration(
            color: Theme.of(context).primaryColor,
            borderRadius: BorderRadius.circular(20)),
        child: TextButton(
          style: TextButton.styleFrom(
            foregroundColor: Colors.white,
            textStyle: const TextStyle(fontSize: 21, color: Colors.white),
          ),
          onPressed: () async {
            if (_formKey.currentState?.validate() ?? false) {
              var userLoggedIn = await _login();
              if (userLoggedIn != null && userLoggedIn.data != null) {
                _registerUserLoggedIn(userLoggedIn.data!);
              }
            } else {
              showError(SingInFormConstants.loginErrors);
            }
          },
          child: const Text(SingInFormConstants.login),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Form(
            key: _formKey,
            child: Column(children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(
                    left: 15.0, right: 15.0, top: 8.0, bottom: 0),
                child: TextFormField(
                  controller: _username,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return SingInFormConstants.userRequired;
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: SingInFormConstants.user,
                      hintText: SingInFormConstants.user),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: 15.0, right: 15.0, top: 15.0, bottom: 0),
                child: TextFormField(
                  obscureText: true,
                  controller: _password,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return SingInFormConstants.passwordRequired;
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: SingInFormConstants.password,
                      hintText: SingInFormConstants.password),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 32.0),
                child: _getWidget(),
              )
            ])));
  }

  void _loading(bool state) {
    setState(() {
      _isLoading = state;
    });
  }

  Future<ApiResponse<UserSignIn>?> _login() async {
    var httpClient = ref.watch(httpClientProvider);
    _loading(true);
    try {
      BackendApi backendApi = BackendApi(httpClient: httpClient);
      var login = Login(username: _username.text, password: _password.text);
      return await backendApi.login(login);
    } catch (ex, stackTrace) {
      showError('${ex.toString()} ${stackTrace.toString()}');
    } finally {
      _loading(false);
    }
    return null;
  }

  void _registerUserLoggedIn(UserSignIn user) async {
    var userRepository = ref.watch(userRepositoryProvider);
    await userRepository.insert(user);
    if (!context.mounted) return;
    Navigator.pushReplacementNamed(context, 'home');
  }
}
