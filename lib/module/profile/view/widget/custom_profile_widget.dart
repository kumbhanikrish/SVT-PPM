import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:svt_ppm/module/auth/cubit/auth_cubit.dart';
import 'package:svt_ppm/module/auth/view/otp_verification_screen.dart';
import 'package:svt_ppm/module/profile/cubit/profile_cubit.dart';
import 'package:svt_ppm/utils/widgets/custom_bottomsheet.dart';

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
