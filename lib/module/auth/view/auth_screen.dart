import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:svt_ppm/module/auth/cubit/auth_cubit.dart';
import 'package:svt_ppm/module/auth/view/login_screen.dart';
import 'package:svt_ppm/module/auth/view/otp_verification_screen.dart';
import 'package:svt_ppm/utils/constant/app_image.dart';
import 'package:svt_ppm/utils/theme/colors.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({super.key});
  @override
  Widget build(BuildContext context) {
    StepperCubit stepperCubit = BlocProvider.of<StepperCubit>(context);
    TextEditingController numberController = TextEditingController();

    Widget getStepText(int step) {
      switch (step) {
        case 0:
          return LoginScreen(
            loginOnTap: () {
              stepperCubit.nextStep(step: 1);
            },
            numberController: numberController,
          );
        case 1:
          return OtpVerificationScreen();

        default:
          return Container();
      }
    }

    stepperCubit.init();
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,

        children: [
          Stack(
            children: [
              CustomPaint(
                size: Size(double.infinity, 350),
                painter: CurvedGlowPainter(),
              ),

              Positioned(
                right: 0,
                left: 0,
                top: 30,

                child: Image.asset(AppLogo.splashLogo, height: 230),
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
    );
  }
}

class CurvedGlowPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final Path path =
        Path()
          ..lineTo(0, size.height * 0.65)
          ..quadraticBezierTo(
            size.width / 2,
            size.height,
            size.width,
            size.height * 0.65,
          )
          ..lineTo(size.width, 0)
          ..close();

    // Shadow simulation using blur & offset
    final Path shadowPath =
        Path()
          ..moveTo(0, size.height * 0.65)
          ..quadraticBezierTo(
            size.width / 2,
            size.height,
            size.width,
            size.height * 0.65,
          );

    final Paint shadowPaint =
        Paint()
          ..color =
              AppColor
                  .themePrimaryColor // Shadow color with opacity
          ..maskFilter = MaskFilter.blur(
            BlurStyle.normal,
            2,
          ) // Blur radius for shadow
          ..style = PaintingStyle.stroke
          ..strokeWidth = 8;

    canvas.drawPath(shadowPath, shadowPaint); // Draw shadow first

    // Main filled shape
    final Paint fillPaint =
        Paint()
          ..color = AppColor.themeSecondaryColor
          ..style = PaintingStyle.fill;

    canvas.drawPath(path, fillPaint);

    // Bottom curve border (solid line)
    final Paint borderPaint =
        Paint()
          ..color =
              AppColor
                  .themePrimaryColor // Border color
          ..style = PaintingStyle.stroke
          ..strokeWidth = 4;

    canvas.drawPath(shadowPath, borderPaint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
