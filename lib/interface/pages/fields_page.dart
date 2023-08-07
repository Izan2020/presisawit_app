import 'package:flutter/material.dart';
import 'package:presisawit_app/interface/theme/app_colors.dart';

class FieldsScreen extends StatefulWidget {
  const FieldsScreen({super.key});

  @override
  State<FieldsScreen> createState() => _FieldsScreenState();
}

class _FieldsScreenState extends State<FieldsScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        margin: const EdgeInsets.all(25),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Perkebunan',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700),
                ),
                Text(
                  'Manage',
                  style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      color: AppColors.primaryColor),
                ),
              ],
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 12),
              child: Divider(
                color: AppColors.gray,
              ),
            ),
            Container(
              decoration: BoxDecoration(
                  color: AppColors.lightGray,
                  borderRadius: BorderRadius.all(Radius.circular(12))),
              child: ListView.builder(
                  physics: const ClampingScrollPhysics(), // Add this line
                  shrinkWrap: true,
                  itemCount: 3,
                  itemBuilder: ((context, index) {
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
                                    'KODE KEBUN 001',
                                    style: TextStyle(
                                        fontSize: 8,
                                        fontWeight: FontWeight.w700,
                                        color: AppColors.darkGray),
                                  ),
                                  Container(
                                    height: 8,
                                  ),
                                  Text(
                                    'Kebun Satu',
                                    style:
                                        TextStyle(fontWeight: FontWeight.w700),
                                  ),
                                  Text(
                                    'Kebun Satu',
                                    style: TextStyle(
                                        fontWeight: FontWeight.w400,
                                        fontSize: 13),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                        Divider(
                          thickness: 1,
                          height: 1.4,
                          color: AppColors.white,
                        )
                      ],
                    );
                  })),
            )
          ],
        ),
      ),
    );
  }
}
