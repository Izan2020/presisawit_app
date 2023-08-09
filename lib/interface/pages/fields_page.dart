import 'package:flutter/material.dart';
import 'package:presisawit_app/core/constants/enum.dart';
import 'package:presisawit_app/core/providers/fields_provider.dart';
import 'package:presisawit_app/interface/theme/app_colors.dart';
import 'package:presisawit_app/interface/widgets/items/fields_item.dart';
import 'package:provider/provider.dart';

class FieldsScreen extends StatefulWidget {
  const FieldsScreen({super.key});

  @override
  State<FieldsScreen> createState() => _FieldsScreenState();
}

class _FieldsScreenState extends State<FieldsScreen> {
  @override
  Widget build(BuildContext context) {
    final fieldsProvider = context.watch<FieldsProvider>();
    final listOfFields = fieldsProvider.listOfFields;
    final listOfFieldsState = fieldsProvider.listOfFieldsState;
    return SafeArea(
      child: Container(
        margin: const EdgeInsets.all(25),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Perkebunan',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700),
                ),
                GestureDetector(
                  onTap: () {
                    showModalBottomSheet(
                        shape: const RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(22))),
                        context: context,
                        builder: (builder) {
                          return modalBottomSheetManage();
                        });
                  },
                  child: const Text(
                    'Manage',
                    style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        color: AppColors.primaryColor),
                  ),
                ),
              ],
            ),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 12),
              child: const Divider(
                color: AppColors.gray,
              ),
            ),
            if (listOfFieldsState == ServiceState.loading)
              const Center(
                child: CircularProgressIndicator(
                  color: AppColors.gray,
                ),
              ),
            if (listOfFieldsState == ServiceState.error)
              const Center(
                  child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.error),
                  Text("Terjadi Kesalahan Server"),
                ],
              )),
            if (listOfFieldsState == ServiceState.success)
              Container(
                decoration: const BoxDecoration(
                  color: AppColors.lightGray,
                  borderRadius: BorderRadius.all(Radius.circular(12)),
                ),
                child: ListView.builder(
                    physics: const ClampingScrollPhysics(), // Add this line
                    shrinkWrap: true,
                    itemCount: listOfFields?.length,
                    itemBuilder: ((context, index) {
                      return FieldItem(field: listOfFields![index]);
                    })),
              )
          ],
        ),
      ),
    );
  }

  Widget modalBottomSheetManage() {
    return Container(
      margin: const EdgeInsets.all(19),
      height: double.maxFinite,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Manage',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700),
              ),
              IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(Icons.close_rounded))
            ],
          ),
        ],
      ),
    );
  }
}
