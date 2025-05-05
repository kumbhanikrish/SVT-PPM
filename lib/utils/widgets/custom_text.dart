import 'package:flutter/material.dart';
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
  final double? width;

  const CustomTitleName({
    super.key,
    required this.title,
    required this.text,
    this.width,
  });
  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(
          width: width ?? 120,
          child: CustomText(
            text: title,
            fontWeight: FontWeight.w600,
            fontSize: 14,
          ),
        ),
        const CustomText(text: ':', fontWeight: FontWeight.w600, fontSize: 14),
        const Gap(5),
        Expanded(
          child: CustomText(
            text: text,
            color: AppColor.themePrimaryColor,
            fontSize: 12,
            overflow: true,
          ),
        ),
      ],
    );
  }
}
