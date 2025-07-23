import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sizer/sizer.dart';
import 'package:svt_ppm/module/auth/cubit/auth_cubit.dart';
import 'package:svt_ppm/module/auth/view/auth_screen.dart';
import 'package:svt_ppm/module/auth/view/widget/custom_login_widget.dart';
import 'package:svt_ppm/module/profile/cubit/profile_cubit.dart';
import 'package:svt_ppm/utils/constant/app_image.dart';
import 'package:svt_ppm/utils/constant/app_page.dart';
import 'package:svt_ppm/utils/enum/enums.dart';
import 'package:svt_ppm/utils/theme/colors.dart';
import 'package:svt_ppm/utils/widgets/custom_app_bar.dart';
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
    bool addMember = data['addMember'];

    TextEditingController firstNameController = TextEditingController();
    TextEditingController middleNameController = TextEditingController();
    TextEditingController lastNameController = TextEditingController();
    TextEditingController mobileController = TextEditingController();
    TextEditingController emailController = TextEditingController();
    TextEditingController addressController = TextEditingController();
    TextEditingController oldMemberNameController = TextEditingController();
    TextEditingController villageController = TextEditingController();

    StepperCubit stepperCubit = BlocProvider.of<StepperCubit>(context);
    RadioCubit radioCubit = BlocProvider.of<RadioCubit>(context);
    FrontImageCubit frontImageCubit = BlocProvider.of<FrontImageCubit>(context);
    BackImageCubit backImageCubit = BlocProvider.of<BackImageCubit>(context);
    ProfileImageCubit profileImageCubit = BlocProvider.of<ProfileImageCubit>(
      context,
    );
    ImageUploadCubit imageUploadCubit = BlocProvider.of<ImageUploadCubit>(
      context,
    );
    AuthCubit authCubit = BlocProvider.of<AuthCubit>(context);
    ProfileCubit profileCubit = BlocProvider.of<ProfileCubit>(context);

    SelectRelationCubit selectRelationCubit =
        BlocProvider.of<SelectRelationCubit>(context);
    SelectStandardCubit selectStandardCubit =
        BlocProvider.of<SelectStandardCubit>(context);

    List<String> relationList = [
      'Father',
      'Mother',
      'Son',
      'Daughter',
      'Brother',
      'Spouse',
      'Self',
    ];
    List<String> standardList = [
      'Playgroup',
      '1',
      '2',
      '3',
      '4',
      '5',
      '6',
      '7',
      '8',
      '9',
      '10',
      '11',
      '12',
      'College',
    ];
    stepperCubit.init();
    radioCubit.init();
    selectRelationCubit.init();
    selectStandardCubit.init();
    imageUploadCubit.removeImage();
    profileImageCubit.removeImage();
    frontImageCubit.removeImage();
    backImageCubit.removeImage();
    return Scaffold(
      appBar:
          addMember
              ? CustomAppBar(
                title:
                    addMember == true && old == true
                        ? 'Old Member'
                        : addMember == true
                        ? 'New Member'
                        : (old == true ? 'Old Register' : 'New Register'),

                actions: [],
              )
              : null,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,

        children: <Widget>[
          if (!addMember) ...[
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
          ],

          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    if (!addMember) ...[
                      CustomText(
                        text: (old == true ? 'Old Register' : 'New Register'),
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
                    ],

                    Gap(20),
                    Align(
                      child: Stack(
                        children: [
                          BlocBuilder<ProfileImageCubit, File?>(
                            builder: (context, pickedImage) {
                              return Container(
                                width: 15.h,
                                height: 15.h,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: AppColor.themePrimaryColor
                                        .withOpacity(0.5),
                                    width: 2,
                                  ),
                                ),
                                child: ClipOval(
                                  child:
                                      pickedImage != null
                                          ? Image.file(
                                            pickedImage,
                                            fit: BoxFit.cover,
                                          )
                                          : Image.asset(
                                            AppImage.user,
                                            fit: BoxFit.cover,
                                          ),
                                ),
                              );
                            },
                          ),
                          Positioned(
                            bottom: 4,
                            right: 4,
                            child: Container(
                              decoration: BoxDecoration(
                                color: AppColor.themePrimaryColor,
                                shape: BoxShape.circle,
                              ),
                              child: InkWell(
                                onTap: () {
                                  profileImageCubit.pickImage(
                                    source: ImageSource.gallery,
                                  );
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Center(
                                    child: Icon(
                                      Icons.edit,
                                      color: AppColor.whiteColor,
                                      size: 14,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Gap(20),
                    CustomTextField(
                      hintText: 'Enter Your Name',
                      labelText: 'First Name',
                      controller: firstNameController,
                    ),
                    Gap(20),
                    CustomTextField(
                      hintText: 'Enter Middle Name',
                      labelText: 'Middle Name',
                      controller: middleNameController,
                    ),
                    Gap(20),
                    CustomTextField(
                      hintText: 'Enter Last Name',
                      labelText: 'Last Name',
                      controller: lastNameController,
                    ),
                    Gap(20),
                    CustomTextField(
                      hintText: 'Enter Mobile Number',
                      labelText: 'Mobile Number',
                      controller: mobileController,
                      keyboardType: TextInputType.phone,
                    ),
                    Gap(20),
                    CustomTextField(
                      hintText: 'Enter Email',
                      labelText: 'Email',
                      controller: emailController,
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
                      ],
                    ),
                    if (addMember) ...[
                      Gap(20),
                      CustomDropWonFiled<String>(
                        text: '',
                        title: 'Relation',
                        hintText: 'Select Relation',
                        selectColor: AppColor.themePrimaryColor,
                        items: relationList,

                        onChanged: (value) {
                          selectRelationCubit.updateValue(
                            relationValue: value ?? '',
                          );
                        },
                      ),
                      Gap(20),
                      CustomDropWonFiled<String>(
                        text: '',
                        title: 'Standard',
                        hintText: 'Select Standard',
                        selectColor: AppColor.themePrimaryColor,
                        items: standardList,

                        onChanged: (value) {
                          selectStandardCubit.updateValue(
                            standardValue: value ?? '',
                          );
                        },
                      ),
                    ],

                    if (!addMember) ...[
                      Gap(20),
                      CustomTextField(
                        hintText: 'Enter Village Name',
                        labelText: 'Village Name',
                        controller: villageController,
                      ),
                    ],
                    if (old == true) ...[
                      Gap(20),
                      CustomTextField(
                        hintText: 'Old Member Number',
                        labelText: 'Enter Old Member Number',
                        controller: oldMemberNameController,
                      ),
                    ],
                    Gap(20),
                    CustomTextField(
                      hintText: 'Enter Address',
                      labelText: 'Address',
                      line: 3,
                      controller: addressController,
                    ),
                    Gap(20),

                    if (old == true) ...[
                      // EXISTING OLD MEMBER UPLOAD (SINGLE)
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
                                                padding: const EdgeInsets.all(
                                                  20,
                                                ),
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
                              child: const CustomText(
                                text: 'Old Member Card',
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ] else ...[
                      // NEW MEMBER UPLOAD (FRONT AND BACK)
                      Column(
                        children: [
                          // FRONT
                          Stack(
                            clipBehavior: Clip.none,
                            children: [
                              BlocBuilder<FrontImageCubit, File?>(
                                builder: (context, frontImage) {
                                  return InkWell(
                                    borderRadius: BorderRadius.circular(12),
                                    onTap: () {
                                      if (frontImage == null) {
                                        frontImageCubit.pickImage();
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
                                          frontImage == null
                                              ? Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: <Widget>[
                                                  SvgPicture.asset(
                                                    AppImage.uploadImage,
                                                  ),
                                                  Gap(10),
                                                  const CustomText(
                                                    text: 'Upload Front Side',
                                                    fontSize: 12,
                                                  ),
                                                ],
                                              )
                                              : Stack(
                                                children: [
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                          20,
                                                        ),
                                                    child: ClipRRect(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                            12,
                                                          ),
                                                      child: Image.file(
                                                        frontImage,
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
                                                        frontImageCubit
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
                                  child: const CustomText(
                                    text: 'Front ID Proof',
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Gap(16),

                          // BACK
                          Stack(
                            clipBehavior: Clip.none,
                            children: [
                              BlocBuilder<BackImageCubit, File?>(
                                builder: (context, backImage) {
                                  return InkWell(
                                    borderRadius: BorderRadius.circular(12),
                                    onTap: () {
                                      if (backImage == null) {
                                        backImageCubit.pickImage();
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
                                          backImage == null
                                              ? Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: <Widget>[
                                                  SvgPicture.asset(
                                                    AppImage.uploadImage,
                                                  ),
                                                  Gap(10),
                                                  const CustomText(
                                                    text: 'Upload Back Side',
                                                    fontSize: 12,
                                                  ),
                                                ],
                                              )
                                              : Stack(
                                                children: [
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                          20,
                                                        ),
                                                    child: ClipRRect(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                            12,
                                                          ),
                                                      child: Image.file(
                                                        backImage,
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
                                                        backImageCubit
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
                                  child: const CustomText(
                                    text: 'Back ID Proof',
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],

                    Gap(40),

                    CustomButton(
                      text: 'Submit',
                      onTap:
                          addMember
                              ? () {
                                profileCubit.addMemberFamily(
                                  context,
                                  firstName: firstNameController.text,
                                  middleName: middleNameController.text,
                                  lastName: lastNameController.text,
                                  mobileNo: mobileController.text,
                                  email: emailController.text,
                                  address: addressController.text,

                                  oldMemberId: oldMemberNameController.text,
                                  gender:
                                      radioCubit.state == UserType.male
                                          ? 'Male'
                                          : 'Female',
                                  photo: profileImageCubit.state?.path ?? '',
                                  old: old,
                                  oldMemberIdCard:
                                      imageUploadCubit.state?.path ?? '',
                                  idProofBack: backImageCubit.state?.path ?? '',
                                  idProofFront:
                                      frontImageCubit.state?.path ?? '',
                                  relation:
                                      selectRelationCubit.state.isNotEmpty
                                          ? selectRelationCubit.state[0]
                                                  .toLowerCase() +
                                              selectRelationCubit.state
                                                  .substring(1)
                                          : '',
                                  standard:
                                      selectStandardCubit.state.isNotEmpty
                                          ? selectStandardCubit.state[0]
                                                  .toLowerCase() +
                                              selectStandardCubit.state
                                                  .substring(1)
                                          : '',
                                );
                              }
                              : () {
                                authCubit.register(
                                  context,
                                  firstName: firstNameController.text,
                                  middleName: middleNameController.text,
                                  lastName: lastNameController.text,
                                  mobileNo: mobileController.text,
                                  email: emailController.text,
                                  address: addressController.text,
                                  villageName: villageController.text,
                                  oldMemberId: oldMemberNameController.text,
                                  gender:
                                      radioCubit.state == UserType.male
                                          ? 'Male'
                                          : 'Female',
                                  photo: profileImageCubit.state?.path ?? '',
                                  old: old,
                                  oldMemberIdCard:
                                      imageUploadCubit.state?.path ?? '',
                                  idProofBack: backImageCubit.state?.path ?? '',
                                  idProofFront:
                                      frontImageCubit.state?.path ?? '',
                                );
                              },
                    ),

                    if (addMember == false) ...[
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
                    ],

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
