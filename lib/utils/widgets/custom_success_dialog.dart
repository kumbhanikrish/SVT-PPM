import 'dart:developer';

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
  String? button2Text,
  VoidCallback? onTap,
  bool columnButton = false,
  bool showCloseIcon = false,
  bool  addMember = false,
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
              Row(
                children: [
                  CustomText(
                    text: title,
                    color: AppColor.themePrimaryColor,
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                  showCloseIcon
                      ? Expanded(
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: InkWell(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: Icon(
                              Icons.close,
                              color: AppColor.subTitleColor,
                            ),
                          ),
                        ),
                      )
                      : Container(),
                ],
              ),
              CustomText(
                text: subTitle,
                color: AppColor.subTitleColor,
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
              Gap(20),

              columnButton
                  ? Column(
                    children: [
                      CustomButton(
                        text: button2Text ?? 'Cancel',

                        padding: EdgeInsets.symmetric(vertical: 8),
                        fontSize: 14,
                        onTap:
                            cancelOnTap ??
                            () {
                              Navigator.pop(context);
                            },
                      ),
                      Gap(20),
                      CustomButton(
                        text: buttonText ,
                        fontSize: 14,
                        backgroundColor: AppColor.whiteColor,
                        borderColor: AppColor.dividerColor,

                        textColor: AppColor.themePrimaryColor,
                        padding: EdgeInsets.symmetric(vertical: 8),
                        onTap:
                            onTap ??
                            () {
                              Navigator.pop(context);
                            },
                      ),
                    ],
                  )
                  : Row(
                    children: [
                      Expanded(
                        child: CustomButton(
                          backgroundColor: AppColor.whiteColor,
                          borderColor: AppColor.dividerColor,
                          text: button2Text ?? 'Cancel',
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
