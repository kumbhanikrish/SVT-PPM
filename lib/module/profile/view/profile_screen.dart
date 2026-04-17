import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:svt_ppm/main.dart';
import 'package:svt_ppm/module/auth/cubit/auth_cubit.dart';
import 'package:svt_ppm/module/auth/model/auth_arguments.dart';
import 'package:svt_ppm/module/auth/model/login_model.dart';
import 'package:svt_ppm/module/home/cubit/home_cubit.dart';
import 'package:svt_ppm/utils/constant/app_page.dart';
import 'package:svt_ppm/utils/theme/colors.dart';
import 'package:svt_ppm/utils/widgets/custom_app_bar.dart';
import 'package:svt_ppm/utils/widgets/custom_image.dart';
import 'package:svt_ppm/utils/widgets/custom_success_dialog.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  List<LoginModel> noOfMemberList = [];

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<HomeCubit>().memberFamily(context, pageName: 'profile');
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // HomeCubit homeCubit = BlocProvider.of<HomeCubit>(context);
    // homeCubit.memberFamily(context, pageName: 'profile');

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(title: 'Profile', actions: []),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(right: 10, bottom: 20),
        child: FloatingActionButton(
          onPressed: () => _showAddMemberDialog(context),
          backgroundColor: AppColor.themePrimaryColor,
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: const Icon(Icons.add, color: AppColor.whiteColor, size: 32),
        ),
      ),
      body: ValueListenableBuilder<LoginModel?>(
        valueListenable: context.read<AuthCubit>().loginModelNotifier,
        builder: (context, model, child) {
          if (model == null) {
            return const Center(child: CircularProgressIndicator());
          }

          return SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildMainUserCard(model),
                const Gap(40),
                const Text(
                  "Family Members",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: AppColor.themePrimaryColor,
                  ),
                ),
                const Gap(24),
                BlocBuilder<HomeCubit, HomeState>(
                  builder: (context, state) {
                    if (state is GetHomeState) {
                      noOfMemberList = state.noOfMemberList;
                    }
                    if (noOfMemberList.isEmpty) {
                      return Center(
                        child: Padding(
                          padding: const EdgeInsets.only(top: 40),
                          child: Text(
                            "No family members added yet.",
                            style: TextStyle(color: Colors.grey.shade400),
                          ),
                        ),
                      );
                    }
                    return ListView.separated(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: noOfMemberList.length,
                      separatorBuilder: (context, index) => const Gap(16),
                      itemBuilder: (context, index) {
                        return _buildFamilyMemberCard(noOfMemberList[index]);
                      },
                    );
                  },
                ),
                const Gap(100),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildMainUserCard(LoginModel model) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Stack(
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(2),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: AppColor.themeSecondaryColor.withOpacity(0.5),
                    width: 1,
                  ),
                ),
                child: ClipOval(
                  child: CustomCachedImage(
                    imageUrl: model.photo,
                    height: 90,
                    width: 90,
                  ),
                ),
              ),
              const Gap(20),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      model.name.toUpperCase(),
                      softWrap: true,
                      overflow: TextOverflow.visible,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w900,
                        color: AppColor.themePrimaryColor,
                        height: 1.1,
                        letterSpacing: 0.5,
                      ),
                    ),
                    const Gap(8),
                    Text(
                      model.mobileNo ?? 'N/A',
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.grey.shade600,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const Gap(4),
                    Text(
                      model.memberId,
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey.shade500,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Positioned(
            bottom: 0,
            right: 0,
            child: IconButton(
              icon: Icon(
                Icons.edit_note_outlined,
                color: Colors.grey.shade400,
                size: 26,
              ),
              onPressed: () async {
                await Navigator.pushNamed(
                  context,
                  AppPage.editProfileScreen,
                  arguments: {'userData': model},
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFamilyMemberCard(LoginModel member) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(25),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 15,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Stack(
        children: [
          Row(
            children: [
              ClipOval(
                child: CustomCachedImage(
                  imageUrl: member.photo,
                  height: 60,
                  width: 60,
                ),
              ),
              const Gap(15),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      member.name.toUpperCase(),
                      softWrap: true,
                      overflow: TextOverflow.visible,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: AppColor.themePrimaryColor,
                      ),
                    ),
                    const Gap(6),
                    Text(
                      member.mobileNo ?? 'N/A',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey.shade500,
                      ),
                    ),
                    if (member.active == 0) ...[
                      const Gap(4),
                      Text(
                        "Pending Approval",
                        style: TextStyle(
                          fontSize: 11,
                          color: AppColor.redColor.withOpacity(0.8),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
              const Gap(10),
            ],
          ),
          Positioned(
            bottom: -15,
            right: 4,
            child: IconButton(
              icon: Icon(
                Icons.edit_note_outlined,
                color: Colors.grey.shade400,
                size: 26,
              ),
              onPressed: () {
                Navigator.pushNamed(
                  context,
                  AppPage.addMemberScreen,
                  arguments: AddMemberArgs(
                    addMember: true,
                    edit: true,
                    member: member,
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  void _showAddMemberDialog(BuildContext context) {
    showCustomDialog(
      context,
      title: 'Select Member Type',
      subTitle: 'Please select the Member option.',
      buttonText:
          'જો તમારી પાસે તાલુકાનું આઈડી કાર્ડ ન હોય તો અહીં ક્લિક કરો. (New Member)',
      button2Text:
          'જો તમારી પાસે તાલુકાનું ID કાર્ડ હોય તો અહીં ક્લિક કરો. (Old Member)',
      columnButton: true,
      showCloseIcon: true,
      onTap: () {
        Navigator.pushNamed(
          context,
          AppPage.addMemberScreen,
          arguments: AddMemberArgs(old: false, addMember: true),
        );
      },
      cancelOnTap: () {
        Navigator.pushNamed(
          context,
          AppPage.addMemberScreen,
          arguments: AddMemberArgs(old: true, addMember: true),
        );
      },
    );
  }
}
