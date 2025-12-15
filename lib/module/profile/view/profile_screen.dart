import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:svt_ppm/main.dart';
import 'package:svt_ppm/module/auth/cubit/auth_cubit.dart';
import 'package:svt_ppm/module/auth/model/login_model.dart';
import 'package:svt_ppm/module/home/cubit/home_cubit.dart';
import 'package:svt_ppm/utils/constant/app_image.dart';
import 'package:svt_ppm/utils/constant/app_page.dart';
import 'package:svt_ppm/utils/theme/colors.dart';
import 'package:svt_ppm/utils/widgets/custom_app_bar.dart';
import 'package:svt_ppm/utils/widgets/custom_button.dart';
import 'package:svt_ppm/utils/widgets/custom_filed_box.dart';
import 'package:svt_ppm/utils/widgets/custom_image.dart';
import 'package:svt_ppm/utils/widgets/custom_success_dialog.dart';
import 'package:svt_ppm/utils/widgets/custom_text.dart';
import 'package:svt_ppm/utils/widgets/custom_textfield.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final ValueNotifier<LoginModel?> loginModelNotifier = ValueNotifier(null);
  List<LoginModel> noOfMemberList = [];
  Future<void> loadLoginData() async {
    final model = await localDataSaver.getLoginModel();
    loginModelNotifier.value = model;
  }

  @override
  void initState() {
    loadLoginData();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    HomeCubit homeCubit = BlocProvider.of<HomeCubit>(context);
    AuthCubit authCubit = BlocProvider.of<AuthCubit>(context);

    homeCubit.memberFamily(context, pageName: 'profile');
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Profile',
        notificationOnTap: () {},

        leading: CustomIconButton(
          icon: Icons.arrow_back,
          color: AppColor.themePrimaryColor,
          onPressed: () {
            Navigator.pushNamedAndRemoveUntil(
              context,
              AppPage.homeScreen,
              (route) => false,
            );
          },
        ),
        actions: [
          CustomIconButton(
            color: AppColor.themePrimaryColor,
            icon: Icons.logout,
            onPressed: () {
              showCustomDialog(
                context,

                title: 'Logout',
                subTitle: 'Are you sure you want to logout?',
                buttonText: 'Logout',
                onTap: () {
                  Navigator.pop(context);
                  authCubit.logout(context);
                },
              );
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 25),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              ValueListenableBuilder<LoginModel?>(
                valueListenable: loginModelNotifier,
                builder: (
                  BuildContext context,
                  LoginModel? model,
                  Widget? child,
                ) {
                  log('model?.familyHeadId ::${model?.familyHeadId}');
                  String imageUrl = model?.photo ?? '';
                  return Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: AppColor.themeSecondaryColor,
                            width: 1,
                          ),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Stack(
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 18,
                              ),
                              child: Row(
                                children: [
                                  InkWell(
                                    onTap: () {
                                      Navigator.pushNamed(
                                        context,
                                        AppPage.editProfileScreen,
                                      );
                                    },
                                    child: ClipOval(
                                      child: CustomCachedImage(
                                        imageUrl: imageUrl,
                                        height: 80,
                                        width: 80,
                                      ),
                                    ),
                                  ),
                                  Gap(12),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        CustomText(
                                          text: model?.name ?? '',
                                          fontSize: 18,
                                          fontWeight: FontWeight.w600,
                                        ),
                                        Gap(7),
                                        CustomText(
                                          text: model?.mobileNo ?? '',
                                          fontSize: 12,
                                          fontWeight: FontWeight.w500,
                                          color: AppColor.hintColor,
                                        ),
                                        Gap(7),
                                        CustomText(
                                          text: model?.memberId ?? '',
                                          fontSize: 12,
                                          fontWeight: FontWeight.w500,
                                          color: AppColor.hintColor,
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            Positioned(
                              right: 0,
                              bottom: 0,
                              child: InkWell(
                                onTap: () {
                                  Navigator.pushNamed(
                                    context,
                                    AppPage.editProfileScreen,
                                    arguments: {'userData': model},
                                  );
                                },
                                child: ClipRRect(
                                  borderRadius: BorderRadius.only(
                                    bottomRight: Radius.circular(16),
                                  ),
                                  child: SvgPicture.asset(AppImage.editProfile),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Gap(30),
                      CustomFieldBox(
                        title: 'Family Members',
                        addButton: true,
                        addOnTap: () {
                          Navigator.pushNamed(
                            context,
                            AppPage.selectionScreen,
                            arguments: {'addMember': true},
                          );
                        },
                        children: [
                          BlocBuilder<HomeCubit, HomeState>(
                            builder: (context, state) {
                              if (state is GetHomeState) {
                                noOfMemberList = state.noOfMemberList;
                              }
                              return noOfMemberList.isEmpty
                                  ? CustomEmpty()
                                  : ListView.separated(
                                    shrinkWrap: true,
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    itemCount: noOfMemberList.length,
                                    separatorBuilder: (
                                      BuildContext context,
                                      int index,
                                    ) {
                                      return Gap(15);
                                    },
                                    itemBuilder: (
                                      BuildContext context,
                                      int index,
                                    ) {
                                      LoginModel member = noOfMemberList[index];
                                      return CustomTextField(
                                        hintText: member.name,
                                        labelText: '',
                                        prefixIcon: Padding(
                                          padding: const EdgeInsets.only(
                                            left: 10,
                                            top: 10,
                                            bottom: 10,
                                          ),
                                          child: ClipOval(
                                            child: CustomCachedImage(
                                              imageUrl: member.photo,
                                              width: 40,
                                              height: 40,
                                            ),
                                          ),
                                        ),
                                        readOnly: true,
                                        fillColor: AppColor.fillColor,
                                        borderColor: AppColor.transparentColor,
                                        suffixIcon:
                                            member.active == 0
                                                ? Row(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  children: [
                                                    Container(
                                                      decoration: BoxDecoration(
                                                        color: AppColor
                                                            .themePrimaryColor
                                                            .withOpacity(0.2),
                                                        borderRadius:
                                                            BorderRadius.circular(
                                                              8,
                                                            ),
                                                      ),
                                                      margin: EdgeInsets.only(
                                                        right: 10,
                                                      ),
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                            horizontal: 8,
                                                            vertical: 4,
                                                          ),
                                                      child: CustomText(
                                                        text: 'Pending',
                                                        fontSize: 10,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                      ),
                                                    ),
                                                  ],
                                                )
                                                : Row(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  children: [
                                                    InkWell(
                                                      onTap: () {
                                                        Navigator.pushNamed(
                                                          context,
                                                          AppPage.signupScreen,
                                                          arguments: {
                                                            'addMember': true,
                                                            'edit': true,
                                                            'member': member,
                                                          },
                                                        );
                                                      },
                                                      child: SvgPicture.asset(
                                                        AppImage.editMember,
                                                      ),
                                                    ),
                                                    Gap(10),
                                                    InkWell(
                                                      onTap: () {
                                                        log(
                                                          'member.memberFamilyCard ::${member.memberFamilyCard}',
                                                        );
                                                        Navigator.pushNamed(
                                                          context,
                                                          AppPage
                                                              .showProofScreen,
                                                          arguments: {
                                                            'memberFamilyCard':
                                                                member
                                                                    .memberFamilyCard,
                                                          },
                                                        );
                                                      },
                                                      child: SvgPicture.asset(
                                                        AppImage.memberId,
                                                      ),
                                                    ),
                                                    Gap(10),
                                                  ],
                                                ),
                                      );
                                    },
                                  );
                            },
                          ),
                        ],
                      ),
                    ],
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
