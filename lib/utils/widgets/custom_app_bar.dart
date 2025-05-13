import 'package:flutter/material.dart';
import 'package:svt_ppm/utils/constant/app_image.dart';
import 'package:svt_ppm/utils/theme/colors.dart';
import 'package:svt_ppm/utils/widgets/custom_text.dart';

// class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
//   final String title;
//   final Widget? leading;
//   final List<Widget>? actions;
//   final PreferredSizeWidget? bottom;
//   final double? fontSize;
//   final bool? centerTitle;
//   const CustomAppBar({
//     super.key,
//     required this.title,
//     this.leading,
//     this.actions,
//     this.bottom,
//     this.fontSize,
//     this.centerTitle,
//   });
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       decoration: BoxDecoration(
//         border: Border(
//           bottom: BorderSide(width: 0.1, color: AppColor.whiteColor),
//         ),
//       ),
//       child: AppBar(
//         title: CustomText(
//           text: title,
//           color: AppColor.themePrimaryColor,
//           fontWeight: FontWeight.w600,
//           fontSize: fontSize ?? 18,
//         ),
//         bottom: bottom,
//         leading: leading,
//         actions: actions,
//         automaticallyImplyLeading: true,
//         centerTitle: centerTitle ?? true,
//         iconTheme: IconThemeData(color: AppColor.themePrimaryColor),
//       ),
//     );
//   }

//   @override
//   Size get preferredSize => const Size.fromHeight(kToolbarHeight);
// }
class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final Widget? leading;
  final List<Widget>? actions;
  final PreferredSizeWidget? bottom;
  final double? fontSize;
  final bool? centerTitle;
  const CustomAppBar({
    super.key,
    required this.title,
    this.leading,
    this.actions,
    this.bottom,
    this.fontSize,
    this.centerTitle,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: AppColor.themePrimaryColor,
            blurRadius: 3,
            spreadRadius: 2,
            offset: Offset(0, 4),
          ),
        ],
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(15),
          bottomRight: Radius.circular(15),
        ),
        color: AppColor.themeSecondaryColor,
      ),
      child: AppBar(
        backgroundColor: AppColor.transparentColor,
        title: CustomText(
          text: title,
          color: AppColor.themePrimaryColor,
          fontWeight: FontWeight.w600,
          fontSize: fontSize ?? 18,
        ),
        bottom: bottom,
        leading:
            leading ??
            Padding(
              padding: const EdgeInsets.only(left: 16, bottom: 10),
              child: Image.asset(AppLogo.smallLogo),
            ),
        actions: actions,
        automaticallyImplyLeading: true,
        centerTitle: centerTitle ?? true,
        iconTheme: IconThemeData(color: AppColor.themePrimaryColor),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
