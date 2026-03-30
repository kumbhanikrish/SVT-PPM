import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:svt_ppm/utils/widgets/custom_radio_list_tile.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sizer/sizer.dart';
import 'package:svt_ppm/module/auth/cubit/auth_cubit.dart';
import 'package:svt_ppm/module/auth/model/auth_arguments.dart';
import 'package:svt_ppm/module/auth/model/village_model.dart';
import 'package:svt_ppm/utils/constant/app_list.dart';
import 'package:svt_ppm/utils/constant/app_image.dart';
import 'package:svt_ppm/utils/constant/app_page.dart';
import 'package:svt_ppm/utils/theme/colors.dart';
import 'package:svt_ppm/utils/widgets/curved_glow_painter.dart';
import 'package:svt_ppm/utils/widgets/custom_button.dart';
import 'package:svt_ppm/utils/widgets/custom_text.dart';
import 'package:svt_ppm/utils/widgets/custom_textfield.dart';
import 'package:svt_ppm/utils/enum/enums.dart';

class SignupScreen extends StatefulWidget {
  final SignupArgs args;
  const SignupScreen({super.key, required this.args});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  TextEditingController firstNameController = TextEditingController();
  TextEditingController middleNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController mobileController = TextEditingController();
  TextEditingController whatsappController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController idNoController = TextEditingController();
  TextEditingController plotNoController = TextEditingController();
  TextEditingController societyNameController = TextEditingController();
  TextEditingController areaNameController = TextEditingController();
  TextEditingController landmarkController = TextEditingController();
  TextEditingController pincodeController = TextEditingController();
  TextEditingController otherDegreeController = TextEditingController();
  TextEditingController occupationController = TextEditingController();

  String villageName = '';
  String villageCode = '';
  String serialNoValue = '';
  bool old = false;
  String language = 'en';
  bool isSameAsMobile = false;
  String educationValue = '';
  String bloodGroupValue = '';
  String degreeValue = '';

  @override
  void initState() {
    super.initState();
    old = widget.args.old;
    language = widget.args.language;

    context.read<RadioCubit>().init();
    context.read<ImageUploadCubit>().removeImage();
    context.read<ProfileImageCubit>().removeImage();
    context.read<FrontImageCubit>().removeImage();
    context.read<BackImageCubit>().removeImage();
    context.read<VillageCubit>().fetchVillage(context);
  }

  @override
  Widget build(BuildContext context) {
    RadioCubit radioCubit = context.watch<RadioCubit>();
    FrontImageCubit frontImageCubit = context.watch<FrontImageCubit>();
    BackImageCubit backImageCubit = context.watch<BackImageCubit>();
    ProfileImageCubit profileImageCubit = context.watch<ProfileImageCubit>();
    ImageUploadCubit imageUploadCubit = context.watch<ImageUploadCubit>();
    AuthCubit authCubit = context.read<AuthCubit>();
    VillageCubit villageCubit = context.read<VillageCubit>();

    return Scaffold(
      backgroundColor: AppColor.whiteColor,
      // appBar: const CustomAppBar(
      //   title: 'Registration',
      //   actions: [],
      //   boxShadow: [],
      //   backgroundColor: AppColor.themeSecondaryColor,
      //   bottomRadius: Radius.circular(0),
      // ),
      body: Column(
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

          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Stack(
                        children: [
                          Container(
                            height: 110,
                            width: 110,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: AppColor.themePrimaryColor,
                                width: 2,
                              ),
                            ),
                            child: ClipOval(
                              child:
                                  profileImageCubit.state != null
                                      ? Image.file(
                                        profileImageCubit.state!,
                                        fit: BoxFit.cover,
                                      )
                                      : Image.asset(
                                        AppImage.user,
                                        fit: BoxFit.cover,
                                      ),
                            ),
                          ),
                          Positioned(
                            bottom: 0,
                            right: 0,
                            child: CircleAvatar(
                              backgroundColor: AppColor.themePrimaryColor,
                              radius: 15,
                              child: IconButton(
                                icon: const Icon(
                                  Icons.edit,
                                  size: 15,
                                  color: Colors.white,
                                ),
                                onPressed:
                                    () => profileImageCubit.pickImage(
                                      source: ImageSource.gallery,
                                    ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Gap(20),
                    CustomTextField(
                      labelText: 'First Name',
                      hintText: 'Enter First Name',
                      controller: firstNameController,
                      textCapitalization: TextCapitalization.characters,
                    ),
                    const Gap(20),
                    CustomTextField(
                      labelText: 'Middle Name',
                      hintText: 'Enter Middle Name',
                      controller: middleNameController,
                      textCapitalization: TextCapitalization.characters,
                    ),
                    const Gap(20),
                    CustomTextField(
                      labelText: 'Last Name',
                      hintText: 'Enter Last Name',
                      controller: lastNameController,
                      textCapitalization: TextCapitalization.characters,
                    ),
                    const Gap(20),
                    CustomTextField(
                      labelText: 'Mobile Number',
                      hintText: 'Enter Mobile Number',
                      controller: mobileController,
                      keyboardType: TextInputType.phone,
                      maxLength: 10,
                    ),
                    const Gap(20),
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
                    const Gap(10),
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
                      labelText: 'Email',
                      hintText: 'Enter Email Address (Optional)',
                      controller: emailController,
                      keyboardType: TextInputType.emailAddress,
                    ),
                    const Gap(20),
                    const CustomText(
                      text: 'Gender',
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                    const Gap(10),
                    BlocBuilder<RadioCubit, UserType>(
                      builder: (context, selectedType) {
                        return Row(
                          children: [
                            Expanded(
                              child: customRadio(
                                buttonImage:
                                    selectedType == UserType.male
                                        ? AppImage.radioButton
                                        : AppImage.circle,
                                genderIcon: AppImage.male,
                                title: 'Male',
                                onTap:
                                    () => radioCubit.selectUserType(
                                      UserType.male,
                                    ),
                              ),
                            ),
                            const Gap(10),
                            Expanded(
                              child: customRadio(
                                buttonImage:
                                    selectedType == UserType.female
                                        ? AppImage.radioButton
                                        : AppImage.circle,
                                genderIcon: AppImage.female,
                                title: 'Female',
                                onTap:
                                    () => radioCubit.selectUserType(
                                      UserType.female,
                                    ),
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                    const Gap(20),
                    Row(
                      children: [
                        Expanded(
                          child: CustomDropWonFiled<String>(
                            title: 'Education',
                            hintText: 'Select Education',
                            items: educationList,
                            text: educationValue,
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
                            onChanged: (val) {
                              setState(() => bloodGroupValue = val ?? '');
                            },
                          ),
                        ),
                      ],
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
                    CustomTextField(
                      labelText: 'Occupation',
                      hintText: 'Enter Occupation',
                      controller: occupationController,
                      textCapitalization: TextCapitalization.characters,
                    ),
                    const Gap(20),
                    BlocBuilder<VillageCubit, VillageState>(
                      builder: (context, state) {
                        List<VillageModel> villageList = [];
                        if (state is VillageLoaded) {
                          villageList = state.villageList;
                        }
                        return CustomDropWonFiled<VillageModel>(
                          title: 'Village',
                          hintText: 'Select Village',
                          items: villageList,
                          text: villageName,
                          initialItem: villageList.any((e) => e.name == villageName)
                              ? villageList.firstWhere((e) => e.name == villageName)
                              : null,
                          onChanged: (val) {
                            if (val != null) {
                              villageName = val.name;
                              villageCode = val.code;
                              villageCubit.setVillageName(
                                name: val.name,
                                nameCode: val.code,
                              );
                            }
                          },
                        );
                      },
                    ),
                    if (old) ...[
                      const Gap(20),
                      Row(
                        children: [
                          Expanded(
                            child: CustomDropWonFiled<String>(
                              title: 'Serial No.',
                              hintText: 'Select',
                              items: serialNoList,
                              text: serialNoValue,
                              onChanged:
                                  (val) =>
                                      setState(() => serialNoValue = val ?? ''),
                            ),
                          ),
                          const Gap(15),
                          Expanded(
                            flex: 2,
                            child: CustomTextField(
                              labelText: 'ID Number',
                              hintText: 'Enter ID',
                              controller: idNoController,
                              keyboardType: TextInputType.number,
                              maxLength: 4,
                            ),
                          ),
                        ],
                      ),
                    ],
                    const Gap(20),
                    const Gap(20),
                    const CustomText(
                      text: "Location",
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: AppColor.themePrimaryColor,
                    ),
                    const Gap(10),
                    Row(
                      children: [
                        Expanded(
                          child: CustomTextField(
                            labelText: 'Plot/Flat No.',
                            hintText: 'Plot/Flat No',
                            controller: plotNoController,
                            textCapitalization: TextCapitalization.characters,
                            maxLength: 20,
                          ),
                        ),
                        const Gap(10),
                        Expanded(
                          child: CustomTextField(
                            labelText: 'Society/Building Name',
                            hintText: 'Society/Building Name',
                            controller: societyNameController,
                            textCapitalization: TextCapitalization.characters,
                            maxLength: 20,
                          ),
                        ),
                        const Gap(10),
                        Expanded(
                          child: CustomTextField(
                            labelText: 'Area Name',
                            hintText: 'Area Name',
                            controller: areaNameController,
                            textCapitalization: TextCapitalization.characters,
                            maxLength: 20,
                          ),
                        ),
                      ],
                    ),
                    const Gap(15),
                    Row(
                      children: [
                        Expanded(
                          child: CustomTextField(
                            labelText: 'Nearby/Locality',
                            hintText: 'Nearby/Locality',
                            controller: landmarkController,
                            textCapitalization: TextCapitalization.characters,
                            maxLength: 20,
                          ),
                        ),
                        const Gap(10),
                        Expanded(
                          child: CustomTextField(
                            labelText: 'Pincode',
                            hintText: 'Pincode',
                            controller: pincodeController,
                            keyboardType: TextInputType.number,
                            maxLength: 6,
                          ),
                        ),
                        const Expanded(child: SizedBox()),
                      ],
                    ),
                    const Gap(20),
                    CustomTextField(
                      labelText: 'Address',
                      hintText: 'Enter Address',
                      controller: addressController,
                      line: 3,
                      textCapitalization: TextCapitalization.characters,
                    ),
                    const Gap(20),
                    if (old) ...[
                      _buildImageUpload(
                        cubit: imageUploadCubit,
                        title: 'Upload Old ID Card',
                      ),
                    ] else ...[
                      _buildImageUpload(
                        cubit: frontImageCubit,
                        title: 'ID Proof (Front)',
                      ),
                      const Gap(15),
                      _buildImageUpload(
                        cubit: backImageCubit,
                        title: 'ID Proof (Back)',
                      ),
                    ],
                    const Gap(30),
                    CustomButton(
                      text: 'Submit',
                      onTap: () {
                        authCubit.register(
                          context,
                          firstName: firstNameController.text.trim(),
                          middleName: middleNameController.text.trim(),
                          lastName: lastNameController.text.trim(),
                          mobileNo: mobileController.text.trim(),
                          whatsappNo: whatsappController.text.trim(),
                          email: emailController.text.trim(),
                          address: addressController.text.trim(),
                          villageName: villageName,
                          villageCode: villageCode,
                          oldMemberId:
                              old
                                  ? '$serialNoValue${idNoController.text.trim()}'
                                  : '',
                          gender:
                              radioCubit.state == UserType.male
                                  ? 'Male'
                                  : 'Female',
                          photo: profileImageCubit.state?.path ?? '',
                          old: old,
                          oldMemberIdCard: imageUploadCubit.state?.path ?? '',
                          idProofBack: backImageCubit.state?.path ?? '',
                          idProofFront: frontImageCubit.state?.path ?? '',
                          language: language,
                          plotNo: plotNoController.text.trim(),
                          societyName: societyNameController.text.trim(),
                          areaName: areaNameController.text.trim(),
                          landmark: landmarkController.text.trim(),
                          pincode: pincodeController.text.trim(),
                          education: educationValue,
                          bloodGroup: bloodGroupValue,
                          degree:
                              degreeValue == 'Other (Type New)'
                                  ? otherDegreeController.text.trim()
                                  : degreeValue,
                          occupation: occupationController.text.trim(),
                        );
                      },
                    ),
                    const Gap(20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const CustomText(
                          text: 'Already have an account? ',
                          fontSize: 13,
                        ),
                        InkWell(
                          onTap:
                              () => Navigator.pushNamedAndRemoveUntil(
                                context,
                                AppPage.authScreen,
                                (route) => false,
                              ),
                          child: const CustomText(
                            text: 'Sign In',
                            color: AppColor.themePrimaryColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 13,
                          ),
                        ),
                      ],
                    ),
                    Gap(5.h),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildImageUpload({required dynamic cubit, required String title}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomText(text: title, fontSize: 14, fontWeight: FontWeight.w600),
        const Gap(10),
        InkWell(
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
                          'Tap to upload',
                          style: TextStyle(color: AppColor.themePrimaryColor),
                        ),
                      ],
                    ),
          ),
        ),
      ],
    );
  }
}
