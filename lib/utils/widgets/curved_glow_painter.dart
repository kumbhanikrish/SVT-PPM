import 'package:flutter/material.dart';
import 'package:svt_ppm/utils/theme/colors.dart';

class CurvedGlowPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final Path path =
        Path()
          ..lineTo(0, size.height * 0.65)
          ..quadraticBezierTo(
            size.width / 2,
            size.height,
            size.width,
            size.height * 0.65,
          )
          ..lineTo(size.width, 0)
          ..close();

    // Shadow simulation using blur & offset
    final Path shadowPath =
        Path()
          ..moveTo(0, size.height * 0.65)
          ..quadraticBezierTo(
            size.width / 2,
            size.height,
            size.width,
            size.height * 0.65,
          );

    final Paint shadowPaint =
        Paint()
          ..color =
              AppColor
                  .themePrimaryColor // Shadow color with opacity
          ..maskFilter = const MaskFilter.blur(
            BlurStyle.normal,
            2,
          ) // Blur radius for shadow
          ..style = PaintingStyle.stroke
          ..strokeWidth = 8;

    canvas.drawPath(shadowPath, shadowPaint); // Draw shadow first

    // Main filled shape
    final Paint fillPaint =
        Paint()
          ..color = AppColor.themeSecondaryColor
          ..style = PaintingStyle.fill;

    canvas.drawPath(path, fillPaint);

    // Bottom curve border (solid line)
    final Paint borderPaint =
        Paint()
          ..color =
              AppColor
                  .themePrimaryColor // Border color
          ..style = PaintingStyle.stroke
          ..strokeWidth = 4;

    canvas.drawPath(shadowPath, borderPaint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
