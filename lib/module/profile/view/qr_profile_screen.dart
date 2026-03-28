import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:svt_ppm/main.dart';
import 'package:svt_ppm/module/auth/cubit/auth_cubit.dart';
import 'package:svt_ppm/module/auth/model/login_model.dart';
import 'package:svt_ppm/module/home/cubit/home_cubit.dart';
import 'package:svt_ppm/utils/constant/app_page.dart';
import 'package:svt_ppm/utils/theme/colors.dart';
import 'package:svt_ppm/utils/widgets/custom_app_bar.dart';
import 'package:svt_ppm/utils/widgets/custom_button.dart';
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
      appBar: CustomAppBar(title: 'My QR Profile'),
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
                              userModel: userModel,
                              name: member.name,
                              photo: member.photo,
                              mobile: member.mobileNo ?? "",
                              memberId: member.memberId,
                              qrData: qrString,
                              memberFamilyCard: member.memberFamilyCard,
                              relation:
                                  isHeadMember
                                      ? "Main Member"
                                      : member.relation,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  const Gap(20),
                  Text(
                    "Swipe to view family",
                    style: TextStyle(
                      color: Colors.grey.shade600,
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                    ),
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
    LoginModel? userModel,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 25),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 20,
            spreadRadius: 0,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(2),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.grey.shade200, width: 1),
                  ),
                  child: ClipOval(
                    child: CustomCachedImage(
                      imageUrl: photo,
                      height: 60,
                      width: 60,
                    ),
                  ),
                ),
                const Gap(15),
                Expanded(
                  child: Text(
                    name.toUpperCase(),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: AppColor.themePrimaryColor,
                      fontSize: 18,
                      fontWeight: FontWeight.w900,
                      letterSpacing: 0.5,
                    ),
                  ),
                ),
              ],
            ),

            const Gap(16),

            Stack(
              alignment: Alignment.center,
              children: [
                QrImageView(
                  data: qrData,
                  version: QrVersions.auto,
                  size: 240,
                  gapless: true,
                ),
                Container(
                  height: 55,
                  width: 55,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white, width: 3),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 8,
                      ),
                    ],
                  ),
                  child: ClipOval(
                    child: CustomCachedImage(
                      imageUrl: photo,
                      height: 55,
                      width: 55,
                    ),
                  ),
                ),
              ],
            ),

            const Gap(16),

            _buildInfoRow(
              icon: Icons.badge_outlined,
              label: "ID Number:",
              value: memberId,
            ),
            const Gap(15),
            _buildInfoRow(
              icon: Icons.smartphone_outlined,
              label: "Mobile:",
              value: mobile.isEmpty ? 'N/A' : mobile,
              onTap:
                  mobile.isNotEmpty
                      ? () {
                        Clipboard.setData(ClipboardData(text: mobile));
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("Mobile number copied"),
                            duration: Duration(seconds: 1),
                          ),
                        );
                      }
                      : null,
            ),

            const Gap(30),

            if (memberFamilyCard.isNotEmpty)
              CustomButton(
                text: 'View Card',
                textColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 12),
                fontSize: 16,
                borderRadius: BorderRadius.circular(20),
                onTap: () {
                  Navigator.pushNamed(
                    context,
                    AppPage.showProofScreen,
                    arguments: {'memberFamilyCard': memberFamilyCard},
                  );
                },
              ),

            if (userModel?.memberId == memberId) ...[
              const Gap(10),
              TextButton(
                onPressed: () {
                  BlocProvider.of<AuthCubit>(context).logout(context);
                },
                child: const Text(
                  "LogOut",
                  style: TextStyle(
                    color: Colors.redAccent,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ] else ...[
              const Gap(10),
              TextButton(
                onPressed: () {
                  BlocProvider.of<AuthCubit>(context).verifyOtp(
                    context,
                    number: mobile,
                    otp: '1234',
                    switchUser: true,
                    memberId: memberId,
                  );
                },
                child: const Text(
                  "Login as this member",
                  style: TextStyle(
                    color: AppColor.themePrimaryColor,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow({
    required IconData icon,
    required String label,
    required String value,
    VoidCallback? onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Row(
        children: [
          Icon(icon, color: Colors.blueGrey, size: 24),
          const Gap(12),
          Text(
            label,
            style: const TextStyle(
              color: Colors.blueGrey,
              fontSize: 15,
              fontWeight: FontWeight.w500,
            ),
          ),
          const Gap(8),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(
                color: AppColor.themePrimaryColor,
                fontSize: 15,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
