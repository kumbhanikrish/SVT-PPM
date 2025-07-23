import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:svt_ppm/utils/constant/app_image.dart';
import 'package:svt_ppm/utils/theme/colors.dart';
import 'package:svt_ppm/utils/widgets/custom_text.dart';

class CustomFieldBox extends StatelessWidget {
  final List<Widget> children;
  final String title;
  final bool addButton;
  final double fontSize;
  final void Function()? addOnTap;
  final EdgeInsetsGeometry? padding;
  const CustomFieldBox({
    super.key,
    required this.children,
    this.title = '',
    this.addButton = false,
    this.fontSize = 14,
    this.addOnTap,
    this.padding,
  });
  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
            border: Border.all(color: AppColor.themePrimaryColor, width: 1),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Padding(
            padding: padding ?? const EdgeInsets.all(16),
            child: Column(children: children),
          ),
        ),
        Positioned(
          top: -10,
          left: 20,
          child: Container(
            decoration: BoxDecoration(color: AppColor.whiteColor),
            padding: EdgeInsets.symmetric(horizontal: 2),
            child: CustomText(
              text: title,
              fontSize: fontSize,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        if (addButton) ...[
          Positioned(
            top: -20,
            right: 10,
            child: InkWell(
              onTap: addOnTap,
              child: SvgPicture.asset(AppImage.addMember),
            ),
          ),
        ],
      ],
    );
  }
}
