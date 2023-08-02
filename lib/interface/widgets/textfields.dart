import 'package:flutter/material.dart';

import '../constants/app_colors.dart';

class PrimaryTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;

  const PrimaryTextField({
    super.key,
    required this.controller,
    required this.hintText,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.all(12),
        height: 55,
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        decoration: const BoxDecoration(color: AppColors.white),
        child: TextField(
          controller: controller,
          cursorColor: AppColors.darkGray,
          decoration: InputDecoration(
              border: InputBorder.none,
              hoverColor: AppColors.black,
              hintText: hintText),
        ));
  }
}
