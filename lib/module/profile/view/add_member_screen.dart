import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:image_picker/image_picker.dart';
import 'package:svt_ppm/module/auth/cubit/auth_cubit.dart';
import 'package:svt_ppm/module/auth/model/login_model.dart';
import 'package:svt_ppm/module/profile/cubit/profile_cubit.dart';
import 'package:svt_ppm/utils/constant/app_list.dart';
import 'package:svt_ppm/utils/constant/app_image.dart';
import 'package:svt_ppm/utils/theme/colors.dart';
import 'package:svt_ppm/utils/widgets/custom_app_bar.dart';
import 'package:svt_ppm/utils/widgets/custom_button.dart';
import 'package:svt_ppm/utils/widgets/custom_text.dart';
import 'package:svt_ppm/utils/widgets/custom_textfield.dart';
import 'package:svt_ppm/utils/enum/enums.dart';

class AddMemberScreen extends StatefulWidget {
  final dynamic data;
  const AddMemberScreen({super.key, required this.data});

  @override
  State<AddMemberScreen> createState() => _AddMemberScreenState();
}

class _AddMemberScreenState extends State<AddMemberScreen> {
  TextEditingController firstNameController = TextEditingController();
  TextEditingController middleNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController mobileController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController idNoController = TextEditingController();
  TextEditingController occupationController = TextEditingController();

  String serialNoValue = '';
  bool old = false;
  bool addMember = false;
  bool edit = false;
  LoginModel? member;

  @override
  void initState() {
    super.initState();
    old = widget.data['old'] ?? false;
    addMember = widget.data['addMember'] ?? false;
    edit = widget.data['edit'] ?? false;
    member = widget.data['member'] as LoginModel?;

    if (edit && member != null) {
      firstNameController.text = member?.firstName ?? '';
      middleNameController.text = member?.middleName ?? '';
      lastNameController.text = member?.lastName ?? '';
      mobileController.text = member?.mobileNo ?? '';
      emailController.text = member?.email ?? '';
      addressController.text = member?.address ?? '';
      occupationController.text = member?.occupation ?? '';

      if ((member?.oldMemberId ?? '').length >= 1) {
        String oldId = member?.oldMemberId ?? '';
        serialNoValue = oldId.substring(0, 1);
        if (oldId.length > 1) {
          idNoController.text = oldId.substring(1);
        }
      }

      WidgetsBinding.instance.addPostFrameCallback((_) {
        context.read<RadioCubit>().selectUserType(
          member?.gender?.toLowerCase() == 'male'
              ? UserType.male
              : UserType.female,
        );
        context.read<SelectRelationCubit>().updateValue(
          relationValue: member?.relation ?? '',
        );
        context.read<SelectStandardCubit>().updateValue(
          standardValue: member?.standard ?? '',
        );
      });
    }

    context.read<RadioCubit>().init();
    context.read<SelectRelationCubit>().init();
    context.read<SelectStandardCubit>().init();
    context.read<ImageUploadCubit>().removeImage();
    context.read<ProfileImageCubit>().removeImage();
    context.read<FrontImageCubit>().removeImage();
    context.read<BackImageCubit>().removeImage();
  }

  @override
  Widget build(BuildContext context) {
    RadioCubit radioCubit = context.watch<RadioCubit>();
    FrontImageCubit frontImageCubit = context.watch<FrontImageCubit>();
    BackImageCubit backImageCubit = context.watch<BackImageCubit>();
    ProfileImageCubit profileImageCubit = context.watch<ProfileImageCubit>();
    ImageUploadCubit imageUploadCubit = context.watch<ImageUploadCubit>();
    SelectRelationCubit selectRelationCubit =
        context.watch<SelectRelationCubit>();
    SelectStandardCubit selectStandardCubit =
        context.watch<SelectStandardCubit>();
    ProfileCubit profileCubit = context.read<ProfileCubit>();

    return Scaffold(
      backgroundColor: AppColor.whiteColor,
      appBar: CustomAppBar(
        title: edit ? 'Edit Member' : 'Add Member',
        actions: [],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Stack(
                  children: [
                    Container(
                      height: 120,
                      width: 120,
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
                                : (member?.photo ?? '').isNotEmpty
                                ? Image.network(
                                  member!.photo,
                                  fit: BoxFit.cover,
                                )
                                : Image.asset(AppImage.user, fit: BoxFit.cover),
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: CircleAvatar(
                        backgroundColor: AppColor.themePrimaryColor,
                        radius: 18,
                        child: IconButton(
                          icon: const Icon(
                            Icons.camera_alt,
                            size: 18,
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
              const Gap(25),
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
              Row(
                children: [
                  Expanded(
                    child: RadioListTile<UserType>(
                      title: const Text('Male'),
                      value: UserType.male,
                      groupValue: radioCubit.state,
                      onChanged: (val) => radioCubit.selectUserType(val!),
                    ),
                  ),
                  Expanded(
                    child: RadioListTile<UserType>(
                      title: const Text('Female'),
                      value: UserType.female,
                      groupValue: radioCubit.state,
                      onChanged: (val) => radioCubit.selectUserType(val!),
                    ),
                  ),
                ],
              ),
              const Gap(20),
              CustomDropWonFiled<String>(
                title: 'Relation',
                hintText: 'Select Relation',
                items: relationList,
                text: selectRelationCubit.state,
                onChanged:
                    (val) => selectRelationCubit.updateValue(
                      relationValue: val ?? '',
                    ),
              ),
              const Gap(20),
              CustomDropWonFiled<String>(
                title: 'Education/Standard',
                hintText: 'Select Standard',
                items: standardList,
                text: selectStandardCubit.state,
                onChanged:
                    (val) => selectStandardCubit.updateValue(
                      standardValue: val ?? '',
                    ),
              ),
              const Gap(20),
              CustomTextField(
                labelText: 'Occupation',
                hintText: 'Enter Occupation',
                controller: occupationController,
                textCapitalization: TextCapitalization.characters,
              ),
              const Gap(20),
              if (old) ...[
                Row(
                  children: [
                    Expanded(
                      child: CustomDropWonFiled<String>(
                        title: 'Serial No.',
                        hintText: 'Select',
                        items: serialNoList,
                        text: serialNoValue,
                        onChanged:
                            (val) => setState(() => serialNoValue = val ?? ''),
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
                      ),
                    ),
                  ],
                ),
                const Gap(20),
                const CustomText(
                  text: 'Old Member ID Card',
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
                const Gap(10),
                _buildImageUpload(
                  cubit: imageUploadCubit,
                  title: 'Upload ID Card',
                  existingUrl: member?.oldMemberIdCard,
                ),
              ] else ...[
                const CustomText(
                  text: 'ID Proof (Front)',
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
                const Gap(10),
                _buildImageUpload(
                  cubit: frontImageCubit,
                  title: 'Upload Front Side',
                  existingUrl: member?.idProofFront,
                ),
                const Gap(20),
                const CustomText(
                  text: 'ID Proof (Back)',
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
                const Gap(10),
                _buildImageUpload(
                  cubit: backImageCubit,
                  title: 'Upload Back Side',
                  existingUrl: member?.idProofBack,
                ),
              ],
              const Gap(40),
              CustomButton(
                text: edit ? 'Update Member' : 'Add Member',
                onTap: () {
                  profileCubit.addMemberFamily(
                    context,
                    memberId: member?.id ?? 0,
                    edit: edit,
                    firstName: firstNameController.text.trim(),
                    middleName: middleNameController.text.trim(),
                    lastName: lastNameController.text.trim(),
                    mobileNo: mobileController.text.trim(),
                    email: emailController.text.trim(),
                    address: addressController.text.trim(),
                    oldMemberId:
                        old
                            ? '$serialNoValue${idNoController.text.trim()}'
                            : '',
                    gender:
                        radioCubit.state == UserType.male ? 'Male' : 'Female',
                    photo: profileImageCubit.state?.path ?? member?.photo ?? '',
                    old: old,
                    oldMemberIdCard:
                        imageUploadCubit.state?.path ??
                        member?.oldMemberIdCard ??
                        '',
                    idProofBack:
                        backImageCubit.state?.path ?? member?.idProofBack ?? '',
                    idProofFront:
                        frontImageCubit.state?.path ??
                        member?.idProofFront ??
                        '',
                    relation: selectRelationCubit.state.toLowerCase(),
                    standard: selectStandardCubit.state.toLowerCase(),
                    occupation: occupationController.text.trim(),
                  );
                },
              ),
              const Gap(20),
            ],
          ),
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
                  child: Image.network(
                    existingUrl,
                    fit: BoxFit.cover,
                    width: double.infinity,
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
