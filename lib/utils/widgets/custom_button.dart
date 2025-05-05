import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:svt_ppm/utils/theme/colors.dart';
import 'package:svt_ppm/utils/widgets/custom_text.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final BorderRadiusGeometry? borderRadius;
  final Color? backgroundColor;

  final Color? textColor;
  final Color? borderColor;
  final void Function() onTap;
  final EdgeInsetsGeometry? padding;
  final FontWeight? fontWeight;
  final double? fontSize;
  const CustomButton({
    super.key,
    required this.text,
    required this.onTap,
    this.borderRadius,
    this.borderColor,
    this.textColor,
    this.backgroundColor,
    this.padding,
    this.fontWeight,
    this.fontSize,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: backgroundColor ?? AppColor.themePrimaryColor2,
        border: Border.all(
          color: borderColor ?? AppColor.themePrimaryColor2,
          width: 1,
        ),
        borderRadius: borderRadius ?? BorderRadius.circular(10),
      ),
      child: InkWell(
        splashColor: AppColor.themePrimaryColor2,
        highlightColor: AppColor.themePrimaryColor2,
        borderRadius: BorderRadius.circular(10),
        onTap: onTap,
        child: Padding(
          padding: padding ?? const EdgeInsets.symmetric(vertical: 12.5),
          child: Center(
            child: CustomText(
              text: text,
              color: textColor ?? AppColor.whiteColor,
              fontWeight: fontWeight ?? FontWeight.w500,
              fontSize: fontSize ?? 12,
            ),
          ),
        ),
      ),
    );
  }
}

class CustomIconTextButton extends StatelessWidget {
  final String text;
  final String image;
  final BorderRadiusGeometry? borderRadius;

  final Color? textColor;
  final Color? borderColor;
  final void Function() onTap;
  final EdgeInsetsGeometry? padding;
  const CustomIconTextButton({
    super.key,
    required this.text,
    required this.onTap,
    this.borderRadius,
    this.borderColor,
    this.textColor,
    this.padding,
    required this.image,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        border: Border.all(
          color: borderColor ?? AppColor.themePrimaryColor2,
          width: 1,
        ),
        borderRadius: borderRadius ?? BorderRadius.circular(10),
      ),
      child: InkWell(
        splashColor: AppColor.themePrimaryColor2,
        highlightColor: AppColor.themePrimaryColor2,
        borderRadius: BorderRadius.circular(10),
        onTap: onTap,
        child: Padding(
          padding: padding ?? const EdgeInsets.symmetric(vertical: 12.5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(image),
              Gap(10),
              CustomText(
                text: text,
                color: textColor ?? AppColor.blackColor,
                fontWeight: FontWeight.w400,
                fontSize: 12,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CustomTextButton extends StatelessWidget {
  final String text;
  final Color? color;
  final double fontSize;
  final void Function() onPressed;
  const CustomTextButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.color,
    this.fontSize = 12,
  });
  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      child: CustomText(text: text, color: color, fontSize: fontSize),
    );
  }
}

class CustomIconButton extends StatelessWidget {
  final IconData icon;
  final void Function() onPressed;
  final Color? color;
  final double? size;
  const CustomIconButton({
    super.key,
    required this.icon,
    this.color,
    required this.onPressed,
    this.size,
  });
  @override
  Widget build(BuildContext context) {
    return IconButton(
      color: color ?? AppColor.themePrimaryColor2,
      onPressed: onPressed,
      icon: Icon(icon, size: size),
    );
  }
}
