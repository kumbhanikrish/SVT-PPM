import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:svt_ppm/utils/theme/colors.dart';
import 'package:svt_ppm/utils/widgets/custom_text.dart';

customRadio({
  required String buttonImage,

  required String genderIcon,
  required String title,
  required void Function() onTap,
  Widget? child,
}) {
  return Container(
    decoration: BoxDecoration(
      color: AppColor.whiteColor,
      border: Border.all(color: AppColor.themePrimaryColor, width: 1),
      borderRadius: BorderRadius.circular(10),
    ),
    child: InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(13),
        child: Column(
          children: [
            Row(
              children: <Widget>[
                SvgPicture.asset(
                  buttonImage,
                  color: AppColor.themePrimaryColor,
                ),
                if (genderIcon != '') ...[
                  Gap(13),
                  SvgPicture.asset(
                    genderIcon,
                    color: AppColor.themeSecondaryColor,
                  ),
                ],
                Gap(10),
                CustomText(
                  text: title,
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
              ],
            ),
            child ?? Container(),
          ],
        ),
      ),
    ),
  );
}
