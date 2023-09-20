import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:presisawit_app/common/constants/enum.dart';
import 'package:presisawit_app/presentation/interface/theme/app_colors.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Container(
      margin: const EdgeInsets.all(25),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Settings',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700),
                  ),
                ],
              ),
            ],
          ),
          Container(
            margin: const EdgeInsets.symmetric(vertical: 12),
            child: const Divider(
              color: AppColors.gray,
            ),
          ),
          Container(
            height: 90,
            decoration: const BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.all(Radius.circular(8)),
                boxShadow: [
                  BoxShadow(
                      blurRadius: 12, spreadRadius: 0.2, color: AppColors.gray)
                ]),
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 14),
              child: Row(
                children: [
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Company Name",
                        style: TextStyle(fontWeight: FontWeight.w600),
                      ),
                      Container(
                        height: 4,
                      ),
                      const Text(
                        "Company Description",
                        style: TextStyle(
                            fontWeight: FontWeight.w300, fontSize: 12),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(vertical: 12),
          ),
          Container(
              margin: const EdgeInsets.symmetric(vertical: 4),
              child: const Text(
                'GENERAL',
                style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: AppColors.darkGray,
                    fontSize: 12),
              )),
          _itemSettings('Account', Icons.person, () {}),
          _itemSettings('Notifications', Icons.notifications, () {}),
          _itemSettings('About', Icons.question_mark_outlined, () {}),
          _itemSettings('Logout', Icons.logout, () {
            FirebaseAuth.instance.signOut();
          })
        ],
      ),
    ));
  }

  _itemSettings(final String title, final IconData icon, final Function onTap) {
    return GestureDetector(
      onTap: () => onTap(),
      child: Container(
        decoration: BoxDecoration(),
        margin: const EdgeInsets.only(top: 8),
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.symmetric(vertical: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Icon(
                        icon,
                        size: 20,
                      ),
                      Container(
                        width: 12,
                      ),
                      Text(title),
                    ],
                  ),
                  const Icon(
                    Icons.arrow_forward_ios_rounded,
                    size: 12,
                  )
                ],
              ),
            ),
            const Divider(
              color: AppColors.gray,
            )
          ],
        ),
      ),
    );
  }
}
