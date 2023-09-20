import 'package:flutter/material.dart';
import 'package:presisawit_app/presentation/interface/theme/app_colors.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({super.key});

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        iconTheme: const IconThemeData(color: AppColors.black),
        backgroundColor: AppColors.backgroundColor,
        title: const Text(
          'Reset Password',
          style: TextStyle(color: AppColors.black),
        ),
      ),
    );
  }
}
