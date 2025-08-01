import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:svt_ppm/utils/constant/app_page.dart';
import 'package:svt_ppm/utils/theme/colors.dart';
import 'package:svt_ppm/utils/widgets/custom_button.dart';
import 'package:svt_ppm/utils/widgets/custom_text.dart';
import 'package:svt_ppm/utils/widgets/custom_textfield.dart';

class LoginScreen extends StatelessWidget {
  final void Function() loginOnTap;
  final TextEditingController numberController;
  const LoginScreen({
    super.key,
    required this.loginOnTap,
    required this.numberController,
  });
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        CustomText(
          text: 'Welcome Back',
          fontSize: 20,
          fontWeight: FontWeight.w600,
        ),
        Gap(8),
        CustomText(
          text: 'Please sign in to your account.',
          fontSize: 12,
          fontWeight: FontWeight.w500,
          color: AppColor.hintColor,
        ),
        Gap(30),
        CustomTextField(
          hintText: 'Enter Mobile Number',
          labelText: 'Mobile Number',
          keyboardType: TextInputType.number,

          controller: numberController,
        ),
        Gap(40),
        CustomButton(text: 'Login with OTP', onTap: loginOnTap),
        Gap(32),
        // customSignUpWith(),
        // Gap(25),

        // customGoogleAndAppleLogin(googleOnTap: () {}, appleOnTap: () {}),
        // Gap(25),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            CustomText(
              text: 'Don’t have an account?',
              color: AppColor.hintColor,
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
            InkWell(
              onTap: () {
                Navigator.pushNamed(
                  context,
                  AppPage.selectionScreen,

                  arguments: {'addMember': false},
                );
              },
              child: CustomText(
                text: ' Sign up',
                color: AppColor.themePrimaryColor,
                fontSize: 12,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
