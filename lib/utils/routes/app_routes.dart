import 'package:flutter/material.dart';
import 'package:svt_ppm/module/auth/view/auth_screen.dart';
import 'package:svt_ppm/module/auth/view/selection_Screen.dart';
import 'package:svt_ppm/module/auth/view/signup_screen.dart';
import 'package:svt_ppm/module/auth/view/splash_screen.dart';
import 'package:svt_ppm/module/home/view/home_screen.dart';

import 'package:svt_ppm/utils/constant/app_page.dart';

final Map<String, WidgetBuilder> appRoutes = {
  AppPage.splashScreen: (context) => const SplashScreen(),
  AppPage.authScreen: (context) => const AuthScreen(),
  AppPage.signupScreen:
      (context) =>
          SignupScreen(data: ModalRoute.of(context)?.settings.arguments),
  AppPage.selectionScreen: (context) => const SelectionScreen(),
  AppPage.homeScreen: (context) => const HomeScreen(),

  // AppRoutes.referAndEarnScreen:
  //     (context) =>
  //         ReferAndEarnScreen(data: ModalRoute.of(context)?.settings.arguments),
};
