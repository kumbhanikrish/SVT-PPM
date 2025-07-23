import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sizer/sizer.dart';
import 'package:svt_ppm/module/auth/cubit/auth_cubit.dart';
import 'package:svt_ppm/module/auth/model/login_model.dart';
import 'package:svt_ppm/utils/constant/app_image.dart';
import 'package:svt_ppm/utils/enum/enums.dart';
import 'package:svt_ppm/utils/theme/colors.dart';
import 'package:svt_ppm/utils/widgets/custom_app_bar.dart';
import 'package:svt_ppm/utils/widgets/custom_button.dart';
import 'package:svt_ppm/utils/widgets/custom_filed_box.dart';
import 'package:svt_ppm/utils/widgets/custom_image.dart';
import 'package:svt_ppm/utils/widgets/custom_radio_list_tile.dart';
import 'package:svt_ppm/utils/widgets/custom_text.dart';
import 'package:svt_ppm/utils/widgets/custom_textfield.dart';

class EditProfileScreen extends StatefulWidget {
  final dynamic argument;
  const EditProfileScreen({super.key, this.argument});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  TextEditingController firstNameController = TextEditingController();
  TextEditingController middleNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController mobileController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController villageController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    LoginModel userData = widget.argument['userData'];

    firstNameController.text = userData.firstName;
    middleNameController.text = userData.middleName;
    lastNameController.text = userData.lastName;
    mobileController.text = userData.mobileNo;
    emailController.text = userData.email;
    addressController.text = userData.address;
    villageController.text = userData.villageName;

    log('User Data: ${userData.gender}');

    RadioCubit radioCubit = BlocProvider.of<RadioCubit>(context);

    radioCubit.selectUserType(
      userData.gender == 'Male' ? UserType.male : UserType.female,
    );
    ProfileImageCubit profileImageCubit = BlocProvider.of<ProfileImageCubit>(
      context,
    );
    ImageUploadCubit imageUploadCubit = BlocProvider.of<ImageUploadCubit>(
      context,
    );
    return Scaffold(
      appBar: CustomAppBar(title: 'Edit Profile', actions: []),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Gap(25),
              BlocBuilder<ProfileImageCubit, File?>(
                builder: (context, pickedImage) {
                  return CustomFieldBox(
                    title: 'Edit Image',
                    children: [
                      ClipOval(
                        child:
                            pickedImage != null
                                ? Image.file(
                                  pickedImage,
                                  fit: BoxFit.cover,
                                  width: 150,
                                  height: 150,
                                )
                                : userData.photo.isNotEmpty
                                ? CustomCachedImage(
                                  imageUrl: userData.photo,
                                  width: 150,
                                  height: 150,
                                  borderRadius: BorderRadius.circular(50),
                                )
                                : Image.asset(
                                  AppImage.user,
                                  fit: BoxFit.cover,
                                  width: 150,
                                  height: 150,
                                ),
                      ),
                      Gap(15),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          InkWell(
                            onTap: () {
                              profileImageCubit.pickImage(
                                source: ImageSource.camera,
                              );
                            },
                            child: SvgPicture.asset(AppImage.camera),
                          ),
                          Gap(14),

                          InkWell(
                            onTap: () {
                              profileImageCubit.pickImage(
                                source: ImageSource.gallery,
                              );
                            },
                            child: SvgPicture.asset(AppImage.gallery),
                          ),
                        ],
                      ),
                    ],
                  );
                },
              ),
              Gap(25),
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
                                radioCubit.selectUserType(UserType.female);
                              },
                              title: 'Female',
                            ),
                          ),
                        ],
                      );
                    },
                  ),

                  Gap(20),
                  CustomTextField(
                    hintText: 'Enter Village Name',
                    labelText: 'Village Name',
                    controller: villageController,
                  ),
                  Gap(20),
                  CustomTextField(
                    hintText: 'Enter Address',
                    labelText: 'Address',
                    line: 3,
                    controller: addressController,
                  ),
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
                                                imageUploadCubit.removeImage();
                                              },
                                              child: const CircleAvatar(
                                                radius: 14,
                                                backgroundColor: Colors.black54,
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
                          decoration: BoxDecoration(color: AppColor.whiteColor),
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
                ],
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        child: CustomButton(text: 'Update', onTap: () {}),
      ),
    );
  }
}
