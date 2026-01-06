// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:gap/gap.dart';
// import 'package:qr_flutter/qr_flutter.dart';
// import 'package:svt_ppm/main.dart';
// import 'package:svt_ppm/module/auth/model/login_model.dart';
// import 'package:svt_ppm/module/home/cubit/home_cubit.dart';
// import 'package:svt_ppm/module/profile/view/widget/custom_profile_widget.dart';
// import 'package:svt_ppm/utils/constant/app_page.dart';
// import 'package:svt_ppm/utils/theme/colors.dart';
// import 'package:svt_ppm/utils/widgets/custom_app_bar.dart';
// import 'package:svt_ppm/utils/widgets/custom_image.dart';
// import 'package:svt_ppm/utils/widgets/custom_text.dart';
//
// class QrProfileScreen extends StatefulWidget {
//   const QrProfileScreen({super.key});
//
//   @override
//   State<QrProfileScreen> createState() => _QrProfileScreenState();
// }
//
// class _QrProfileScreenState extends State<QrProfileScreen> {
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
//     HomeCubit homeCubit = BlocProvider.of<HomeCubit>(context);
//     homeCubit.memberFamily(context, pageName: 'profile');
//     super.initState();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: CustomAppBar(title: 'My QR Profile', actions: []),
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 25),
//           child: ValueListenableBuilder<LoginModel?>(
//             valueListenable: loginModelNotifier,
//             builder: (context, userModel, child) {
//               if (userModel == null) return const SizedBox();
//
//               return BlocBuilder<HomeCubit, HomeState>(
//                 builder: (context, state) {
//                   if (state is GetHomeState) {
//                     noOfMemberList = state.noOfMemberList;
//                   }
//                   Map<String, dynamic> headMemberData = {
//                     "id": userModel.id,
//                     "name": userModel.name,
//                     "mobile": userModel.mobileNo,
//                     "member_id": userModel.memberId,
//                     "type": "Head Member",
//                   };
//                   String headQrString = jsonEncode(headMemberData);
//
//                   return Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       CustomText(
//                         text: "Main Member",
//                         fontSize: 16,
//                         fontWeight: FontWeight.bold,
//                         color: AppColor.themePrimaryColor,
//                       ),
//                       const Gap(10),
//
//                       _buildQrCard(
//                         name: userModel.name,
//                         photo: userModel.photo,
//                         mobile: userModel.mobileNo,
//                         memberId: userModel.memberId,
//                         qrData: headQrString,
//                         memberFamilyCard: userModel.memberFamilyCard,
//                       ),
//
//                       const Gap(30),
//                       if (noOfMemberList.isNotEmpty) ...[
//                         Center(
//                           child: CustomText(
//                             text: "Family Members",
//                             fontSize: 16,
//                             fontWeight: FontWeight.bold,
//                             color: AppColor.themePrimaryColor,
//                           ),
//                         ),
//                         const Gap(10),
//
//                         ListView.separated(
//                           shrinkWrap: true,
//                           physics: const NeverScrollableScrollPhysics(),
//                           itemCount: noOfMemberList.length,
//                           separatorBuilder: (context, index) => const Gap(20),
//                           itemBuilder: (context, index) {
//                             LoginModel member = noOfMemberList[index];
//                             Map<String, dynamic> memberData = {
//                               "id": member.id,
//                               "name": member.name,
//                               "relation": member.relation,
//                               "member_id": member.memberId,
//                               "head_id": userModel.memberId,
//                               "type": "Family Member",
//                             };
//                             String memberQrString = jsonEncode(memberData);
//
//                             return _buildQrCard(
//                               name: member.name,
//                               photo: member.photo,
//                               mobile: member.mobileNo ?? "",
//                               memberId: member.memberId,
//                               qrData: memberQrString,
//                               memberFamilyCard: member.memberFamilyCard,
//                             );
//                           },
//                         ),
//                       ] else ...[
//                         CustomEmpty(),
//                       ],
//
//                       const Gap(30),
//                     ],
//                   );
//                 },
//               );
//             },
//           ),
//         ),
//       ),
//     );
//   }
//
//   Widget _buildQrCard({
//     required String name,
//     required String photo,
//     required String mobile,
//     required String memberId,
//     required String qrData,
//     required String memberFamilyCard,
//   }) {
//     return Container(
//       padding: const EdgeInsets.all(16),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(16),
//         border: Border.all(color: AppColor.themeSecondaryColor, width: 1),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.grey.withOpacity(0.15),
//             blurRadius: 10,
//             spreadRadius: 2,
//             offset: const Offset(0, 4),
//           ),
//         ],
//       ),
//       child: Column(
//         children: [
//           Row(
//             mainAxisAlignment: MainAxisAlignment.center,
//             crossAxisAlignment: CrossAxisAlignment.center,
//             children: [
//               InkWell(
//                 onTap:
//                     () => showImageDialog(context, imageUrl: photo, name: name),
//                 child: Container(
//                   decoration: BoxDecoration(
//                     border: Border.all(
//                       color: AppColor.themeSecondaryColor,
//                       width: 3,
//                     ),
//                     shape: BoxShape.circle,
//                   ),
//                   child: ClipOval(
//                     child: CustomCachedImage(
//                       imageUrl: photo,
//                       height: 130,
//                       width: 130,
//                     ),
//                   ),
//                 ),
//               ),
//
//               const Gap(15),
//
//               InkWell(
//                 onTap:
//                     () => showQrDialog(
//                   context,
//                   qrData: qrData,
//                   name: name,
//                   memberId: memberId,
//                 ),
//                 child: Container(
//                   height: 130,
//                   width: 130,
//                   decoration: BoxDecoration(
//                     color: Colors.white,
//                     borderRadius: BorderRadius.circular(8),
//                     border: Border.all(color: Colors.grey.shade300, width: 1),
//                   ),
//                   child: Center(
//                     child: QrImageView(
//                       data: qrData,
//                       version: QrVersions.auto,
//                       size: 120.0,
//                       gapless: true,
//                       padding: const EdgeInsets.all(5),
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//
//           const Gap(20),
//           const Divider(thickness: 1, height: 1),
//           const Gap(15),
//
//           InkWell(
//             onTap: () {
//               if (memberFamilyCard.isNotEmpty) {
//                 Navigator.pushNamed(
//                   context,
//                   AppPage.showProofScreen,
//                   arguments: {
//                     'memberFamilyCard': memberFamilyCard,
//                   },
//                 );
//               } else {
//                 ScaffoldMessenger.of(context).showSnackBar(
//                   const SnackBar(content: Text("No ID Card Found")),
//                 );
//               }
//             },
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Flexible(
//                   child: Text(
//                     name,
//                     maxLines: 1,
//                     overflow: TextOverflow.ellipsis,
//                     textAlign: TextAlign.center,
//                     style: TextStyle(
//                       fontSize: 20,
//                       fontWeight: FontWeight.w600,
//                       color: AppColor.themePrimaryColor,
//                       fontFamily: 'Poppins',
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//
//           const Gap(10),
//
//           Row(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               if (mobile.isNotEmpty) ...[
//                 Icon(Icons.phone, size: 16, color: AppColor.hintColor),
//                 const Gap(5),
//                 CustomText(
//                   text: mobile,
//                   fontSize: 14,
//                   fontWeight: FontWeight.w500,
//                   color: AppColor.hintColor,
//                 ),
//                 Container(
//                   margin: const EdgeInsets.symmetric(horizontal: 10),
//                   height: 15,
//                   width: 1,
//                   color: Colors.grey,
//                 ),
//               ],
//
//               Container(
//                 padding: const EdgeInsets.symmetric(
//                   horizontal: 10,
//                   vertical: 4,
//                 ),
//                 decoration: BoxDecoration(
//                   color: AppColor.themePrimaryColor.withOpacity(0.1),
//                   borderRadius: BorderRadius.circular(8),
//                 ),
//                 child: CustomText(
//                   text: "ID: $memberId",
//                   fontSize: 12,
//                   fontWeight: FontWeight.w600,
//                   color: AppColor.themePrimaryColor,
//                 ),
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
// }
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:svt_ppm/main.dart';
import 'package:svt_ppm/module/auth/model/login_model.dart';
import 'package:svt_ppm/module/home/cubit/home_cubit.dart';
import 'package:svt_ppm/utils/constant/app_page.dart';
import 'package:svt_ppm/utils/theme/colors.dart';
import 'package:svt_ppm/utils/widgets/custom_app_bar.dart';
import 'package:svt_ppm/utils/widgets/custom_image.dart';

class QrProfileScreen extends StatefulWidget {
  const QrProfileScreen({super.key});

  @override
  State<QrProfileScreen> createState() => _QrProfileScreenState();
}

class _QrProfileScreenState extends State<QrProfileScreen> {
  final ValueNotifier<LoginModel?> loginModelNotifier = ValueNotifier(null);
  List<LoginModel> noOfMemberList = [];
  final PageController _pageController = PageController(viewportFraction: 0.85);

  Future<void> loadLoginData() async {
    final model = await localDataSaver.getLoginModel();
    loginModelNotifier.value = model;
  }

  @override
  void initState() {
    loadLoginData();
    HomeCubit homeCubit = BlocProvider.of<HomeCubit>(context);
    homeCubit.memberFamily(context, pageName: 'profile');
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: CustomAppBar(title: 'My QR Profile', actions: []),
      body: ValueListenableBuilder<LoginModel?>(
        valueListenable: loginModelNotifier,
        builder: (context, userModel, child) {
          if (userModel == null) return const SizedBox();

          return BlocBuilder<HomeCubit, HomeState>(
            builder: (context, state) {
              if (state is GetHomeState) {
                noOfMemberList = state.noOfMemberList;
              }

              List<LoginModel> allMembers = [userModel];
              allMembers.addAll(noOfMemberList);

              return Column(
                children: [
                  const Gap(30),
                  Expanded(
                    child: PageView.builder(
                      controller: _pageController,
                      itemCount: allMembers.length,
                      physics: const BouncingScrollPhysics(),
                      itemBuilder: (context, index) {
                        final member = allMembers[index];
                        final bool isHeadMember = index == 0;
                        String qrString = "";

                        if (isHeadMember) {
                          Map<String, dynamic> headMemberData = {
                            "id": member.id,
                            "name": member.name,
                            "mobile": member.mobileNo,
                            "member_id": member.memberId,
                            "type": "Head Member",
                          };
                          qrString = jsonEncode(headMemberData);
                        } else {
                          Map<String, dynamic> memberData = {
                            "id": member.id,
                            "name": member.name,
                            "relation": member.relation,
                            "member_id": member.memberId,
                            "head_id": userModel.memberId,
                            "type": "Family Member",
                          };
                          qrString = jsonEncode(memberData);
                        }

                        return Center(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: _buildThemeCard(
                              name: member.name,
                              photo: member.photo,
                              mobile: member.mobileNo ?? "",
                              memberId: member.memberId,
                              qrData: qrString,
                              memberFamilyCard: member.memberFamilyCard,
                              relation: isHeadMember ? "Main Member" : member.relation,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  const Gap(20),
                  Text(
                    "Swipe left/right to view family members",
                    style: TextStyle(color: Colors.grey.shade600, fontSize: 12),
                  ),
                  const Gap(30),
                ],
              );
            },
          );
        },
      ),
    );
  }

  Widget _buildThemeCard({
    required String name,
    required String photo,
    required String mobile,
    required String memberId,
    required String qrData,
    required String memberFamilyCard,
    required String? relation,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
      decoration: BoxDecoration(
        color: AppColor.themePrimaryColor,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: AppColor.themePrimaryColor.withOpacity(0.4),
            blurRadius: 15,
            spreadRadius: 2,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white, width: 2),
                ),
                child: ClipOval(
                  child: CustomCachedImage(
                    imageUrl: photo,
                    height: 45,
                    width: 45,
                  ),
                ),
              ),
              const Gap(12),
              Flexible(
                child: Text(
                  name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),

          const Gap(25),

          Stack(
            alignment: Alignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: QrImageView(
                  data: qrData,
                  version: QrVersions.auto,
                  size: 220.0,
                  gapless: true,
                ),
              ),

              Container(
                height: 50,
                width: 50,
                decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white, width: 4),
                    boxShadow: const [
                      BoxShadow(color: Colors.black12, blurRadius: 5),
                    ]
                ),
                child: ClipOval(
                  child: CustomCachedImage(
                    imageUrl: photo,
                    height: 50,
                    width: 50,
                  ),
                ),
              ),
            ],
          ),

          const Gap(20),

          Text(
            "Scan to view details",
            style: TextStyle(
              color: Colors.white.withOpacity(0.8),
              fontSize: 14,
            ),
          ),

          const Gap(25),

          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              borderRadius: BorderRadius.circular(30),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.badge_outlined, color: Colors.white, size: 20),
                const Gap(10),

                Flexible(
                  child: Text(
                    "ID: $memberId ${relation != null ? '($relation)' : ''}",
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),

          const Gap(15),

          InkWell(
            onTap: () {
              if(mobile.isNotEmpty){
                Clipboard.setData(ClipboardData(text: mobile));
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Mobile number copied"), duration: Duration(seconds: 1)),
                );
              }
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Mobile: ${mobile.isEmpty ? 'N/A' : mobile}",
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.9),
                    fontSize: 14,
                  ),
                ),
                const Gap(8),
                if(mobile.isNotEmpty)
                  Icon(Icons.copy_rounded, color: Colors.white.withOpacity(0.9), size: 14),
              ],
            ),
          ),

          const Gap(20),

          if(memberFamilyCard.isNotEmpty)
            InkWell(
              onTap: () {
                Navigator.pushNamed(
                  context,
                  AppPage.showProofScreen,
                  arguments: {
                    'memberFamilyCard': memberFamilyCard,
                  },
                );
              },
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8)
                ),
                child: Text(
                  "View ID Card Proof",
                  style: TextStyle(
                    color: AppColor.themePrimaryColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}