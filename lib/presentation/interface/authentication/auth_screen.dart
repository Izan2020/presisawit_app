import 'package:flutter/material.dart';
import 'package:presisawit_app/presentation/interface/static/app_images.dart';
import 'package:presisawit_app/presentation/interface/theme/app_colors.dart';
import 'package:presisawit_app/presentation/interface/widgets/buttons.dart';

class AuthScreen extends StatelessWidget {
  static const routePath = '/auth_screen';
  const AuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(AppImages.palmOilIllustration, scale: 4.2),
            Container(
              height: 22,
            ),
            const Text(
              'Maintain your Field Site',
              style: TextStyle(
                  color: AppColors.black,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  height: 3),
            ),
            const Text(
              'Manage the cultivation of your \npalm oil plantations.',
              style: TextStyle(color: AppColors.darkGray),
              textAlign: TextAlign.center,
            ),
            Container(
              height: 32,
            ),
            PrimaryButton(
              text: 'Daftar sebagai Karyawan',
              onTap: () {},
            ),
            Container(
              height: 12,
            ),
            PrimaryButton(
              text: 'Daftarkan Perusahaan Anda',
              onTap: () {},
            ),
            Container(
              height: 12,
            ),
            SecondaryButton(
              text: 'Masuk',
              onTap: () {},
            ),
            Container(
              height: 12,
            ),
          ],
        ),
      ),
    );
  }
}
