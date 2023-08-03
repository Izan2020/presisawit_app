import 'package:flutter/material.dart';
import 'package:presisawit_app/core/constants/enum.dart';

import '../theme/app_colors.dart';

class PrimaryTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final Function(String)? onChange;
  TextFieldSize? size = TextFieldSize.medium;
  bool? obsecureText = false;
  final Function? onTapSuffixIcon;
  final Icon? suffixIcon;
  PrimaryTextField(
      {super.key,
      required this.controller,
      required this.hintText,
      this.onChange,
      this.obsecureText,
      this.size,
      this.onTapSuffixIcon,
      this.suffixIcon});

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 13),
        constraints:
            BoxConstraints(minHeight: size == TextFieldSize.medium ? 50 : 100),
        padding: EdgeInsets.symmetric(
            horizontal: 12, vertical: size == TextFieldSize.medium ? 10 : 5),
        decoration: const BoxDecoration(color: AppColors.white),
        child: TextField(
          obscureText: obsecureText ?? false,
          maxLines: size == TextFieldSize.large ? null : 1,
          keyboardType: size == TextFieldSize.large
              ? TextInputType.multiline
              : TextInputType.none,
          onChanged: (value) {
            if (onChange != null) {
              onChange!(value);
            }
          },
          controller: controller,
          cursorColor: AppColors.darkGray,
          decoration: InputDecoration(
              suffixIcon: obsecureText == false || obsecureText == true
                  ? IconButton(
                      onPressed: () => onTapSuffixIcon!(),
                      icon: Icon(obsecureText == true
                          ? Icons.visibility
                          : Icons.visibility_off))
                  : null,
              border: InputBorder.none,
              hoverColor: AppColors.black,
              hintText: hintText),
        ));
  }
}
