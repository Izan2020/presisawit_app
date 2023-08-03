import 'package:flutter/material.dart';
import 'package:presisawit_app/interface/static/app_images.dart';
import 'package:presisawit_app/interface/theme/app_colors.dart';
import 'package:presisawit_app/interface/widgets/buttons.dart';
import 'package:url_launcher/url_launcher.dart';

class AuthScreen extends StatelessWidget {
  final Function onGotoRegister;
  final Function onGotoLogin;
  const AuthScreen(
      {super.key, required this.onGotoRegister, required this.onGotoLogin});

  _launchURL() async {
    final Uri url = Uri.parse('https://flutter.dev');
    if (!await launchUrl(url)) {
      throw Exception('Could not launch $url');
    }
  }

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
              onTap: () => onGotoRegister(),
            ),
            Container(
              height: 12,
            ),
            PrimaryButton(
              text: 'Daftarkan Perusahaan Anda',
              onTap: () => _launchURL(),
            ),
            Container(
              height: 12,
            ),
            SecondaryButton(
              text: 'Masuk',
              onTap: () => onGotoLogin(),
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
