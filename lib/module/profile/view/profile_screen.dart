// import 'dart:developer';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:gap/gap.dart';
// import 'package:svt_ppm/main.dart';
// import 'package:svt_ppm/module/auth/model/login_model.dart';
// import 'package:svt_ppm/module/home/cubit/home_cubit.dart';
// import 'package:svt_ppm/utils/constant/app_image.dart';
// import 'package:svt_ppm/utils/constant/app_page.dart';
// import 'package:svt_ppm/utils/theme/colors.dart';
// import 'package:svt_ppm/utils/widgets/custom_app_bar.dart';
// import 'package:svt_ppm/utils/widgets/custom_filed_box.dart';
// import 'package:svt_ppm/utils/widgets/custom_image.dart';
// import 'package:svt_ppm/utils/widgets/custom_text.dart';
//
// class ProfileScreen extends StatefulWidget {
//   const ProfileScreen({super.key});
//
//   @override
//   State<ProfileScreen> createState() => _ProfileScreenState();
// }
//
// class _ProfileScreenState extends State<ProfileScreen> {
//   final ValueNotifier<LoginModel?> loginModelNotifier = ValueNotifier(null);
//   List<LoginModel> noOfMemberList = [];
//
//   Future<void> loadLoginData() async {
//     final model = await localDataSaver.getLoginModel();
//     loginModelNotifier.value = model;
//   }
//
//   @override
//   void initState() {
//     loadLoginData();
//     super.initState();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     HomeCubit homeCubit = BlocProvider.of<HomeCubit>(context);
//     homeCubit.memberFamily(context, pageName: 'profile');
//
//     return Scaffold(
//       appBar: CustomAppBar(
//         title: 'Profile',
//         notificationOnTap: () {},
//         leading: IconButton(
//           icon: const Icon(Icons.arrow_back, color: Colors.white),
//           onPressed: () {
//             if (Navigator.canPop(context)) {
//               Navigator.pop(context);
//             } else {
//               Navigator.pushReplacementNamed(context, AppPage.homeScreen);
//             }
//           },
//         ),
//         actions: const [],
//       ),
//       body: Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 25),
//         child: SingleChildScrollView(
//           child: Column(
//             children: <Widget>[
//               ValueListenableBuilder<LoginModel?>(
//                 valueListenable: loginModelNotifier,
//                 builder: (
//                     BuildContext context,
//                     LoginModel? model,
//                     Widget? child,
//                     ) {
//                   log('model?.familyHeadId ::${model?.familyHeadId}');
//                   String imageUrl = model?.photo ?? '';
//                   return Column(
//                     children: [
//                       Container(
//                         decoration: BoxDecoration(
//                           border: Border.all(
//                             color: AppColor.themeSecondaryColor,
//                             width: 1,
//                           ),
//                           borderRadius: BorderRadius.circular(16),
//                         ),
//                         child: Stack(
//                           children: [
//                             Padding(
//                               padding: const EdgeInsets.symmetric(
//                                 horizontal: 12,
//                                 vertical: 18,
//                               ),
//                               child: Row(
//                                 children: [
//                                   InkWell(
//                                     onTap: () {
//                                       Navigator.pushNamed(
//                                         context,
//                                         AppPage.editProfileScreen,
//                                         arguments: {'userData': model},
//                                       );
//                                     },
//                                     child: ClipOval(
//                                       child: CustomCachedImage(
//                                         imageUrl: imageUrl,
//                                         height: 80,
//                                         width: 80,
//                                       ),
//                                     ),
//                                   ),
//                                   Gap(12),
//                                   Expanded(
//                                     child: Column(
//                                       crossAxisAlignment:
//                                       CrossAxisAlignment.start,
//                                       mainAxisAlignment:
//                                       MainAxisAlignment.center,
//                                       children: [
//                                         InkWell(
//                                           onTap: () {
//                                             Navigator.pushNamed(
//                                               context,
//                                               AppPage.editProfileScreen,
//                                               arguments: {'userData': model},
//                                             );
//                                           },
//                                           child: CustomText(
//                                             text: model?.name ?? '',
//                                             fontSize: 18,
//                                             fontWeight: FontWeight.w600,
//                                             color: AppColor.themePrimaryColor,
//                                           ),
//                                         ),
//                                         Gap(7),
//                                         CustomText(
//                                           text: model?.mobileNo ?? '',
//                                           fontSize: 12,
//                                           fontWeight: FontWeight.w500,
//                                           color: AppColor.hintColor,
//                                         ),
//                                         Gap(7),
//                                         CustomText(
//                                           text: model?.memberId ?? '',
//                                           fontSize: 12,
//                                           fontWeight: FontWeight.w500,
//                                           color: AppColor.hintColor,
//                                         ),
//                                       ],
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                             Positioned(
//                               right: 0,
//                               bottom: 0,
//                               child: InkWell(
//                                 onTap: () {
//                                   Navigator.pushNamed(
//                                     context,
//                                     AppPage.editProfileScreen,
//                                     arguments: {'userData': model},
//                                   );
//                                 },
//                                 child: ClipRRect(
//                                   borderRadius: BorderRadius.only(
//                                     bottomRight: Radius.circular(16),
//                                   ),
//                                   child: SvgPicture.asset(AppImage.editProfile),
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//
//                       Gap(30),
//                       CustomFieldBox(
//                         title: 'Family Members',
//                         addButton: true,
//                         addOnTap: () {
//                           Navigator.pushNamed(
//                             context,
//                             AppPage.selectionScreen,
//                             arguments: {'addMember': true},
//                           );
//                         },
//                         children: [
//                           BlocBuilder<HomeCubit, HomeState>(
//                             builder: (context, state) {
//                               if (state is GetHomeState) {
//                                 noOfMemberList = state.noOfMemberList;
//                               }
//                               return noOfMemberList.isEmpty
//                                   ? CustomEmpty()
//                                   : ListView.separated(
//                                 shrinkWrap: true,
//                                 physics:
//                                 const NeverScrollableScrollPhysics(),
//                                 itemCount: noOfMemberList.length,
//                                 separatorBuilder: (
//                                     BuildContext context,
//                                     int index,
//                                     ) {
//                                   return Gap(15);
//                                 },
//                                 itemBuilder: (
//                                     BuildContext context,
//                                     int index,
//                                     ) {
//                                   LoginModel member = noOfMemberList[index];
//
//                                   return Stack(
//                                     children: [
//                                       InkWell(
//                                         onTap: () {
//                                           Navigator.pushNamed(
//                                             context,
//                                             AppPage.signupScreen,
//                                             arguments: {
//                                               'addMember': true,
//                                               'edit': true,
//                                               'member': member,
//                                             },
//                                           );
//                                         },
//                                         child: Container(
//                                           padding:
//                                           const EdgeInsets.symmetric(
//                                             horizontal: 10,
//                                             vertical: 5,
//                                           ),
//                                           decoration: BoxDecoration(
//                                             color: AppColor.fillColor,
//                                             borderRadius:
//                                             BorderRadius.circular(8),
//                                           ),
//                                           child: Row(
//                                             children: [
//                                               // Image
//                                               ClipOval(
//                                                 child: CustomCachedImage(
//                                                   imageUrl: member.photo,
//                                                   width: 60,
//                                                   height: 60,
//                                                 ),
//                                               ),
//                                               const Gap(15),
//                                               Expanded(
//                                                 child: Text(
//                                                   member.name,
//                                                   maxLines: 1,
//                                                   overflow:
//                                                   TextOverflow.ellipsis,
//                                                   style: TextStyle(
//                                                     fontSize: 16,
//                                                     fontWeight:
//                                                     FontWeight.w600,
//                                                     color:
//                                                     AppColor
//                                                         .themePrimaryColor,
//                                                     fontFamily: 'Poppins',
//                                                   ),
//                                                 ),
//                                               ),
//
//                                               if (member.active == 0)
//                                                 Container(
//                                                   margin:
//                                                   const EdgeInsets.only(
//                                                     right: 35,
//                                                   ),
//                                                   padding:
//                                                   const EdgeInsets.symmetric(
//                                                     horizontal: 8,
//                                                     vertical: 4,
//                                                   ),
//                                                   decoration: BoxDecoration(
//                                                     color: AppColor
//                                                         .themePrimaryColor
//                                                         .withOpacity(0.2),
//                                                     borderRadius:
//                                                     BorderRadius.circular(
//                                                       8,
//                                                     ),
//                                                   ),
//                                                   child: CustomText(
//                                                     text: 'Pending',
//                                                     fontSize: 10,
//                                                     fontWeight:
//                                                     FontWeight.w500,
//                                                   ),
//                                                 ),
//                                             ],
//                                           ),
//                                         ),
//                                       ),
//
//                                       // Blue Edit Icon
//                                       Positioned(
//                                         right: 0,
//                                         bottom: 0,
//                                         child: InkWell(
//                                           onTap: () {
//                                             Navigator.pushNamed(
//                                               context,
//                                               AppPage.signupScreen,
//                                               arguments: {
//                                                 'addMember': true,
//                                                 'edit': true,
//                                                 'member': member,
//                                               },
//                                             );
//                                           },
//                                           child: ClipRRect(
//                                             borderRadius: BorderRadius.only(
//                                               bottomRight: Radius.circular(
//                                                 8,
//                                               ),
//                                             ),
//                                             child: SvgPicture.asset(
//                                               AppImage.editProfile,
//                                               height: 24,
//                                             ),
//                                           ),
//                                         ),
//                                       ),
//                                     ],
//                                   );
//                                 },
//                               );
//                             },
//                           ),
//                         ],
//                       ),
//                     ],
//                   );
//                 },
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:svt_ppm/main.dart';
import 'package:svt_ppm/module/auth/model/login_model.dart';
import 'package:svt_ppm/module/home/cubit/home_cubit.dart';
import 'package:svt_ppm/utils/constant/app_image.dart';
import 'package:svt_ppm/utils/constant/app_page.dart';
import 'package:svt_ppm/utils/theme/colors.dart';
import 'package:svt_ppm/utils/widgets/custom_app_bar.dart';
import 'package:svt_ppm/utils/widgets/custom_filed_box.dart';
import 'package:svt_ppm/utils/widgets/custom_image.dart';
import 'package:svt_ppm/utils/widgets/custom_text.dart';

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
    // AuthCubit ની હવે જરૂર નથી કારણ કે Logout બટન કાઢી નાખ્યું છે,
    // પણ ભવિષ્યમાં જરૂર પડે તો અહીં રહેવા દઈ શકો છો.

    homeCubit.memberFamily(context, pageName: 'profile');

    return Scaffold(
      appBar: CustomAppBar(
        title: 'Profile',
        notificationOnTap: () {},

        actions: const [],
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
                                        arguments: {'userData': model},
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
                                        InkWell(
                                          onTap: () {
                                            Navigator.pushNamed(
                                              context,
                                              AppPage.editProfileScreen,
                                              arguments: {'userData': model},
                                            );
                                          },
                                          child: CustomText(
                                            text: model?.name ?? '',
                                            fontSize: 18,
                                            fontWeight: FontWeight.w600,
                                            color: AppColor.themePrimaryColor,
                                          ),
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

                                      return Stack(
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
                                            child: Container(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                    horizontal: 10,
                                                    vertical: 5,
                                                  ),
                                              decoration: BoxDecoration(
                                                color: AppColor.fillColor,
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                              ),
                                              child: Row(
                                                children: [
                                                  // Image
                                                  ClipOval(
                                                    child: CustomCachedImage(
                                                      imageUrl: member.photo,
                                                      width: 60,
                                                      height: 60,
                                                    ),
                                                  ),
                                                  const Gap(15),
                                                  Expanded(
                                                    child: Text(
                                                      member.name,
                                                      maxLines: 1,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      style: TextStyle(
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        color:
                                                            AppColor
                                                                .themePrimaryColor,
                                                        fontFamily: 'Poppins',
                                                      ),
                                                    ),
                                                  ),

                                                  if (member.active == 0)
                                                    Container(
                                                      margin:
                                                          const EdgeInsets.only(
                                                            right: 35,
                                                          ),
                                                      padding:
                                                          const EdgeInsets.symmetric(
                                                            horizontal: 8,
                                                            vertical: 4,
                                                          ),
                                                      decoration: BoxDecoration(
                                                        color: AppColor
                                                            .themePrimaryColor
                                                            .withOpacity(0.2),
                                                        borderRadius:
                                                            BorderRadius.circular(
                                                              8,
                                                            ),
                                                      ),
                                                      child: CustomText(
                                                        text: 'Pending',
                                                        fontSize: 10,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                      ),
                                                    ),
                                                ],
                                              ),
                                            ),
                                          ),

                                          // Blue Edit Icon
                                          Positioned(
                                            right: 0,
                                            bottom: 0,
                                            child: InkWell(
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
                                              child: ClipRRect(
                                                borderRadius: BorderRadius.only(
                                                  bottomRight: Radius.circular(
                                                    8,
                                                  ),
                                                ),
                                                child: SvgPicture.asset(
                                                  AppImage.editProfile,
                                                  height: 24,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      );
                                    },
                                  );
                            },
                          ),
                        ],
                      ),
                      Gap(100),
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
