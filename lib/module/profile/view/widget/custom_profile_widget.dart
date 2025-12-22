import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:svt_ppm/module/auth/cubit/auth_cubit.dart';
import 'package:svt_ppm/module/auth/view/otp_verification_screen.dart';
import 'package:svt_ppm/module/profile/cubit/profile_cubit.dart';
import 'package:svt_ppm/utils/theme/colors.dart';
import 'package:svt_ppm/utils/widgets/custom_bottomsheet.dart';
import 'package:svt_ppm/utils/widgets/custom_dialog.dart';
import 'package:svt_ppm/utils/widgets/custom_image.dart';
import 'package:svt_ppm/utils/widgets/custom_text.dart';

mobileVerification(
  BuildContext context, {
  required String number,
  required AuthCubit authCubit,
  required ProfileCubit profileCubit,
  required int memberId,
  required String firstName,
  required String middleName,
  required String lastName,
  required String mobileNo,

  required String email,
  required String address,
  required String villageName,
  required String relation,
  required String standard,
  required String gender,
  required String photo,
}) async {
  log('numbernumber ::$number');
  authCubit.sendOtp(context, number: number, login: false);
  return customBottomSheet(
    context,
    title: 'Mobile Verification',
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),

      child: OtpVerificationScreen(number: number, showButton: false),
    ),
    showButton: true,
    buttonOnTap: () {
      profileCubit.addMemberFamily(
        context,
        memberId: memberId,
        edit: true,
        editProfile: true,

        firstName: firstName,
        middleName: middleName,
        lastName: lastName,
        mobileNo: mobileNo,
        email: email,
        address: address,
        villageName: villageName,
        relation: relation,
        standard: standard,
        gender: gender,
        photo: photo,
      );
    },
  );
}

void showImageDialog(
  BuildContext context, {
  required String imageUrl,
  required String name,
}) {
  customDialog(
    context,
    title: name,
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: AppColor.themeSecondaryColor, width: 4),
          ),
          child: ClipOval(
            child: CustomCachedImage(
              imageUrl: imageUrl,
              height: 250,
              width: 250,
            ),
          ),
        ),
        const Gap(20),
        const Divider(),
        const Gap(10),

        CustomText(
          text: name,
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: AppColor.themePrimaryColor,
          textAlign: TextAlign.center,
        ),
      ],
    ),
  );
}

void showQrDialog(
  BuildContext context, {
  required String qrData,
  required String name,
  required String memberId,
}) {
  customDialog(
    context,
    title: name,
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        QrImageView(
          data: qrData,
          version: QrVersions.auto,
          size: 250.0,
          gapless: true,
        ),
        const Gap(20),
        const Divider(),
        const Gap(10),

        CustomText(
          text: name,
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: AppColor.themePrimaryColor,
          textAlign: TextAlign.center,
        ),

        const Gap(10),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 6),
          decoration: BoxDecoration(
            color: AppColor.themePrimaryColor.withOpacity(0.1),
            borderRadius: BorderRadius.circular(20),
          ),
          child: CustomText(
            text: "ID:$memberId",
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: AppColor.themePrimaryColor,
          ),
        ),
      ],
    ),
  );
}
