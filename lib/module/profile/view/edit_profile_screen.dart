import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:image_picker/image_picker.dart';
import 'package:svt_ppm/module/auth/cubit/auth_cubit.dart';
import 'package:svt_ppm/module/auth/model/login_model.dart';
import 'package:svt_ppm/module/auth/model/village_model.dart';
import 'package:svt_ppm/module/profile/cubit/profile_cubit.dart';
import 'package:svt_ppm/module/profile/view/widget/custom_profile_widget.dart';
import 'package:svt_ppm/utils/constant/app_image.dart';
import 'package:svt_ppm/utils/constant/app_list.dart';
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
  TextEditingController whatsappController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController villageController = TextEditingController();
  List<VillageModel> villageList = [];
  bool isSameAsMobile = false;

  TextEditingController plotNoController = TextEditingController();
  TextEditingController societyNameController = TextEditingController();
  TextEditingController areaNameController = TextEditingController();
  TextEditingController landmarkController = TextEditingController();
  TextEditingController pincodeController = TextEditingController();
  TextEditingController occupationController = TextEditingController();
  TextEditingController otherDegreeController = TextEditingController();
  String educationValue = '';
  String bloodGroupValue = '';
  String degreeValue = '';
  String standardValue = '';
  String relationValue = '';

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final userData = widget.argument['userData'] as LoginModel;
      firstNameController.text = userData.firstName;
      middleNameController.text = userData.middleName;
      lastNameController.text = userData.lastName;
      mobileController.text = userData.mobileNo;
      whatsappController.text = userData.whatsappNo;
      emailController.text = userData.email;
      addressController.text = userData.address;
      plotNoController.text = userData.plotNo;
      societyNameController.text = userData.societyName;
      areaNameController.text = userData.areaName;
      landmarkController.text = userData.landmark;
      pincodeController.text = userData.pincode;
      occupationController.text = userData.occupation;
      villageController.text = userData.villageName;

      setState(() {
        educationValue = educationList.firstWhere(
          (e) => e.toLowerCase() == userData.education.toLowerCase(),
          orElse: () => userData.education,
        );
        bloodGroupValue = bloodGroupList.firstWhere(
          (e) => e.toLowerCase() == userData.bloodGroup.toLowerCase(),
          orElse: () => userData.bloodGroup,
        );
        standardValue = standardList.firstWhere(
          (e) => e.toLowerCase() == userData.standard.toLowerCase(),
          orElse: () => userData.standard,
        );
        relationValue = relationList.firstWhere(
          (e) => e.toLowerCase() == userData.relation.toLowerCase(),
          orElse: () => '',
        );
        degreeValue = userData.degree;

        // Check if degree is in the list, if not it might be "Other"
        if (degreeValue.isNotEmpty) {
          bool isGraduate = educationValue == 'Graduate';
          List<String> currentDegrees =
              isGraduate ? undergraduateDegrees : postgraduateDegrees;
          if (educationValue == 'Graduate' ||
              educationValue == 'Post Graduate') {
            if (!currentDegrees.any(
              (e) => e.toLowerCase() == degreeValue.toLowerCase(),
            )) {
              otherDegreeController.text = degreeValue;
              degreeValue = 'Other (Type New)';
            } else {
              // Match the exact case from the list
              degreeValue = currentDegrees.firstWhere(
                (e) => e.toLowerCase() == degreeValue.toLowerCase(),
              );
            }
          }
        }
      });

      log(
        'userData.mobileNo == userData.whatsappNo ::${userData.mobileNo == userData.whatsappNo}',
      );

      if (userData.mobileNo.isNotEmpty &&
          userData.mobileNo == userData.whatsappNo) {
        setState(() {
          isSameAsMobile = true;
        });
      }
      BlocProvider.of<RadioCubit>(context).selectUserType(
        userData.gender == 'Male' ? UserType.male : UserType.female,
      );
      context.read<PanCardImageCubit>().removeImage();
    });
  }

  @override
  Widget build(BuildContext context) {
    LoginModel userData = widget.argument['userData'];
    ProfileCubit profileCubit = BlocProvider.of<ProfileCubit>(context);
    AuthCubit authCubit = BlocProvider.of<AuthCubit>(context);
    RadioCubit radioCubit = context.watch<RadioCubit>();
    ProfileImageCubit profileImageCubit = BlocProvider.of<ProfileImageCubit>(
      context,
    );
    PanCardImageCubit panCardImageCubit = context.watch<PanCardImageCubit>();

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
                labelText: 'First Name *',
                controller: firstNameController,
                textCapitalization: TextCapitalization.characters,
              ),
              Gap(20),
              CustomTextField(
                hintText: 'Enter Middle Name',
                labelText: 'Middle Name *',
                textCapitalization: TextCapitalization.characters,

                controller: middleNameController,
              ),
              Gap(20),
              CustomTextField(
                hintText: 'Enter Last Name',
                labelText: 'Last Name *',
                controller: lastNameController,
                textCapitalization: TextCapitalization.characters,
              ),
              Gap(20),
              CustomTextField(
                hintText: 'Enter Mobile Number',
                labelText: 'Mobile Number',
                keyboardType: TextInputType.number,
                controller: mobileController,
                maxLength: 10,
              ),
              Gap(20),
              CustomTextField(
                labelText: 'WhatsApp Number',
                hintText: 'Enter WhatsApp Number',
                controller: whatsappController,
                keyboardType: TextInputType.phone,
                maxLength: 10,
                onChanged: (val) {
                  if (isSameAsMobile && val != mobileController.text) {
                    setState(() {
                      isSameAsMobile = false;
                    });
                  }
                },
              ),
              Gap(10),
              Row(
                children: [
                  SizedBox(
                    height: 24,
                    width: 24,
                    child: Checkbox(
                      value: isSameAsMobile,
                      activeColor: AppColor.themePrimaryColor,

                      onChanged: (val) {
                        setState(() {
                          isSameAsMobile = val ?? false;
                          if (isSameAsMobile) {
                            whatsappController.text = mobileController.text;
                          }
                        });
                      },
                    ),
                  ),
                  const Gap(10),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        isSameAsMobile = !isSameAsMobile;
                        if (isSameAsMobile) {
                          whatsappController.text = mobileController.text;
                        }
                      });
                    },
                    child: const CustomText(
                      text: 'Same as Mobile Number',
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
              const Gap(20),
              CustomTextField(
                hintText: 'Enter Email',
                labelText: 'Email',
                controller: emailController,
                textCapitalization: TextCapitalization.characters,
              ),

              Gap(10),

              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(
                    text: 'Gender *',
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
                    labelText: 'Village',
                    hintText: 'Village',
                    controller: villageController,
                    readOnly: true,
                  ),
                  Gap(20),
                  Row(
                    children: [
                      Expanded(
                        child: CustomDropWonFiled<String>(
                          title: 'Education',
                          hintText: 'Select Education',
                          items: educationList,
                          text: educationValue,
                          initialItem: educationValue,
                          onChanged: (val) {
                            setState(() {
                              educationValue = val ?? '';
                              degreeValue = '';
                              otherDegreeController.clear();
                            });
                          },
                        ),
                      ),
                      const Gap(10),
                      Expanded(
                        child: CustomDropWonFiled<String>(
                          title: 'Blood Group',
                          hintText: 'Select Blood Group',
                          items: bloodGroupList,
                          text: bloodGroupValue,
                          initialItem: bloodGroupValue,
                          onChanged: (val) {
                            setState(() => bloodGroupValue = val ?? '');
                          },
                        ),
                      ),
                    ],
                  ),
                  const Gap(20),
                  Row(
                    children: [
                      Expanded(
                        child: CustomDropWonFiled<String>(
                          title: 'Relation',
                          hintText: 'Select Relation',
                          items: relationList,
                          text: relationValue,
                          initialItem: relationValue,
                          onChanged: (val) {
                            setState(() => relationValue = val ?? '');
                          },
                        ),
                      ),
                      if (relationValue.toLowerCase() == 'son' ||
                          relationValue.toLowerCase() == 'daughter') ...[
                        const Gap(10),

                        Expanded(
                          child: CustomDropWonFiled<String>(
                            title: 'Standard',
                            hintText: 'Select Standard',
                            items: standardList,
                            text: standardValue,
                            initialItem: standardValue,
                            onChanged: (val) {
                              setState(() => standardValue = val ?? '');
                            },
                          ),
                        ),
                        const Gap(10),
                      ],
                    ],
                  ),
                  const Gap(20),
                  CustomTextField(
                    labelText: 'Occupation',
                    hintText: 'Enter Occupation',
                    controller: occupationController,
                    textCapitalization: TextCapitalization.characters,
                  ),
                  if (educationValue == 'Graduate' ||
                      educationValue == 'Post Graduate') ...[
                    const Gap(20),
                    CustomDropWonFiled<String>(
                      title: 'Degree',
                      hintText: 'Select Degree',
                      items:
                          educationValue == 'Graduate'
                              ? undergraduateDegrees
                              : postgraduateDegrees,
                      text: degreeValue,
                      onChanged: (val) {
                        setState(() {
                          degreeValue = val ?? '';
                          if (degreeValue != 'Other (Type New)') {
                            otherDegreeController.clear();
                          }
                        });
                      },
                    ),
                  ],
                  if (degreeValue == 'Other (Type New)') ...[
                    const Gap(20),
                    CustomTextField(
                      labelText: 'Other Degree',
                      hintText: 'Enter Degree Name',
                      controller: otherDegreeController,
                      textCapitalization: TextCapitalization.characters,
                    ),
                  ],

                  const Gap(20),
                  const CustomText(
                    text: "Location",
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: AppColor.themePrimaryColor,
                  ),
                  Gap(20),

                  CustomTextField(
                    labelText: 'Plot/Flat No.',
                    hintText: 'Plot/Flat No',
                    controller: plotNoController,
                    readOnly: true,
                    maxLength: 20,
                  ),
                  const Gap(20),
                  CustomTextField(
                    labelText: 'Society/Building Name',
                    hintText: 'Society/Building Name',
                    controller: societyNameController,
                    readOnly: true,
                    maxLength: 20,
                  ),
                  const Gap(20),
                  CustomTextField(
                    labelText: 'Area Name',
                    hintText: 'Area Name',
                    controller: areaNameController,
                    readOnly: true,
                    maxLength: 20,
                  ),
                  const Gap(20),
                  CustomTextField(
                    labelText: 'Nearby/Locality',
                    hintText: 'Nearby/Locality',
                    controller: landmarkController,
                    readOnly: true,
                    maxLength: 20,
                  ),
                  const Gap(20),
                  CustomTextField(
                    labelText: 'Pincode',
                    hintText: 'Pincode',
                    controller: pincodeController,
                    readOnly: true,
                  ),

                  // CustomTextField(
                  //   hintText: 'Enter Address',
                  //   labelText: 'Address',
                  //   line: 3,
                  //   controller: addressController,
                  //   textCapitalization: TextCapitalization.characters,
                  // ),
                  // Gap(20),

                  // Stack(
                  //   clipBehavior: Clip.none,
                  //   children: [
                  //     BlocBuilder<ImageUploadCubit, File?>(
                  //       builder: (context, imageFile) {
                  //         return InkWell(
                  //           borderRadius: BorderRadius.circular(12),
                  //           onTap: () {
                  //             if (imageFile == null) {
                  //               imageUploadCubit.pickImage();
                  //             }
                  //           },
                  //           child: Container(
                  //             height: 25.h,
                  //             decoration: BoxDecoration(
                  //               border: Border.all(
                  //                 color: AppColor.themePrimaryColor,
                  //                 width: 1,
                  //               ),
                  //               borderRadius: BorderRadius.circular(12),
                  //             ),
                  //             child:
                  //                 imageFile == null
                  //                     ? Row(
                  //                       mainAxisAlignment:
                  //                           MainAxisAlignment.center,
                  //                       children: <Widget>[
                  //                         SvgPicture.asset(
                  //                           AppImage.uploadImage,
                  //                         ),
                  //                         Gap(10),
                  //                         const CustomText(
                  //                           text: 'Upload ID Proof',
                  //                           fontSize: 12,
                  //                         ),
                  //                       ],
                  //                     )
                  //                     : Stack(
                  //                       children: [
                  //                         Padding(
                  //                           padding: const EdgeInsets.all(20),
                  //                           child: ClipRRect(
                  //                             borderRadius:
                  //                                 BorderRadius.circular(12),
                  //                             child: Image.file(
                  //                               imageFile,
                  //                               width: 100.w,
                  //                               fit: BoxFit.fill,
                  //                             ),
                  //                           ),
                  //                         ),
                  //                         Positioned(
                  //                           top: 8,
                  //                           right: 8,
                  //                           child: InkWell(
                  //                             onTap: () {
                  //                               imageUploadCubit.removeImage();
                  //                             },
                  //                             child: const CircleAvatar(
                  //                               radius: 14,
                  //                               backgroundColor: Colors.black54,
                  //                               child: Icon(
                  //                                 Icons.close,
                  //                                 size: 16,
                  //                                 color: Colors.white,
                  //                               ),
                  //                             ),
                  //                           ),
                  //                         ),
                  //                       ],
                  //                     ),
                  //           ),
                  //         );
                  //       },
                  //     ),
                  //     Positioned(
                  //       top: -10,
                  //       left: 20,
                  //       child: Container(
                  //         decoration: BoxDecoration(color: AppColor.whiteColor),
                  //         padding: EdgeInsets.symmetric(horizontal: 2),
                  //         child: const CustomText(
                  //           text: 'Old Member Card',
                  //           fontSize: 14,
                  //           fontWeight: FontWeight.w600,
                  //         ),
                  //       ),
                  //     ),
                  //   ],
                  // ),
                  const Gap(20),
                  const CustomText(
                    text: 'Pan Card',
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                  const Gap(10),
                  _buildImageUpload(
                    cubit: panCardImageCubit,
                    title: 'Upload Pan Card',
                    existingUrl: userData.pancardImage,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        child: CustomButton(
          text: 'Update',
          onTap: () async {
            if (userData.mobileNo == mobileController.text) {
              profileCubit.addMemberFamily(
                context,
                memberId: userData.id,
                edit: true,
                editProfile: true,
                firstName: firstNameController.text,
                middleName: middleNameController.text,
                lastName: lastNameController.text,
                mobileNo: mobileController.text,
                whatsappNo: whatsappController.text,
                email: emailController.text,
                address: addressController.text,
                villageName: villageController.text,
                relation: relationValue.toLowerCase(),
                standard: standardValue,
                education: educationValue,
                degree:
                    degreeValue == 'Other (Type New)'
                        ? otherDegreeController.text.trim()
                        : degreeValue,
                bloodGroup: bloodGroupValue,
                gender: radioCubit.state == UserType.male ? 'Male' : 'Female',
                photo: profileImageCubit.state?.path ?? userData.photo,
                pancardImage:
                    panCardImageCubit.state?.path ?? userData.pancardImage,
              );
            } else {
              mobileVerification(
                context,
                profileCubit: profileCubit,
                number: mobileController.text,
                authCubit: authCubit,
                memberId: userData.id,
                firstName: firstNameController.text,
                middleName: middleNameController.text,
                lastName: lastNameController.text,
                mobileNo: mobileController.text,
                whatsappNo: whatsappController.text,
                email: emailController.text,
                address: addressController.text,
                villageName: villageController.text,
                relation: relationValue.toLowerCase(),
                standard: standardValue,
                education: educationValue,
                degree:
                    degreeValue == 'Other (Type New)'
                        ? otherDegreeController.text.trim()
                        : degreeValue,
                bloodGroup: bloodGroupValue,
                gender: radioCubit.state == UserType.male ? 'Male' : 'Female',
                photo: profileImageCubit.state?.path ?? userData.photo,
                pancardImage:
                    panCardImageCubit.state?.path ?? userData.pancardImage,
              );
            }
          },
        ),
      ),
    );
  }

  Widget _buildImageUpload({
    required dynamic cubit,
    required String title,
    String? existingUrl,
  }) {
    return InkWell(
      onTap: () => cubit.pickImage(),
      child: Container(
        height: 150,
        width: double.infinity,
        decoration: BoxDecoration(
          border: Border.all(
            color: AppColor.themePrimaryColor.withOpacity(0.5),
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        child:
            cubit.state != null
                ? Stack(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.file(
                        cubit.state!,
                        fit: BoxFit.cover,
                        width: double.infinity,
                      ),
                    ),
                    Positioned(
                      top: 5,
                      right: 5,
                      child: CircleAvatar(
                        backgroundColor: Colors.black54,
                        radius: 12,
                        child: IconButton(
                          icon: const Icon(
                            Icons.close,
                            size: 12,
                            color: Colors.white,
                          ),
                          onPressed: () => cubit.removeImage(),
                        ),
                      ),
                    ),
                  ],
                )
                : existingUrl != null && existingUrl.isNotEmpty
                ? ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: CustomCachedImage(
                    imageUrl: existingUrl,
                    width: double.infinity,
                    borderRadius: BorderRadius.circular(12),
                  ),
                )
                : Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.cloud_upload_outlined,
                      size: 40,
                      color: AppColor.themePrimaryColor,
                    ),
                    const Gap(10),
                    Text(
                      title,
                      style: TextStyle(color: AppColor.themePrimaryColor),
                    ),
                  ],
                ),
      ),
    );
  }
}
