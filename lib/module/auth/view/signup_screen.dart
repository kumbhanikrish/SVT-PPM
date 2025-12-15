import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sizer/sizer.dart';
import 'package:svt_ppm/module/auth/cubit/auth_cubit.dart';
import 'package:svt_ppm/module/auth/model/login_model.dart';
import 'package:svt_ppm/module/auth/model/village_model.dart';
import 'package:svt_ppm/module/auth/view/auth_screen.dart';
import 'package:svt_ppm/module/profile/cubit/profile_cubit.dart';
import 'package:svt_ppm/utils/constant/app_image.dart';
import 'package:svt_ppm/utils/constant/app_page.dart';
import 'package:svt_ppm/utils/enum/enums.dart';
import 'package:svt_ppm/utils/formatter/format.dart';
import 'package:svt_ppm/utils/theme/colors.dart';
import 'package:svt_ppm/utils/widgets/custom_app_bar.dart';
import 'package:svt_ppm/utils/widgets/custom_button.dart';
import 'package:svt_ppm/utils/widgets/custom_image.dart';
import 'package:svt_ppm/utils/widgets/custom_radio_list_tile.dart';
import 'package:svt_ppm/utils/widgets/custom_text.dart';
import 'package:svt_ppm/utils/widgets/custom_textfield.dart';

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
List<String> serialNoList = [
  'A',
  'B',
  'C',
  'D',
  'E',
  'F',
  'G',
  'H',
  'I',
  'J',
  'K',
  'L',
  'M',
  'N',
  'O',
  'P',
  'Q',
  'R',
  'S',
  'T',
  'U',
  'V',
  'W',
  'X',
  'Y',
  'Z',
];

class SignupScreen extends StatefulWidget {
  final dynamic data;
  const SignupScreen({super.key, this.data});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  TextEditingController firstNameController = TextEditingController();
  TextEditingController middleNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController mobileController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController idNoController = TextEditingController();

  TextEditingController occupationController = TextEditingController();
  String serialNoValue = '';
  String villageName = '';
  String villageCode = '';

  String initialRelation = '';
  String initialStandard = '';
  LoginModel? member;
  @override
  void initState() {
    bool addMember = widget.data['addMember'] ?? false;
    bool edit = widget.data['edit'] ?? false;
    super.initState();

    BlocProvider.of<StepperCubit>(context).init();
    BlocProvider.of<RadioCubit>(context).init();
    BlocProvider.of<SelectRelationCubit>(context).init();
    BlocProvider.of<SelectStandardCubit>(context).init();
    BlocProvider.of<ImageUploadCubit>(context).removeImage();
    BlocProvider.of<ProfileImageCubit>(context).removeImage();
    BlocProvider.of<FrontImageCubit>(context).removeImage();
    BlocProvider.of<BackImageCubit>(context).removeImage();
    if (!addMember && !edit) {
      BlocProvider.of<VillageCubit>(context).fetchVillage(context);
    }
    if (edit) {
      member = widget.data['member'];

      firstNameController.text = member?.firstName ?? '';
      middleNameController.text = member?.middleName ?? '';
      lastNameController.text = member?.lastName ?? '';
      mobileController.text = member?.mobileNo ?? '';
      emailController.text = member?.email ?? '';

      initialRelation = member?.relation ?? '';
      initialStandard = member?.standard ?? '';

      if (relationList.isNotEmpty && (member?.standard ?? '').isNotEmpty) {
        initialRelation = relationList.firstWhere(
          (item) => item == member?.relation,
          orElse: () => relationList.first,
        );
      }
      if (standardList.isNotEmpty && (member?.standard ?? '').isNotEmpty) {
        initialStandard = standardList.firstWhere(
          (item) => item == member?.standard,
          orElse: () => standardList.first,
        );
      }
      BlocProvider.of<RadioCubit>(
        context,
      ).selectUserType(userTypeFromString(member?.gender) ?? UserType.male);

      BlocProvider.of<SelectRelationCubit>(
        context,
      ).updateValue(relationValue: member?.relation ?? '');
      BlocProvider.of<SelectStandardCubit>(
        context,
      ).updateValue(standardValue: member?.standard ?? '');
    }
  }

  @override
  Widget build(BuildContext context) {
    bool old = widget.data['old'] ?? false;
    bool addMember = widget.data['addMember'] ?? false;
    bool edit = widget.data['edit'] ?? false;

    String language = widget.data['language'] ?? 'English';

    // TextEditingController villageController = TextEditingController();

    RadioCubit radioCubit = BlocProvider.of<RadioCubit>(context);
    FrontImageCubit frontImageCubit = BlocProvider.of<FrontImageCubit>(context);
    BackImageCubit backImageCubit = BlocProvider.of<BackImageCubit>(context);
    VillageCubit villageCubit = BlocProvider.of<VillageCubit>(context);
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
    List<VillageModel> villageList = [];

    return Scaffold(
      appBar:
          addMember
              ? CustomAppBar(
                title:
                    edit && addMember == true
                        ? 'Edit Member'
                        : addMember == true && old == true
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
                                            width: 150,
                                            height: 150,
                                          )
                                          : (member?.photo ?? '').isNotEmpty
                                          ? CustomCachedImage(
                                            imageUrl: member?.photo ?? '',
                                            width: 150,
                                            height: 150,
                                            borderRadius: BorderRadius.circular(
                                              50,
                                            ),
                                          )
                                          : Image.asset(
                                            AppImage.user,
                                            fit: BoxFit.cover,
                                            width: 150,
                                            height: 150,
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
                      textCapitalization: TextCapitalization.characters,
                    ),
                    Gap(20),
                    CustomTextField(
                      hintText: 'Enter Middle Name',
                      labelText: 'Middle Name',
                      controller: middleNameController,
                      textCapitalization: TextCapitalization.characters,
                    ),
                    Gap(20),
                    CustomTextField(
                      hintText: 'Enter Last Name',
                      labelText: 'Last Name',
                      controller: lastNameController,
                      textCapitalization: TextCapitalization.characters,
                    ),
                    Gap(20),
                    CustomTextField(
                      hintText: 'Enter Mobile Number',
                      labelText: 'Mobile Number',
                      controller: mobileController,
                      keyboardType: TextInputType.phone,
                      maxLength: 10,
                    ),
                    Gap(20),
                    CustomTextField(
                      hintText: 'Enter Email',
                      labelText: 'Email',
                      controller: emailController,
                      textCapitalization: TextCapitalization.characters,
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
                        initialItem:
                            (member?.relation ?? '').isEmpty
                                ? null
                                : initialRelation,
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
                        initialItem:
                            (member?.standard ?? '').isEmpty
                                ? null
                                : initialStandard,
                        hintText: 'Select Standard',
                        selectColor: AppColor.themePrimaryColor,
                        items: standardList,

                        onChanged: (value) {
                          selectStandardCubit.updateValue(
                            standardValue: value ?? '',
                          );
                        },
                      ),
                      Gap(20),

                      CustomTextField(
                        hintText: 'enter Occupation',
                        labelText: 'Occupation',
                        controller: occupationController,
                      ),
                    ],

                    if (!addMember) ...[
                      Gap(20),

                      BlocBuilder<VillageCubit, VillageState>(
                        builder: (context, state) {
                          if (state is VillageLoaded) {
                            villageList = state.villageList;
                          }

                          return CustomDropWonFiled<VillageModel>(
                            text: '',

                            title: 'Village',
                            hintText: 'Select Village',
                            selectColor: AppColor.themePrimaryColor,
                            items: villageList,

                            onChanged: (value) {
                              log('value?.key ??  ::${value?.name ?? ''}');
                              villageCubit.setVillageName(
                                name: value?.name ?? '',
                                nameCode: value?.code ?? '',
                              );
                            },
                          );
                        },
                      ),
                    ],
                    if (old == true) ...[
                      Gap(20),
                      Row(
                        children: [
                          Expanded(
                            child: CustomDropWonFiled<String>(
                              text: '',

                              title: 'Serial No.',
                              hintText: 'Select Serial No.',
                              selectColor: AppColor.themePrimaryColor,
                              items: serialNoList,

                              onChanged: (value) {
                                setState(() {
                                  serialNoValue = value ?? '';
                                });
                              },
                            ),
                          ),
                          Gap(10),

                          Expanded(
                            child: CustomTextField(
                              hintText: 'Enter Id No.',
                              labelText: 'Id No.',
                              controller: idNoController,
                              keyboardType: TextInputType.number,

                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly,
                              ],

                              maxLength: 4,
                            ),
                          ),
                        ],
                      ),
                    ],
                    Gap(20),
                    if (!addMember) ...[
                      CustomTextField(
                        hintText: 'Enter Address',
                        labelText: 'Address',
                        line: 3,
                        controller: addressController,
                        textCapitalization: TextCapitalization.characters,
                      ),
                      Gap(20),
                    ],

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
                                          frontImage != null
                                              ? Stack(
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
                                              )
                                              : member?.idProofFront != null &&
                                                  (member?.idProofFront ?? '')
                                                      .isNotEmpty
                                              ? InkWell(
                                                onTap: () {
                                                  frontImageCubit.pickImage();
                                                },
                                                child: Padding(
                                                  padding: const EdgeInsets.all(
                                                    20,
                                                  ),
                                                  child: ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                          12,
                                                        ),
                                                    child: Image.network(
                                                      member?.idProofFront ??
                                                          '',
                                                      width: 100.w,
                                                      fit: BoxFit.fill,
                                                    ),
                                                  ),
                                                ),
                                              )
                                              : InkWell(
                                                onTap: () {
                                                  frontImageCubit.pickImage();
                                                },
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: <Widget>[
                                                    SvgPicture.asset(
                                                      AppImage.uploadImage,
                                                    ),
                                                    const Gap(10),
                                                    const CustomText(
                                                      text: 'Upload Front Side',
                                                      fontSize: 12,
                                                    ),
                                                  ],
                                                ),
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
                                          backImage != null
                                              ? Stack(
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
                                              )
                                              : member?.idProofBack != null &&
                                                  (member?.idProofBack ?? '')
                                                      .isNotEmpty
                                              ? InkWell(
                                                onTap: () {
                                                  backImageCubit.pickImage();
                                                },
                                                child: Padding(
                                                  padding: const EdgeInsets.all(
                                                    20,
                                                  ),
                                                  child: ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                          12,
                                                        ),
                                                    child: Image.network(
                                                      member?.idProofBack ?? '',
                                                      width: 100.w,
                                                      fit: BoxFit.fill,
                                                    ),
                                                  ),
                                                ),
                                              )
                                              : InkWell(
                                                onTap: () {
                                                  backImageCubit.pickImage();
                                                },
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: <Widget>[
                                                    SvgPicture.asset(
                                                      AppImage.uploadImage,
                                                    ),
                                                    const Gap(10),
                                                    const CustomText(
                                                      text: 'Upload Back Side',
                                                      fontSize: 12,
                                                    ),
                                                  ],
                                                ),
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

                    BlocBuilder<VillageCubit, VillageState>(
                      builder: (context, state) {
                        if (state is VillageLoaded) {
                          villageName = state.villageName;
                          villageCode = state.villageCode;
                        }

                        return CustomButton(
                          text: 'Submit',
                          onTap:
                              addMember
                                  ? () {
                                    profileCubit.addMemberFamily(
                                      context,
                                      memberId: member?.id ?? 0,
                                      edit: edit,
                                      firstName: firstNameController.text,
                                      middleName: middleNameController.text,
                                      lastName: lastNameController.text,
                                      mobileNo: mobileController.text,
                                      email: emailController.text,
                                      address: addressController.text,

                                      oldMemberId:
                                          '${idNoController.text.length == 3 ? '0' : ''}${idNoController.text.trim()}$serialNoValue',
                                      gender:
                                          radioCubit.state == UserType.male
                                              ? 'Male'
                                              : 'Female',
                                      photo:
                                          profileImageCubit.state?.path ??
                                          member?.photo ??
                                          '',
                                      old: old,
                                      oldMemberIdCard:
                                          imageUploadCubit.state?.path ??
                                          member?.oldMemberIdCard ??
                                          '',
                                      idProofBack:
                                          backImageCubit.state?.path ??
                                          member?.idProofBack ??
                                          '',
                                      idProofFront:
                                          frontImageCubit.state?.path ??
                                          member?.idProofFront ??
                                          '',
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
                                      occupation: occupationController.text,
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
                                      villageName: villageName,
                                      villageCode: villageCode,
                                      oldMemberId:
                                          '${idNoController.text.length == 3 ? '0' : ''}${idNoController.text.trim()}$serialNoValue',
                                      gender:
                                          radioCubit.state == UserType.male
                                              ? 'Male'
                                              : 'Female',
                                      photo:
                                          profileImageCubit.state?.path ?? '',
                                      old: old,
                                      oldMemberIdCard:
                                          imageUploadCubit.state?.path ?? '',
                                      idProofBack:
                                          backImageCubit.state?.path ?? '',
                                      idProofFront:
                                          frontImageCubit.state?.path ?? '',
                                      language: language,
                                    );
                                  },
                        );
                      },
                    ),

                    if (addMember == false) ...[
                      Gap(32),
                      // customSignUpWith(),
                      // Gap(25),
                      // customGoogleAndAppleLogin(
                      //   googleOnTap: () {},
                      //   appleOnTap: () {},
                      // ),
                      // Gap(25),
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
