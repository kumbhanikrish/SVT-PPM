import 'package:flutter/material.dart';
import 'package:svt_ppm/module/auth/view/splash_screen.dart';

import 'package:svt_ppm/utils/constant/app_page.dart';

final Map<String, WidgetBuilder> appRoutes = {
  AppPage.splashScreen: (context) => const SplashScreen(),

  // AppRoutes.referAndEarnScreen:
  //     (context) =>
  //         ReferAndEarnScreen(data: ModalRoute.of(context)?.settings.arguments),
};
