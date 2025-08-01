import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:svt_ppm/utils/constant/app_image.dart';
import 'package:svt_ppm/utils/theme/colors.dart';
import 'package:svt_ppm/utils/widgets/custom_text.dart';

class CustomTitleSeeAllWidget extends StatelessWidget {
  final String title;
  final String? image;
  final void Function() seeAllOnTap;
  final Widget? child;
  const CustomTitleSeeAllWidget({
    super.key,
    required this.title,
    required this.seeAllOnTap,
    this.child,
    this.image,
  });
  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(
          child: Row(
            children: <Widget>[
              if ((image ?? '').isNotEmpty) ...[
                SvgPicture.asset(image ?? AppImage.calendar),
                Gap(10),
              ],
              CustomText(
                text: title,

                fontWeight: FontWeight.w600,
                color: AppColor.hintColor,
              ),
            ],
          ),
        ),
        InkWell(
          onTap: seeAllOnTap,
          child:
              child ??
              CustomText(
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
  final double? height;
  const CustomDivider({super.key, this.height});
  @override
  Widget build(BuildContext context) {
    return Divider(
      thickness: 1,
      color: AppColor.themePrimaryColor.withOpacity(0.2),
      height: height,
    );
  }
}
