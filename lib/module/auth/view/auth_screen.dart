import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:svt_ppm/module/auth/cubit/auth_cubit.dart';
import 'package:svt_ppm/module/auth/view/login_screen.dart';
import 'package:svt_ppm/module/auth/view/otp_verification_screen.dart';
import 'package:svt_ppm/utils/constant/app_image.dart';
import 'package:svt_ppm/utils/widgets/custom_error_toast.dart';
import 'package:svt_ppm/utils/widgets/curved_glow_painter.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({super.key});
  @override
  Widget build(BuildContext context) {
    StepperCubit stepperCubit = BlocProvider.of<StepperCubit>(context);
    AuthCubit authCubit = BlocProvider.of<AuthCubit>(context);
    TextEditingController numberController = TextEditingController();

    Widget getStepText(int step) {
      switch (step) {
        case 0:
          return LoginScreen(
            loginOnTap: () {
              if (numberController.text.isEmpty) {
                customErrorToast(
                  context,
                  text: 'Please enter your mobile number',
                );
                return;
              }
              authCubit.checkMember(context, number: numberController.text);
            },
            numberController: numberController,
          );
        case 1:
          return OtpVerificationScreen(number: numberController.text);

        default:
          return Container();
      }
    }

    stepperCubit.init();
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [
            Stack(
              children: [
                CustomPaint(
                  size: Size(double.infinity, 250),
                  painter: CurvedGlowPainter(),
                ),

                Positioned(
                  right: 0,
                  left: 0,
                  top: 30,

                  child: Image.asset(AppLogo.logoWithOutBG, height: 150),
                ),
              ],
            ),

            BlocBuilder<StepperCubit, int>(
              builder: (context, currentStep) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: getStepText(currentStep),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
