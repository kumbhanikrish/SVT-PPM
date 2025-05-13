import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:svt_ppm/utils/constant/app_page.dart';
import 'package:svt_ppm/utils/theme/colors.dart';
import 'package:svt_ppm/utils/widgets/custom_app_bar.dart';
import 'package:svt_ppm/utils/widgets/custom_text.dart';

class SelectionScreen extends StatelessWidget {
  const SelectionScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Select User Type'),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
        child: Column(
          children: <Widget>[
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: AppColor.themePrimaryColor,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: InkWell(
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      AppPage.signupScreen,
                      arguments: {'old': false},
                    );
                  },
                  child: Center(
                    child: CustomText(
                      text: 'New Register',
                      color: AppColor.whiteColor,
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ),
            Gap(20),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: AppColor.themePrimaryColor,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: InkWell(
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      AppPage.signupScreen,
                      arguments: {'old': true},
                    );
                  },
                  child: Center(
                    child: CustomText(
                      text: 'Old Register',
                      color: AppColor.whiteColor,
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
