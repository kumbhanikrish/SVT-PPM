import 'dart:async';

import 'package:flutter/material.dart';
import 'package:svt_ppm/utils/constant/app_image.dart';
import 'package:svt_ppm/utils/constant/app_page.dart';
import 'package:svt_ppm/utils/theme/colors.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Timer(const Duration(seconds: 1), () async {
      Navigator.pushNamedAndRemoveUntil(
        context,
        AppPage.authScreen,
        (route) => false,
      );
      // String authToken = await localDataSaver.getAuthToken();
      // log('authTokenauthToken ::$authToken');

      // if (authToken.isEmpty) {
      //   Navigator.pushNamedAndRemoveUntil(
      //     context,
      //     AppPage.loginScreen,
      //     (route) => false,
      //   );
      // } else {
      //   Navigator.pushNamedAndRemoveUntil(
      //     context,
      //     AppPage.dashboardScreen,
      //     (route) => false,
      //   );
      // }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.themeSecondaryColor,
      body: Center(child: Image.asset(AppLogo.splashLogo)),
    );
  }
}
