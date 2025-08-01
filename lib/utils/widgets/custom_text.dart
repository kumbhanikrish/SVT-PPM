import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
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
  final FontWeight? fontWeight;
  final String? image;
  final Color? color;
  final Color? textColor;

  const CustomTitleName({
    super.key,
    required this.title,
    required this.text,
    this.image,
    this.color,
    this.fontSize,
    this.textColor,
    this.fontWeight,
    this.icon = false,
  });
  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        if (icon == true) ...[
          SvgPicture.asset(image ?? ''),
          Gap(5),
        ] else ...[
          CustomText(
            text: title,
            fontSize: fontSize ?? 10,
            fontWeight: fontWeight ?? FontWeight.w400,
            color: color,
          ),
          if (title.isNotEmpty) ...[
            CustomText(text: ':', fontSize: fontSize ?? 10, color: color),
          ],
        ],
        const Gap(2),

        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(top: 1),
            child: CustomText(
              text: text,
              color: textColor ?? AppColor.hintColor,
              fontSize: fontSize ?? 10,
              overflow: true,
              fontWeight: fontWeight ?? FontWeight.w400,
            ),
          ),
        ),
      ],
    );
  }
}

class CustomEmpty extends StatelessWidget {
  const CustomEmpty({super.key});
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Center(
        child: CustomText(
          text: 'Not Found!!!',
          fontSize: 12,
          fontWeight: FontWeight.w500,
          color: AppColor.subTitleColor,
        ),
      ),
    );
  }
}

class CustomHTMLText extends StatelessWidget {
  final String text;
  final double fontSize;
  final FontWeight fontWeight;
  final Color? color;
  final TextAlign textAlign;
  final int? maxLines;
  final bool overflow;

  const CustomHTMLText({
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
    return Html(
      data: text.trim(),
      style: {
        "html": Style(margin: Margins.zero, padding: HtmlPaddings.zero),
        "body": Style(
          fontSize: FontSize(fontSize),
          fontWeight: fontWeight,
          color: color ?? AppColor.themePrimaryColor,
          fontFamily: 'DM Sans',
          textAlign: textAlign,
          maxLines: maxLines,
          padding: HtmlPaddings.zero,
          margin: Margins.zero,
          textOverflow: overflow ? TextOverflow.ellipsis : TextOverflow.visible,
        ),
        "*": Style(margin: Margins.zero, padding: HtmlPaddings.zero),
      },
    );
  }
}
