import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:svt_ppm/utils/constant/app_page.dart';
import 'package:svt_ppm/utils/widgets/custom_app_bar.dart';
import 'package:svt_ppm/utils/widgets/custom_button.dart';

class SelectionScreen extends StatelessWidget {
  final dynamic arguments;
  const SelectionScreen({super.key, this.arguments});
  @override
  Widget build(BuildContext context) {
    bool addMember = arguments['addMember'];
    return Scaffold(
      appBar: CustomAppBar(title: 'Select User Type', actions: []),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            CustomButton(
              text: addMember ? 'New Member' : 'New Register',
              onTap: () {
                Navigator.pushNamed(
                  context,
                  AppPage.signupScreen,
                  arguments: {'old': false, 'addMember': addMember},
                );
              },
            ),

            // Container(
            //   width: 200,
            //   decoration: BoxDecoration(
            //     color: AppColor.themePrimaryColor,
            //     borderRadius: BorderRadius.circular(12),
            //   ),
            //   child: InkWell(
            //     onTap: () {
            //       Navigator.pushNamed(
            //         context,
            //         AppPage.signupScreen,
            //         arguments: {'old': false, 'addMember': addMember},
            //       );
            //     },
            //     child: Center(
            //       child: CustomText(
            //         text: addMember ? 'New Member' : 'New Register',
            //         color: AppColor.whiteColor,
            //         fontSize: 18,
            //         fontWeight: FontWeight.w600,
            //       ),
            //     ),
            //   ),
            // ),
            Gap(20),

            CustomButton(
              text: addMember ? 'Old Member' : 'Old Register',
              onTap: () {
                Navigator.pushNamed(
                  context,
                  AppPage.signupScreen,
                  arguments: {'old': true, 'addMember': addMember},
                );
              },
            ),
            // Container(
            //   width: 200,
            //   decoration: BoxDecoration(
            //     color: AppColor.themePrimaryColor,
            //     borderRadius: BorderRadius.circular(12),
            //   ),
            //   child: InkWell(
            //     onTap: () {

            //     },
            //     child: Padding(
            //       padding: const EdgeInsets.all(8.0),
            //       child: Center(
            //         child: CustomText(
            //           text:
            //           color: AppColor.whiteColor,
            //           fontSize: 18,
            //           fontWeight: FontWeight.w600,
            //         ),
            //       ),
            //     ),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
