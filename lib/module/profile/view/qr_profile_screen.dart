import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:svt_ppm/main.dart';
import 'package:svt_ppm/module/auth/model/login_model.dart';
import 'package:svt_ppm/module/home/cubit/home_cubit.dart';
import 'package:svt_ppm/module/profile/view/widget/custom_profile_widget.dart';
import 'package:svt_ppm/utils/theme/colors.dart';
import 'package:svt_ppm/utils/widgets/custom_app_bar.dart';
import 'package:svt_ppm/utils/widgets/custom_image.dart';
import 'package:svt_ppm/utils/widgets/custom_text.dart';

class QrProfileScreen extends StatefulWidget {
  const QrProfileScreen({super.key});

  @override
  State<QrProfileScreen> createState() => _QrProfileScreenState();
}

class _QrProfileScreenState extends State<QrProfileScreen> {
  final ValueNotifier<LoginModel?> loginModelNotifier = ValueNotifier(null);
  List<LoginModel> noOfMemberList = [];

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
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'My QR Profile', actions: []),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 25),
          child: ValueListenableBuilder<LoginModel?>(
            valueListenable: loginModelNotifier,
            builder: (context, userModel, child) {
              if (userModel == null) return const SizedBox();

              return BlocBuilder<HomeCubit, HomeState>(
                builder: (context, state) {
                  if (state is GetHomeState) {
                    noOfMemberList = state.noOfMemberList;
                  }
                  Map<String, dynamic> headMemberData = {
                    "id": userModel.id,
                    "name": userModel.name,
                    "mobile": userModel.mobileNo,
                    "member_id": userModel.memberId,
                    "type": "Head Member",
                  };
                  String headQrString = jsonEncode(headMemberData);

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomText(
                        text: "Main Member",
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: AppColor.themePrimaryColor,
                      ),
                      const Gap(10),

                      _buildQrCard(
                        name: userModel.name,
                        photo: userModel.photo,
                        mobile: userModel.mobileNo,
                        memberId: userModel.memberId,
                        qrData: headQrString,
                      ),

                      const Gap(30),
                      if (noOfMemberList.isNotEmpty) ...[
                        Center(
                          child: CustomText(
                            text: "Family Members",
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: AppColor.themePrimaryColor,
                          ),
                        ),
                        const Gap(10),

                        ListView.separated(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: noOfMemberList.length,
                          separatorBuilder: (context, index) => const Gap(20),
                          itemBuilder: (context, index) {
                            LoginModel member = noOfMemberList[index];
                            Map<String, dynamic> memberData = {
                              "id": member.id,
                              "name": member.name,
                              "relation": member.relation,
                              "member_id": member.memberId,
                              "head_id": userModel.memberId,
                              "type": "Family Member",
                            };
                            String memberQrString = jsonEncode(memberData);

                            return _buildQrCard(
                              name: member.name,
                              photo: member.photo,
                              mobile: member.mobileNo ?? "",
                              memberId: member.memberId,
                              qrData: memberQrString,
                            );
                          },
                        ),
                      ] else ...[
                        CustomEmpty(),
                      ],

                      const Gap(30),
                    ],
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildQrCard({
    required String name,
    required String photo,
    required String mobile,
    required String memberId,
    required String qrData,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColor.themeSecondaryColor, width: 1),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.15),
            blurRadius: 10,
            spreadRadius: 2,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              InkWell(
                onTap:
                    () => showImageDialog(context, imageUrl: photo, name: name),
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: AppColor.themeSecondaryColor,
                      width: 3,
                    ),
                    shape: BoxShape.circle,
                  ),
                  child: ClipOval(
                    child: CustomCachedImage(
                      imageUrl: photo,
                      height: 130,
                      width: 130,
                    ),
                  ),
                ),
              ),

              const Gap(15),

              InkWell(
                onTap:
                    () => showQrDialog(
                      context,
                      qrData: qrData,
                      name: name,
                      memberId: memberId,
                    ),
                child: Container(
                  height: 130,
                  width: 130,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.grey.shade300, width: 1),
                  ),
                  child: Center(
                    child: QrImageView(
                      data: qrData,
                      version: QrVersions.auto,
                      size: 120.0,
                      gapless: true,
                      padding: const EdgeInsets.all(5),
                    ),
                  ),
                ),
              ),
            ],
          ),

          const Gap(20),
          const Divider(thickness: 1, height: 1),
          const Gap(15),

          CustomText(
            text: name,
            fontSize: 20,
            fontWeight: FontWeight.w600,
            textAlign: TextAlign.center,
          ),

          const Gap(10),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (mobile.isNotEmpty) ...[
                Icon(Icons.phone, size: 16, color: AppColor.hintColor),
                const Gap(5),
                CustomText(
                  text: mobile,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: AppColor.hintColor,
                ),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 10),
                  height: 15,
                  width: 1,
                  color: Colors.grey,
                ),
              ],

              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: AppColor.themePrimaryColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: CustomText(
                  text: "ID: $memberId",
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: AppColor.themePrimaryColor,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
