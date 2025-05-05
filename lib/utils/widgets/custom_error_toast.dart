import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:flutter/material.dart';

customToast(
  BuildContext context, {
  required String text,
  required AnimatedSnackBarType animatedSnackBarType,
}) {
  return AnimatedSnackBar.material(
    text,
    type: animatedSnackBarType,
    mobileSnackBarPosition: MobileSnackBarPosition.top,
    desktopSnackBarPosition: DesktopSnackBarPosition.bottomLeft,
    snackBarStrategy: RemoveSnackBarStrategy(),
    duration: const Duration(seconds: 2),
  ).show(context);
}
