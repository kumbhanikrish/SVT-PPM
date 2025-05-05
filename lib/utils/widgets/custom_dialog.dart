import 'package:flutter/material.dart';
import 'package:svt_ppm/utils/theme/colors.dart';
import 'package:svt_ppm/utils/widgets/custom_app_bar.dart';
import 'package:svt_ppm/utils/widgets/custom_button.dart';

customDialog(
  BuildContext context, {
  required String title,
  required Widget child,
}) {
  return showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) {
      return Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(12),
                topRight: Radius.circular(12),
              ),
              child: SizedBox(
                height: 40,
                child: CustomAppBar(
                  title: title,
                  fontSize: 12,
                  bottom: PreferredSize(
                    preferredSize: const Size.fromHeight(1),
                    child: Container(
                      color: AppColor.themePrimaryColor,
                      height: 0.5,
                      margin: const EdgeInsets.symmetric(horizontal: 24),
                    ),
                  ),
                  leading: CustomIconButton(
                    icon: Icons.close,
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
              ),
            ),
            Padding(padding: const EdgeInsets.all(24), child: child),
          ],
        ),
      );
    },
  );
}
