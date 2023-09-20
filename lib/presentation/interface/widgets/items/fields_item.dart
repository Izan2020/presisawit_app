import 'package:flutter/material.dart';
import 'package:presisawit_app/domain/entities/field.dart';

import '../../theme/app_colors.dart';

class FieldItem extends StatelessWidget {
  final Field field;
  const FieldItem({super.key, required this.field});

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
                  Text(
                    "Kode ${field.code}",
                    style: const TextStyle(
                        fontSize: 8,
                        fontWeight: FontWeight.w700,
                        color: AppColors.darkGray),
                  ),
                  Container(
                    height: 8,
                  ),
                  Text(
                    field.name,
                    style: const TextStyle(fontWeight: FontWeight.w700),
                  ),
                  Text(
                    field.createdAt,
                    style: const TextStyle(
                        fontWeight: FontWeight.w400, fontSize: 13),
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
