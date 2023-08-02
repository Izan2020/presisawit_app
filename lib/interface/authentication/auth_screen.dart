import 'package:flutter/material.dart';
import 'package:presisawit_app/interface/constants/app_colors.dart';
import 'package:presisawit_app/interface/widgets/buttons.dart';

class AuthScreen extends StatelessWidget {
  final Function onGotoRegister;
  final Function onGotoLogin;
  const AuthScreen(
      {super.key, required this.onGotoRegister, required this.onGotoLogin});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              'Maintain your Field Site',
              style: TextStyle(
                  color: AppColors.black,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  height: 3),
            ),
            const Text(
              'Maintain your Field Site',
              style: TextStyle(color: AppColors.darkGray),
            ),
            Container(
              height: 32,
            ),
            PrimaryButton(
              text: 'Daftar sebagai Karyawan',
              onTap: () => onGotoRegister(),
            ),
            Container(
              height: 22,
            ),
            SecondaryButton(
              text: 'Masuk',
              onTap: () => onGotoLogin(),
            ),
            Container(
              height: 22,
            ),
          ],
        ),
      ),
    );
  }
}
