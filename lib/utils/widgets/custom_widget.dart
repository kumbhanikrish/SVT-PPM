import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:svt_ppm/utils/constant/app_image.dart';
import 'package:svt_ppm/utils/theme/colors.dart';
import 'package:svt_ppm/utils/widgets/custom_text.dart';

class CustomTitleSeeAllWidget extends StatelessWidget {
  final String title;
  final void Function() seeAllOnTap;
  const CustomTitleSeeAllWidget({
    super.key,
    required this.title,
    required this.seeAllOnTap,
  });
  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(
          child: Row(
            children: <Widget>[
              SvgPicture.asset(AppImage.calendar),
              Gap(10),
              CustomText(
                text: title,
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: AppColor.hintColor,
              ),
            ],
          ),
        ),
        InkWell(
          onTap: seeAllOnTap,
          child: CustomText(
            text: 'See All',
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: AppColor.themePrimaryColor,
          ),
        ),
      ],
    );
  }
}

class CustomDivider extends StatelessWidget {
  const CustomDivider({super.key});
  @override
  Widget build(BuildContext context) {
    return Divider(thickness: 1, color: AppColor.themeSecondaryColor);
  }
}
