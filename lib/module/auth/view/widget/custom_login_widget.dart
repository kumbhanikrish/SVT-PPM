import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:svt_ppm/utils/constant/app_image.dart';
import 'package:svt_ppm/utils/theme/colors.dart';
import 'package:svt_ppm/utils/widgets/custom_text.dart';

customSignUpWith() {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 32),
    child: Row(
      children: [
        Expanded(
          child: Divider(thickness: 1, color: AppColor.themePrimaryColor),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: CustomText(
            text: 'Sing in with',
            fontSize: 12,
            color: AppColor.hintColor,
            fontWeight: FontWeight.w500,
          ),
        ),
        Expanded(
          child: Divider(thickness: 1, color: AppColor.themePrimaryColor),
        ),
      ],
    ),
  );
}

customGoogleAndAppleLogin({
  required void Function() googleOnTap,
  required void Function() appleOnTap,
}) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: <Widget>[
      InkWell(
        onTap: googleOnTap,
        child: SvgPicture.asset(AppImage.googleImage),
      ),
      Gap(16),
      InkWell(onTap: appleOnTap, child: SvgPicture.asset(AppImage.appleImage)),
    ],
  );
}
