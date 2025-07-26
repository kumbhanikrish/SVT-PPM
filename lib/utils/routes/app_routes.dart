import 'package:flutter/material.dart';
import 'package:svt_ppm/module/app_features/view/app_feature_screen.dart';
import 'package:svt_ppm/module/app_features/view/exam/exam_form_screen.dart';
import 'package:svt_ppm/module/app_features/view/kit/kit_detail_screen.dart';
import 'package:svt_ppm/module/app_features/view/schema/schema_content_screen.dart';
import 'package:svt_ppm/module/auth/view/auth_screen.dart';
import 'package:svt_ppm/module/auth/view/selection_Screen.dart';
import 'package:svt_ppm/module/auth/view/signup_screen.dart';
import 'package:svt_ppm/module/auth/view/splash_screen.dart';
import 'package:svt_ppm/module/event/view/event_screen.dart';
import 'package:svt_ppm/module/event/view/event_view_all_Screen.dart';
import 'package:svt_ppm/module/home/view/home_screen.dart';
import 'package:svt_ppm/module/profile/view/edit_profile_screen.dart';
import 'package:svt_ppm/module/profile/view/profile_screen.dart';

import 'package:svt_ppm/utils/constant/app_page.dart';

final Map<String, WidgetBuilder> appRoutes = {
  AppPage.splashScreen: (context) => const SplashScreen(),
  AppPage.authScreen: (context) => const AuthScreen(),
  AppPage.signupScreen:
      (context) =>
          SignupScreen(data: ModalRoute.of(context)?.settings.arguments),
  AppPage.selectionScreen:
      (context) => SelectionScreen(
        arguments: ModalRoute.of(context)?.settings.arguments,
      ),
  AppPage.homeScreen: (context) => const HomeScreen(),
  AppPage.eventScreen: (context) => const EventScreen(),
  AppPage.eventViewAllScreen:
      (context) =>
          EventViewAllScreen(data: ModalRoute.of(context)?.settings.arguments),
  AppPage.appFeatureScreen:
      (context) =>
          AppFeatureScreen(data: ModalRoute.of(context)?.settings.arguments),
  AppPage.kitDetailScreen: (context) => KitDetailScreen(),
  AppPage.examFormScreen: (context) => ExamFormScreen(),
  AppPage.profileScreen: (context) => ProfileScreen(),
  AppPage.editProfileScreen:
      (context) => EditProfileScreen(
        argument: ModalRoute.of(context)?.settings.arguments,
      ),
  AppPage.schemaContentScreen:
      (context) => SchemaContentScreen(
        argument: ModalRoute.of(context)?.settings.arguments,
      ),

  // AppRoutes.referAndEarnScreen:
  //     (context) =>
  //         ReferAndEarnScreen(data: ModalRoute.of(context)?.settings.arguments),
};
