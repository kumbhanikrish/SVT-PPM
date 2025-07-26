import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:sizer/sizer.dart';
import 'package:svt_ppm/utils/theme/colors.dart';
import 'package:svt_ppm/utils/widgets/custom_app_bar.dart';
import 'package:svt_ppm/utils/widgets/custom_button.dart';
import 'package:svt_ppm/utils/widgets/custom_text.dart';
import 'package:svt_ppm/utils/widgets/custom_textfield.dart';

class KitDetailScreen extends StatelessWidget {
  KitDetailScreen({super.key});

  final TextEditingController kitNameController = TextEditingController();
  final TextEditingController userNameController = TextEditingController();
  final TextEditingController standerController = TextEditingController();
  final TextEditingController yearController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Kit', notificationOnTap: () {}),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomText(
              text: 'Kit Detail',
              fontSize: 20,
              fontWeight: FontWeight.w600,
            ),
            Gap(25),
            Stack(
              clipBehavior: Clip.none,
              children: [
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: AppColor.themePrimaryColor,
                      width: 1,
                    ),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      children: [
                        CustomTextField(
                          hintText: 'Kit Name',
                          labelText: '',
                          fillColor: AppColor.fillColor,
                          borderColor: AppColor.transparentColor,
                          controller: kitNameController,
                        ),
                        Gap(15),

                        CustomTextField(
                          hintText: 'User Name',
                          labelText: '',
                          fillColor: AppColor.fillColor,
                          borderColor: AppColor.transparentColor,
                          controller: userNameController,
                        ),
                        Gap(15),

                        CustomTextField(
                          hintText: 'Stander',
                          labelText: '',
                          fillColor: AppColor.fillColor,
                          borderColor: AppColor.transparentColor,
                          controller: standerController,
                        ),
                        Gap(15),
                        CustomTextField(
                          hintText: 'Year',
                          labelText: '',
                          fillColor: AppColor.fillColor,
                          borderColor: AppColor.transparentColor,
                          controller: yearController,
                        ),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  top: -10,
                  left: 20,
                  child: Container(
                    decoration: BoxDecoration(color: AppColor.whiteColor),
                    padding: EdgeInsets.symmetric(horizontal: 2),
                    child: CustomText(
                      text: 'User Kit Details',
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
            Gap(6.h),
            CustomButton(text: 'Submit', onTap: () {}),
          ],
        ),
      ),
    );
  }
}
