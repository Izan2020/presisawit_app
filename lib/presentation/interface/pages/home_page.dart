import 'package:flutter/material.dart';

import 'package:presisawit_app/presentation/interface/theme/app_colors.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        margin: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Halo, User',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700),
                ),
                IconButton(
                    onPressed: () {}, icon: const Icon(Icons.notifications))
              ],
            ),
            Container(height: 12),
            Container(
              height: 110,
              decoration: const BoxDecoration(
                  color: AppColors.primaryColor,
                  borderRadius: BorderRadius.all(Radius.circular(14))),
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      width: 70,
                      height: 70,
                      decoration: BoxDecoration(
                          color: AppColors.lightGray.withOpacity(0.4),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(200))),
                      child: const Icon(
                        Icons.assignment_turned_in_outlined,
                        size: 34,
                        color: AppColors.white,
                      ),
                    ),
                    Container(width: 12),
                    const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'Sekarang Saatnya',
                          style: TextStyle(
                              color: AppColors.white,
                              fontWeight: FontWeight.w300,
                              height: 0.6),
                        ),
                        Text(
                          'Panen Blok 6',
                          style: TextStyle(
                              color: AppColors.white,
                              fontSize: 22,
                              fontWeight: FontWeight.bold),
                        )
                      ],
                    )
                  ],
                ),
              ),
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
                    height: 80,
                    decoration: const BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                              blurRadius: 12,
                              spreadRadius: 0.2,
                              color: AppColors.gray)
                        ],
                        color: AppColors.white,
                        borderRadius: BorderRadius.all(Radius.circular(13))),
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 12),
                      child: const Row(
                        children: [
                          Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'TASKS TODAY',
                                style: TextStyle(
                                    color: AppColors.gray, fontSize: 11),
                              ),
                              Text(
                                '192',
                                style: TextStyle(
                                    fontWeight: FontWeight.w600, fontSize: 24),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Container(
                  width: 12,
                ),
                Flexible(
                  flex: 1,
                  child: Container(
                    height: 80,
                    decoration: const BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                              blurRadius: 12,
                              spreadRadius: 0.2,
                              color: AppColors.gray)
                        ],
                        color: AppColors.white,
                        borderRadius: BorderRadius.all(Radius.circular(13))),
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 12),
                      child: const Row(
                        children: [
                          Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'TASKS TODAY',
                                style: TextStyle(
                                    color: AppColors.gray, fontSize: 11),
                              ),
                              Text(
                                '192',
                                style: TextStyle(
                                    fontWeight: FontWeight.w600, fontSize: 24),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text(
                    'Recent Tasks',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  GestureDetector(
                    onTap: () {},
                    child: const Text(
                      'More',
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: AppColors.primaryColor),
                    ),
                  ),
                ],
              ),
            ),
            ListView.builder(
                physics: const ClampingScrollPhysics(), // Add this line
                shrinkWrap: true, // Add this line
                itemCount: 5,
                itemBuilder: (context, index) {
                  return Container(
                    margin: const EdgeInsets.symmetric(vertical: 3),
                    height: 64,
                    decoration: const BoxDecoration(
                        color: AppColors.lightGray,
                        borderRadius: BorderRadius.all(Radius.circular(8))),
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 12),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Row(
                            children: [
                              Container(
                                width: 42,
                                height: 42,
                                decoration: BoxDecoration(
                                    color: AppColors.green.withOpacity(0.4),
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(10))),
                                child: Icon(
                                  Icons.local_fire_department_rounded,
                                  color: AppColors.green,
                                ),
                              ),
                              Container(width: 8),
                              Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'HAMAS AZIZAN',
                                    style: TextStyle(
                                        color: AppColors.gray, fontSize: 10),
                                  ),
                                  Text(
                                    'Panen sawit di Blok 002',
                                    style:
                                        TextStyle(fontWeight: FontWeight.w600),
                                  ),
                                ],
                              )
                            ],
                          ),
                          Text('13:12')
                        ],
                      ),
                    ),
                  );
                })
          ],
        ),
      ),
    );
  }
}
