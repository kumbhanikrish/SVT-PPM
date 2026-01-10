import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:svt_ppm/utils/theme/colors.dart';
import 'package:svt_ppm/utils/widgets/custom_button.dart';
import 'package:svt_ppm/utils/widgets/custom_text.dart';

void showCustomDialog(
  BuildContext context, {
  required String title,
  required String subTitle,
  required String buttonText,
  VoidCallback? onTap,
  VoidCallback? cancelOnTap,
}) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        backgroundColor: AppColor.whiteColor,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomText(
                text: title,
                color: AppColor.themePrimaryColor,
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
              CustomText(
                text: subTitle,
                color: AppColor.subTitleColor,
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
              Gap(20),
              Row(
                children: [
                  Expanded(
                    child: CustomButton(
                      backgroundColor: AppColor.whiteColor,
                      borderColor: AppColor.dividerColor,
                      text: 'Cancel',
                      textColor: AppColor.dividerColor,
                      padding: EdgeInsets.symmetric(vertical: 8),
                      fontSize: 14,
                      onTap:
                          cancelOnTap ??
                          () {
                            Navigator.pop(context);
                          },
                    ),
                  ),
                  Gap(10),
                  Expanded(
                    child: CustomButton(
                      text: buttonText,
                      fontSize: 14,
                      padding: EdgeInsets.symmetric(vertical: 8),
                      onTap:
                          onTap ??
                          () {
                            Navigator.pop(context);
                          },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    },
  );
}
