import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:sizer/sizer.dart';
import 'package:svt_ppm/module/app_features/cubit/kits/kits_cubit.dart';
import 'package:svt_ppm/module/auth/cubit/auth_cubit.dart';
import 'package:svt_ppm/utils/constant/app_image.dart';
import 'package:svt_ppm/utils/formatter/format.dart';
import 'package:svt_ppm/utils/theme/colors.dart';
import 'package:svt_ppm/utils/widgets/custom_bottomsheet.dart';
import 'package:svt_ppm/utils/widgets/custom_button.dart';
import 'package:svt_ppm/utils/widgets/custom_card.dart';
import 'package:svt_ppm/utils/widgets/custom_image.dart';
import 'package:svt_ppm/utils/widgets/custom_text.dart';

class KitScreen extends StatefulWidget {
  const KitScreen({super.key});

  @override
  State<KitScreen> createState() => _KitScreenState();
}

class _KitScreenState extends State<KitScreen> {
  Map<String, dynamic> kitsData = {};
  @override
  void initState() {
    KitsCubit kitsCubit = BlocProvider.of<KitsCubit>(context);
    kitsCubit.init();
    kitsCubit.getKitsData(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    KitsCubit kitsCubit = BlocProvider.of<KitsCubit>(context);

    return RefreshIndicator(
      backgroundColor: AppColor.whiteColor,
      color: AppColor.themePrimaryColor,
      elevation: 0,
      onRefresh: () {
        return kitsCubit.getKitsData(context);
      },
      child: BlocBuilder<KitsCubit, KitsState>(
        builder: (context, state) {
          if (state is GetKitsState) {
            kitsData = state.kitData;
          }
          return kitsData.isEmpty ||
                  kitsData.values.every((members) => (members as List).isEmpty)
              ? CustomEmpty()
              : SingleChildScrollView(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 24,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children:
                      kitsData.entries.map((entry) {
                        final String year = entry.key;
                        final List<dynamic> members = entry.value;

                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Year Title
                            Padding(
                              padding: const EdgeInsets.only(bottom: 16),
                              child: CustomText(
                                text: year,
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                              ),
                            ),

                            // Grid of members
                            members.isEmpty
                                ? CustomEmpty()
                                : ListView.separated(
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemCount: members.length,

                                  itemBuilder: (context, index) {
                                    final member = members[index];
                                    return KitCard(
                                      cardOnTap: () {
                                        customKitsRegistered(
                                          context,
                                          resultPhoto:
                                              member['result_photo'] ?? '',
                                          memberId: member['id'],
                                          show: true,
                                          status: member['status'],
                                        );
                                      },
                                      image: member['photo'],
                                      title: member['name'],
                                      rejectReason: member['remarks'] ?? '',
                                      joinText:
                                          member['is_registered'] == false
                                              ? 'Apply'
                                              : 'Registered',
                                      status:
                                          member['is_registered'] == true
                                              ? capitalize(member['status'])
                                              : '',
                                      showButton:
                                          member['is_registered'] == false
                                              ? true
                                              : member['status'] == 'rejected'
                                              ? true
                                              : false,
                                      onTap: () {
                                        customKitsRegistered(
                                          context,
                                          resultPhoto:
                                              member['result_photo'] ?? '',
                                          memberId: member['id'] ?? 0,
                                          status: member['status'] ?? '',

                                          show: false,
                                        );
                                      },
                                    );
                                  },
                                  separatorBuilder: (
                                    BuildContext context,
                                    int index,
                                  ) {
                                    return Gap(10);
                                  },
                                ),
                          ],
                        );
                      }).toList(),
                ),
              );
        },
      ),
    );
  }
}

customKitsRegistered(
  BuildContext context, {
  required String resultPhoto,
  required int memberId,
  required bool show,
  required String status,
}) {
  FrontImageCubit frontImageCubit = BlocProvider.of<FrontImageCubit>(context);
  KitsCubit kitsCubit = BlocProvider.of<KitsCubit>(context);
  frontImageCubit.removeImage();
  customBottomSheet(
    context,
    title: 'Kits Registered',
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
      child:
          show && status != 'rejected'
              ? CustomCachedImage(
                imageUrl: resultPhoto,
                height: 40.h,
                width: 100.w,
              )
              : Column(
                children: [
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
                              height: 20.h,
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: AppColor.themePrimaryColor,
                                  width: 1,
                                ),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child:
                                  frontImage == null
                                      ? Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: <Widget>[
                                          SvgPicture.asset(
                                            AppImage.uploadImage,
                                          ),
                                          Gap(10),
                                          const CustomText(
                                            text: 'Upload Mark Sheet',
                                            fontSize: 12,
                                          ),
                                        ],
                                      )
                                      : Stack(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(20),
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(12),
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
                                                frontImageCubit.removeImage();
                                              },
                                              child: const CircleAvatar(
                                                radius: 14,
                                                backgroundColor: Colors.black54,
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
                          decoration: BoxDecoration(color: AppColor.whiteColor),
                          padding: EdgeInsets.symmetric(horizontal: 2),
                          child: const CustomText(
                            text: 'Mark Sheet',
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),

                  Gap(20),
                  CustomButton(
                    text: 'Registered',
                    onTap: () {
                      kitsCubit.kitsRegistration(
                        context,
                        memberId: memberId,
                        photo: frontImageCubit.state?.path,
                      );
                    },
                  ),
                ],
              ),
    ),
    showButton: false,
    buttonOnTap: () {},
  );
}
