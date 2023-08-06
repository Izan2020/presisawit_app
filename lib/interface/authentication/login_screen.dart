import 'package:flutter/material.dart';
import 'package:presisawit_app/core/constants/enum.dart';
import 'package:presisawit_app/core/classes/login_credentials.dart';
import 'package:presisawit_app/interface/theme/app_colors.dart';
import 'package:presisawit_app/interface/widgets/buttons.dart';
import 'package:presisawit_app/interface/widgets/snackbars.dart';
import 'package:presisawit_app/interface/widgets/textfields.dart';
import 'package:provider/provider.dart';

import '../../core/providers/auth_provider.dart';

class LoginScreen extends StatefulWidget {
  final Function onLogin;
  final Function onForgotPassword;
  const LoginScreen(
      {super.key, required this.onLogin, required this.onForgotPassword});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool isObsecure = true;

  Future<void> loginUser() async {
    final userCredentials = LoginCredentials(
        email: _emailController.text, password: _passwordController.text);
    final validation = userCredentials.validateCredentials();
    if (validation != null) {
      showSnackbar(context, validation, SnackBars.warning);
      return;
    }

    final authProvider = context.read<AuthProvider>();
    if (authProvider.loginUserState == ServiceState.loading) return;

    final isSuccess = await authProvider.loginUser(userCredentials);
    if (isSuccess) {
      widget.onLogin();
    } else {
      showSnackbar(context, authProvider.message ?? "", SnackBars.error);
    }
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = context.watch<AuthProvider>();
    final loginState = authProvider.loginUserState;
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: AppColors.black),
        backgroundColor: AppColors.backgroundColor,
        elevation: 0,
        title: const Text(
          'Masuk',
          style: TextStyle(color: AppColors.black),
        ),
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            PrimaryTextField(
              controller: _emailController,
              hintText: 'Email',
              size: TextFieldSize.medium,
            ),
            PrimaryTextField(
              onTapSuffixIcon: () {
                setState(() {
                  isObsecure = !isObsecure;
                });
              },
              obsecureText: isObsecure,
              controller: _passwordController,
              hintText: 'Password',
              size: TextFieldSize.medium,
            ),
            Container(height: 12),
            Container(
              margin: const EdgeInsets.only(bottom: 17, right: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  GestureDetector(
                      onTap: () => widget.onForgotPassword(),
                      child: const Text('Forgot password?')),
                ],
              ),
            ),
            PrimaryButton(
                text: loginState == ServiceState.loading
                    ? "Loading..."
                    : loginState == ServiceState.error
                        ? "Try Again"
                        : "Masuk",
                onTap: () => loginUser()),
          ],
        ),
      ),
    );
  }
}
