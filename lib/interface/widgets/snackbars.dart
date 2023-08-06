import 'package:flutter/material.dart';
import 'package:presisawit_app/interface/theme/app_colors.dart';

enum SnackBars { error, success, warning }

Future<ScaffoldFeatureController> showSnackbar(
    BuildContext context, String message, SnackBars type) async {
  if (!context.mounted) {
    throw Exception('Context is not mounted!');
  }

  Color? backgroundColor;

  switch (type) {
    case SnackBars.error:
      backgroundColor = AppColors.dangerColor;
      break;
    case SnackBars.success:
      backgroundColor = AppColors.successColor;
      break;
    case SnackBars.warning:
      backgroundColor = AppColors.warningColor;
      break;
    default:
      AppColors.gray;
  }

  return ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Text(message),
    backgroundColor: backgroundColor,
  ));
}
