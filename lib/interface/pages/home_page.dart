import 'package:flutter/material.dart';
import 'package:presisawit_app/interface/theme/app_colors.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        margin: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Halo, Hamas',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
                ),
                IconButton(
                    onPressed: () {}, icon: const Icon(Icons.notifications))
              ],
            ),
            Container(height: 12),
            Container(
              height: 120,
              decoration: const BoxDecoration(
                  color: AppColors.primaryColor,
                  borderRadius: BorderRadius.all(Radius.circular(12))),
            ),
            Container(
                margin: const EdgeInsets.symmetric(vertical: 15),
                child: const Divider(
                  color: AppColors.gray,
                )),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Flexible(
                  flex: 1,
                  child: Container(
                    height: 120,
                    decoration: const BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                              blurRadius: 12,
                              spreadRadius: 0.2,
                              color: AppColors.gray)
                        ],
                        color: AppColors.white,
                        borderRadius: BorderRadius.all(Radius.circular(13))),
                  ),
                ),
                Container(
                  width: 12,
                ),
                Flexible(
                  flex: 1,
                  child: Container(
                    height: 120,
                    decoration: const BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                              blurRadius: 12,
                              spreadRadius: 0.2,
                              color: AppColors.gray)
                        ],
                        color: AppColors.white,
                        borderRadius: BorderRadius.all(Radius.circular(13))),
                  ),
                ),
              ],
            ),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Recent Tasks',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  IconButton(onPressed: () {}, icon: const Icon(Icons.sort))
                ],
              ),
            ),
            Container(
                width: double.maxFinite,
                height: double.maxFinite,
                margin: EdgeInsets.only(bottom: 32),
                child: ListView.builder(itemBuilder: (build, context) {
                  return Text('data');
                }))
          ],
        ),
      ),
    );
  }
}
