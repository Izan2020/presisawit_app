import 'package:flutter/material.dart';

import '../../theme/app_colors.dart';

class FieldItem extends StatelessWidget {
  const FieldItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.all(16),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: 12,
              ),
              Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'KODE KEBUN 001',
                    style: TextStyle(
                        fontSize: 8,
                        fontWeight: FontWeight.w700,
                        color: AppColors.darkGray),
                  ),
                  Container(
                    height: 8,
                  ),
                  const Text(
                    'Kebun Satu',
                    style: TextStyle(fontWeight: FontWeight.w700),
                  ),
                  const Text(
                    'Kebun Satu',
                    style: TextStyle(fontWeight: FontWeight.w400, fontSize: 13),
                  ),
                ],
              )
            ],
          ),
        ),
        const Divider(
          thickness: 1,
          height: 1.4,
          color: AppColors.white,
        )
      ],
    );
  }
}
