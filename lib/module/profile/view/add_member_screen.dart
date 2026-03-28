import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:image_picker/image_picker.dart';
import 'package:svt_ppm/module/auth/cubit/auth_cubit.dart';
import 'package:svt_ppm/module/auth/model/auth_arguments.dart';
import 'package:svt_ppm/module/auth/model/login_model.dart';
import 'package:svt_ppm/module/profile/cubit/profile_cubit.dart';
import 'package:svt_ppm/utils/constant/app_list.dart';
import 'package:svt_ppm/utils/constant/app_image.dart';
import 'package:svt_ppm/utils/theme/colors.dart';
import 'package:svt_ppm/utils/widgets/custom_app_bar.dart';
import 'package:svt_ppm/utils/widgets/custom_button.dart';
import 'package:svt_ppm/utils/widgets/custom_text.dart';
import 'package:svt_ppm/utils/widgets/custom_textfield.dart';
import 'package:svt_ppm/utils/widgets/custom_radio_list_tile.dart';
import 'package:svt_ppm/utils/enum/enums.dart';

class AddMemberScreen extends StatefulWidget {
  final AddMemberArgs args;
  const AddMemberScreen({super.key, required this.args});

  @override
  State<AddMemberScreen> createState() => _AddMemberScreenState();
}

class _AddMemberScreenState extends State<AddMemberScreen> {
  TextEditingController firstNameController = TextEditingController();
  TextEditingController middleNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController mobileController = TextEditingController();
  TextEditingController whatsappController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController idNoController = TextEditingController();
  TextEditingController occupationController = TextEditingController();
  TextEditingController otherDegreeController = TextEditingController();

  String serialNoValue = '';
  bool old = false;
  bool addMember = false;
  bool edit = false;
  bool isSameAsMobile = false;
  LoginModel? member;
  String educationValue = '';
  String bloodGroupValue = '';
  String degreeValue = '';
  String standardValue = '';
  String relationValue = '';

  @override
  void initState() {
    super.initState();
    old = widget.args.old;
    addMember = widget.args.addMember;
    edit = widget.args.edit;
    member = widget.args.member;

    if (edit && member != null) {
      firstNameController.text = member?.firstName ?? '';
      middleNameController.text = member?.middleName ?? '';
      lastNameController.text = member?.lastName ?? '';
      mobileController.text = member?.mobileNo ?? '';
      whatsappController.text = member?.whatsappNo ?? '';
      emailController.text = member?.email ?? '';
      addressController.text = member?.address ?? '';
      occupationController.text = member?.occupation ?? '';
      educationValue = educationList.firstWhere(
        (e) => e.toLowerCase() == (member?.education ?? '').toLowerCase(),
        orElse: () => member?.education ?? '',
      );
      bloodGroupValue = bloodGroupList.firstWhere(
        (e) => e.toLowerCase() == (member?.bloodGroup ?? '').toLowerCase(),
        orElse: () => member?.bloodGroup ?? '',
      );
      standardValue = standardList.firstWhere(
        (e) => e.toLowerCase() == (member?.standard ?? '').toLowerCase(),
        orElse: () => member?.standard ?? '',
      );
      relationValue = relationList.firstWhere(
        (e) => e.toLowerCase() == (member?.relation ?? '').toLowerCase(),
        orElse: () => member?.relation ?? '',
      );
      degreeValue = member?.degree ?? '';

      // Check if degree is in the list, if not it might be "Other"
      if (degreeValue.isNotEmpty) {
        bool isGraduate = educationValue == 'Graduate';
        List<String> currentDegrees =
            isGraduate ? undergraduateDegrees : postgraduateDegrees;
        if (educationValue == 'Graduate' || educationValue == 'Post Graduate') {
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
      if ((member?.mobileNo ?? '').isNotEmpty &&
          member?.mobileNo == member?.whatsappNo) {
        setState(() {
          isSameAsMobile = true;
        });
      }

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
      });
    }

    context.read<RadioCubit>().init();
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
    ProfileCubit profileCubit = context.read<ProfileCubit>();

    return Scaffold(
      backgroundColor: AppColor.whiteColor,
      appBar: CustomAppBar(
        title:
            edit
                ? 'Edit Member'
                : old
                ? 'Add Old Member'
                : 'Add New Member',
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
              const Gap(10),
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
                          onTap: () => radioCubit.selectUserType(UserType.male),
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
                              () => radioCubit.selectUserType(UserType.female),
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
                  initialItem: degreeValue,
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
              if (old == true) ...[
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
                    whatsappNo: whatsappController.text.trim(),
                    email: emailController.text.trim(),
                    address: addressController.text.trim(),
                    education: educationValue,
                    degree:
                        degreeValue == 'Other (Type New)'
                            ? otherDegreeController.text.trim()
                            : degreeValue,
                    bloodGroup: bloodGroupValue,
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
                    relation: relationValue.toLowerCase(),
                    standard: standardValue,
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
