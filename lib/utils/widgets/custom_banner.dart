import 'package:flutter/material.dart';
import 'package:svt_ppm/utils/widgets/custom_text.dart';

class CustomBanner extends StatelessWidget {
  final String text;
  final Color color;
  final Color? textColor;
  final double? fontSize;

  final FontWeight? fontWeight;
  final double? height;
  const CustomBanner({
    super.key,
    this.fontSize,
    this.textColor,
    this.height,
    this.fontWeight,
    required this.text,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Transform.rotate(
      angle: 45 * (3.14 / 180),
      child: Container(
        width: 100,
        height: height ?? 15,
        color: color,
        padding: const EdgeInsets.only(bottom: 1),
        alignment: Alignment.center,
        child: FittedBox(
          child: CustomText(
            text: text,
            color: textColor,
            fontSize: fontSize ?? 10,
            fontWeight: fontWeight ?? FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
