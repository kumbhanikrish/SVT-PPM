import 'package:flutter/material.dart';
import 'package:svt_ppm/utils/theme/colors.dart';
import 'package:svt_ppm/utils/widgets/custom_app_bar.dart';
import 'package:svt_ppm/utils/widgets/custom_button.dart';

customBottomSheet(
  BuildContext context, {
  required String title,
  required Widget child,
  required bool showButton,
  required void Function() buttonOnTap,
}) {
  return showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    useSafeArea: true,
    builder: (context) {
      return Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(12),
                topRight: Radius.circular(12),
              ),
              child: SizedBox(
                height: 60,
                child: CustomAppBar(
                  title: title,
                  shadowColor: AppColor.whiteColor,
                  bottomRadius: Radius.circular(0),
                  bottom: PreferredSize(
                    preferredSize: const Size.fromHeight(1),
                    child: Container(
                      color: AppColor.whiteColor,
                      height: 0.5,
                      margin: const EdgeInsets.symmetric(horizontal: 24),
                    ),
                  ),
                  actions: [],
                  leading: CustomIconButton(
                    icon: Icons.close,
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
              ),
            ),
            child,
            if (showButton) ...[
              Padding(
                padding: const EdgeInsets.all(16),
                child: CustomButton(text: 'Submit', onTap: buttonOnTap),
              ),
            ],
          ],
        ),
      );
    },
  );
}
