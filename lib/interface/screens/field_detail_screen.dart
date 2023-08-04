import 'package:flutter/material.dart';
import 'package:presisawit_app/interface/theme/app_colors.dart';

class FieldDetailScreen extends StatefulWidget {
  final Function onPop;
  const FieldDetailScreen({super.key, required this.onPop});

  @override
  State<FieldDetailScreen> createState() => _FieldDetailScreenState();
}

class _FieldDetailScreenState extends State<FieldDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Column(
              children: [
                Container(
                  color: AppColors.primaryColor,
                  width: double.maxFinite,
                  height: 350,
                  child: SafeArea(
                      child: Column(
                    children: [
                      Container(
                        margin: EdgeInsets.all(16),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            IconButton(
                              onPressed: () => widget.onPop(),
                              icon: Icon(
                                Icons.arrow_back_ios_new,
                                color: AppColors.white,
                                size: 24,
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  )),
                ),
                const SizedBox(
                  height: double.maxFinite,
                  child: Column(
                    children: [Text('')],
                  ),
                )
              ],
            ),
            Positioned(
              right: 30,
              left: 30,
              top: 300,
              child: Container(
                height: 80,
                decoration: const BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.all(Radius.circular(12))),
                child: const Row(
                  children: [Text('')],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
