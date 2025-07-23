import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

import 'package:pinput/pinput.dart';
import 'package:svt_ppm/module/auth/cubit/auth_cubit.dart';
import 'package:svt_ppm/utils/theme/colors.dart';
import 'package:svt_ppm/utils/widgets/custom_button.dart';
import 'package:svt_ppm/utils/widgets/custom_text.dart';

class OtpVerificationScreen extends StatelessWidget {
  final String number;
  OtpVerificationScreen({super.key, required this.number});
  final TextEditingController pinController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    AuthCubit authCubit = BlocProvider.of<AuthCubit>(context);

    final defaultPinTheme = PinTheme(
      width: 50,
      height: 50,

      textStyle: TextStyle(
        fontSize: 16,
        color: AppColor.themePrimaryColor,
        fontWeight: FontWeight.w600,
      ),
      decoration: BoxDecoration(
        color: AppColor.fillColor,
        borderRadius: BorderRadius.circular(12),
      ),
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const CustomText(
          text: 'Verify your mobile no.',
          fontSize: 20,
          fontWeight: FontWeight.w600,
        ),
        CustomText(
          text: 'Please enter the 6 digit code sent to your mobile no.',
          fontSize: 12,
          color: AppColor.hintColor,
          fontWeight: FontWeight.w500,
        ),
        const Gap(26),

        Center(
          child: Pinput(
            controller: pinController,
            length: 4,
            animationCurve: Curves.easeInOut,
            defaultPinTheme: defaultPinTheme,
          ),
        ),
        const Gap(16),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomText(
              text: "Didn't receive code?",
              color: AppColor.hintColor,
              fontWeight: FontWeight.w600,
              fontSize: 12,
            ),
            const Gap(5),
            InkWell(
              onTap: () {
                authCubit.sendOtp(context, number: number, login: false);
              },
              child: CustomText(
                text: 'Resend code',
                fontWeight: FontWeight.w600,
                fontSize: 12,
                color: AppColor.themePrimaryColor,
              ),
            ),
          ],
        ),
        const Gap(30),
        CustomButton(
          text: 'Verify OTP',
          onTap: () {
            authCubit.verifyOtp(
              context,
              number: number,
              otp: pinController.text,
            );
          },
        ),
      ],
    );
  }
}
