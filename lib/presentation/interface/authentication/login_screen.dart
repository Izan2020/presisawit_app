import 'package:flutter/material.dart';
import 'package:presisawit_app/common/constants/enum.dart';
import 'package:presisawit_app/domain/entities/login.dart';

import 'package:presisawit_app/presentation/interface/theme/app_colors.dart';
import 'package:presisawit_app/presentation/interface/widgets/buttons.dart';
import 'package:presisawit_app/presentation/interface/widgets/snackbars.dart';
import 'package:presisawit_app/presentation/interface/widgets/textfields.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  static const routePath = '/login_screen';
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool isObsecure = true;

  @override
  Widget build(BuildContext context) {
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
                      onTap: () {
                        // Todo : OnGotoForgotPassword
                      },
                      child: const Text('Forgot password?')),
                ],
              ),
            ),
            PrimaryButton(text: "Masuk", onTap: () {}),
          ],
        ),
      ),
    );
  }
}
