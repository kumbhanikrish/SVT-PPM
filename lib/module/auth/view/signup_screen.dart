import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:sizer/sizer.dart';
import 'package:svt_ppm/module/auth/cubit/auth_cubit.dart';
import 'package:svt_ppm/module/auth/view/auth_screen.dart';
import 'package:svt_ppm/module/auth/view/widget/custom_login_widget.dart';
import 'package:svt_ppm/utils/constant/app_image.dart';
import 'package:svt_ppm/utils/constant/app_page.dart';
import 'package:svt_ppm/utils/enum/enums.dart';
import 'package:svt_ppm/utils/theme/colors.dart';
import 'package:svt_ppm/utils/widgets/custom_button.dart';
import 'package:svt_ppm/utils/widgets/custom_radio_list_tile.dart';
import 'package:svt_ppm/utils/widgets/custom_text.dart';
import 'package:svt_ppm/utils/widgets/custom_textfield.dart';

class SignupScreen extends StatelessWidget {
  final dynamic data;
  const SignupScreen({super.key, this.data});
  @override
  Widget build(BuildContext context) {
    bool old = data['old'];

    TextEditingController firstNameController = TextEditingController();

    StepperCubit stepperCubit = BlocProvider.of<StepperCubit>(context);
    RadioCubit radioCubit = BlocProvider.of<RadioCubit>(context);
    ImageUploadCubit imageUploadCubit = BlocProvider.of<ImageUploadCubit>(
      context,
    );

    stepperCubit.init();
    radioCubit.init();
    imageUploadCubit.removeImage();
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,

        children: <Widget>[
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

                child: Image.asset(AppLogo.splashLogo, height: 150),
              ),

              Padding(
                padding: const EdgeInsets.only(top: 30),
                child: CustomIconButton(
                  icon: Icons.arrow_back_rounded,
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ),
            ],
          ),

          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    CustomText(
                      text: 'New Register',
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
                    Gap(8),
                    CustomText(
                      text: 'Please enter your Details.',
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: AppColor.hintColor,
                    ),
                    Gap(30),
                    CustomTextField(
                      hintText: 'Enter Your Name',
                      labelText: 'First Name',
                      controller: firstNameController,
                    ),
                    Gap(20),
                    CustomTextField(
                      hintText: 'Enter Middle Name',
                      labelText: 'Middle Name',
                      controller: firstNameController,
                    ),
                    Gap(20),
                    CustomTextField(
                      hintText: 'Enter Last Name',
                      labelText: 'Last Name',
                      controller: firstNameController,
                    ),
                    Gap(20),
                    CustomTextField(
                      hintText: 'Enter Mobile Number',
                      labelText: 'Mobile Number',
                      controller: firstNameController,
                    ),
                    Gap(20),
                    CustomTextField(
                      hintText: 'Enter Email',
                      labelText: 'Email',
                      controller: firstNameController,
                    ),
                    Gap(20),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomText(
                          text: 'Gender',
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                        ),
                        Gap(10),
                        BlocBuilder<RadioCubit, UserType>(
                          builder: (context, selectedType) {
                            return Row(
                              children: <Widget>[
                                Expanded(
                                  child: customRadio(
                                    buttonImage:
                                        selectedType == UserType.male
                                            ? AppImage.radioButton
                                            : AppImage.circle,
                                    genderIcon: AppImage.male,
                                    onTap: () {
                                      radioCubit.selectUserType(UserType.male);
                                    },
                                    title: 'Male',
                                  ),
                                ),
                                Gap(10),
                                Expanded(
                                  child: customRadio(
                                    buttonImage:
                                        selectedType == UserType.female
                                            ? AppImage.radioButton
                                            : AppImage.circle,
                                    genderIcon: AppImage.female,
                                    onTap: () {
                                      radioCubit.selectUserType(
                                        UserType.female,
                                      );
                                    },
                                    title: 'Female',
                                  ),
                                ),
                              ],
                            );
                          },
                        ),
                        Gap(10),
                      ],
                    ),
                    Gap(20),
                    CustomTextField(
                      hintText: 'Enter Village Name',
                      labelText: 'Village Name',
                      controller: firstNameController,
                    ),
                    if (old == true) ...[
                      Gap(20),
                      CustomTextField(
                        hintText: 'Enter Village Name',
                        labelText: 'Enter Old Member Number',
                        controller: firstNameController,
                      ),
                    ],
                    Gap(20),

                    Stack(
                      clipBehavior: Clip.none,
                      children: [
                        BlocBuilder<ImageUploadCubit, File?>(
                          builder: (context, imageFile) {
                            return InkWell(
                              borderRadius: BorderRadius.circular(12),

                              onTap: () {
                                if (imageFile == null) {
                                  imageUploadCubit.pickImage();
                                }
                              },
                              child: Container(
                                height: 25.h,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: AppColor.themePrimaryColor,
                                    width: 1,
                                  ),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child:
                                    imageFile == null
                                        ? Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: <Widget>[
                                            SvgPicture.asset(
                                              AppImage.uploadImage,
                                            ),
                                            Gap(10),
                                            const CustomText(
                                              text: 'Upload ID Proof',
                                              fontSize: 12,
                                            ),
                                          ],
                                        )
                                        : Stack(
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.all(20),
                                              child: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(12),
                                                child: Image.file(
                                                  imageFile,
                                                  width: 100.w,
                                                  fit: BoxFit.fill,
                                                ),
                                              ),
                                            ),
                                            Positioned(
                                              top: 8,
                                              right: 8,
                                              child: InkWell(
                                                onTap: () {
                                                  imageUploadCubit
                                                      .removeImage();
                                                },
                                                child: const CircleAvatar(
                                                  radius: 14,
                                                  backgroundColor:
                                                      Colors.black54,
                                                  child: Icon(
                                                    Icons.close,
                                                    size: 16,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                              ),
                            );
                          },
                        ),
                        Positioned(
                          top: -10,
                          left: 20,
                          child: Container(
                            decoration: BoxDecoration(
                              color: AppColor.whiteColor,
                            ),
                            padding: EdgeInsets.symmetric(horizontal: 2),
                            child: CustomText(
                              text:
                                  old == true ? 'Old Member Card' : 'ID Proof',
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Gap(40),

                    CustomButton(text: 'Submit', onTap: () {}),
                    Gap(32),
                    customSignUpWith(),
                    Gap(25),

                    customGoogleAndAppleLogin(
                      googleOnTap: () {},
                      appleOnTap: () {},
                    ),
                    Gap(25),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        CustomText(
                          text: 'Already have an account?',
                          color: AppColor.hintColor,
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.pushNamedAndRemoveUntil(
                              context,
                              AppPage.authScreen,
                              (route) => false,
                            );
                          },
                          child: CustomText(
                            text: ' Sign In',
                            color: AppColor.themePrimaryColor,
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    Gap(4.h),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
