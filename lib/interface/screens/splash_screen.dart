import 'package:flutter/material.dart';
import 'package:presisawit_app/interface/static/app_images.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.asset(
          AppImages.mainLogo,
          scale: 2.5,
        ),
      ),
    );
  }
}
