import 'package:flutter/material.dart';
import 'package:presisawit_app/interface/theme/app_colors.dart';

class AppSnackbars {
  ScaffoldFeatureController errorSnackbar(
      BuildContext context, String errorMessage) {
    return ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(errorMessage),
      backgroundColor: AppColors.red,
    ));
  }
}
