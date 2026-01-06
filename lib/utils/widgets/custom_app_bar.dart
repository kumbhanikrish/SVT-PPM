import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:svt_ppm/utils/constant/app_image.dart';
import 'package:svt_ppm/utils/theme/colors.dart';
import 'package:svt_ppm/utils/widgets/custom_text.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final Widget? leading;
  final List<Widget>? actions;
  final PreferredSizeWidget? bottom;
  final double? fontSize;
  final bool? centerTitle;
  final void Function()? notificationOnTap;
  final Radius? bottomRadius;
  final Color? shadowColor;
  final double? blurRadius;

  const CustomAppBar({
    super.key,
    required this.title,
    this.leading,
    this.blurRadius,
    this.actions,
    this.bottom,
    this.fontSize,
    this.notificationOnTap,
    this.centerTitle,
    this.bottomRadius,
    this.shadowColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: shadowColor ?? Colors.black.withOpacity(0.2),
            blurRadius: 3,
            spreadRadius: 2,
            offset: const Offset(0, 4),
          ),
        ],
        borderRadius: BorderRadius.only(
          bottomLeft: bottomRadius ?? const Radius.circular(15),
          bottomRight: bottomRadius ?? const Radius.circular(15),
        ),
        color: AppColor.themePrimaryColor,
      ),
      child: AppBar(
        backgroundColor: AppColor.transparentColor,
        elevation: 0,
        title: CustomText(
          text: title,
          color: AppColor.whiteColor,
          fontWeight: FontWeight.w600,
          fontSize: fontSize ?? 18,
        ),
        bottom: bottom,

        actions:
            actions ??
            [
              InkWell(
                onTap: notificationOnTap,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: SvgPicture.asset(
                    AppImage.notification,
                    colorFilter: const ColorFilter.mode(
                      AppColor.whiteColor,
                      BlendMode.srcIn,
                    ),
                  ),
                ),
              ),
            ],
        automaticallyImplyLeading: true,
        centerTitle: centerTitle ?? true,
        iconTheme: const IconThemeData(color: AppColor.whiteColor),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
