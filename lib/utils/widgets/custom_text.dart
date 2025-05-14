import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:svt_ppm/utils/theme/colors.dart';

class CustomText extends StatelessWidget {
  final String text;
  final double fontSize;
  final FontWeight fontWeight;
  final Color? color;
  final TextAlign textAlign;
  final int? maxLines;
  final bool overflow;

  const CustomText({
    super.key,
    required this.text,
    this.fontSize = 16,
    this.fontWeight = FontWeight.w400,
    this.color,
    this.textAlign = TextAlign.left,
    this.maxLines,
    this.overflow = false,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontSize: fontSize,
        fontWeight: fontWeight,
        color: color ?? AppColor.themePrimaryColor,
        fontFamily: 'DM Sans',
      ),
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: overflow == true ? TextOverflow.ellipsis : TextOverflow.visible,
    );
  }
}

class CustomTitleName extends StatelessWidget {
  final String title;
  final String text;
  final bool icon;
  final double? fontSize;
  final String? image;

  const CustomTitleName({
    super.key,
    required this.title,
    required this.text,
    this.image,
    this.fontSize,
    this.icon = false,
  });
  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        if (icon == true) ...[
          SvgPicture.asset(image ?? ''),
        ] else ...[
          CustomText(text: title, fontSize: fontSize ?? 10),
          CustomText(text: ':', fontSize: fontSize ?? 10),
        ],
        const Gap(2),

        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(top: 1),
            child: CustomText(
              text: text,
              color: AppColor.hintColor,
              fontSize: fontSize ?? 10,
              overflow: true,
            ),
          ),
        ),
      ],
    );
  }
}
