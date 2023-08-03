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
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'All Fields',
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.w700),
                    ),
                    Text(
                      'di Perusahaan Hamas',
                      style:
                          TextStyle(fontSize: 12, fontWeight: FontWeight.w300),
                    ),
                  ],
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
                  itemCount: 12,
                  itemBuilder: ((context, index) {
                    return Column(
                      children: [
                        Container(
                          margin: EdgeInsets.all(16),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                height: 52,
                                width: 52,
                                decoration: BoxDecoration(
                                    color: AppColors.secondaryColor,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(12))),
                              ),
                            ],
                          ),
                        ),
                        Divider(
                          height: 1.4,
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
