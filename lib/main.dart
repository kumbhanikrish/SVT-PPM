import 'dart:developer';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:sizer/sizer.dart';
import 'package:svt_ppm/firebase_options.dart';
import 'package:svt_ppm/local_data/local_data_sever.dart';
import 'package:svt_ppm/module/app_features/cubit/community/community_cubit.dart';
import 'package:svt_ppm/module/app_features/cubit/exam/exam_cubit.dart';
import 'package:svt_ppm/module/app_features/cubit/kits/kits_cubit.dart';
import 'package:svt_ppm/module/app_features/cubit/role_schemas_registration/role_schemas_registration_cubit.dart';
import 'package:svt_ppm/module/app_features/cubit/schemas/schemas_cubit.dart';
import 'package:svt_ppm/module/auth/cubit/auth_cubit.dart';
import 'package:svt_ppm/module/data_entry/cubit/data_entry_cubit.dart';
import 'package:svt_ppm/module/home/cubit/home_cubit.dart';
import 'package:svt_ppm/module/profile/cubit/profile_cubit.dart';
import 'package:svt_ppm/utils/constant/app_page.dart';

import 'package:svt_ppm/utils/formatter/format.dart';
import 'package:svt_ppm/utils/routes/app_routes.dart';
import 'package:svt_ppm/utils/theme/colors.dart';

void configLoading() {
  EasyLoading.instance
    ..backgroundColor = AppColor.themePrimaryColor
    ..indicatorColor = AppColor.lightThemePrimaryColor
    ..textColor = AppColor.lightThemePrimaryColor
    ..progressColor = AppColor.lightThemePrimaryColor
    ..maskType = EasyLoadingMaskType.black
    ..userInteractions = false
    ..loadingStyle = EasyLoadingStyle.custom
    ..dismissOnTap = false;
}

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

LocalDataSaver localDataSaver = LocalDataSaver();

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  log("Handling background message: ${message.messageId}");
  showNotification(message);
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await SharedPreferences.getInstance();
  await UserSession.load();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  NotificationSettings settings =
      await FirebaseMessaging.instance.requestPermission();
  log('🔔 Notification permission status: ${settings.authorizationStatus}');

  const AndroidInitializationSettings initializationSettingsAndroid =
      AndroidInitializationSettings('@mipmap/ic_launcher');

  const InitializationSettings initializationSettings = InitializationSettings(
    android: initializationSettingsAndroid,
  );

  await flutterLocalNotificationsPlugin.initialize(initializationSettings);
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp, // lock to portrait
  ]);
  configLoading();
  runApp(const MyApp());
}

void showNotification(RemoteMessage message) async {
  const AndroidNotificationChannel channel = AndroidNotificationChannel(
    'high_importance_channel',
    'High Importance Notifications',
    description: 'This channel is used for important notifications.',
    importance: Importance.max,
  );

  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin
      >()
      ?.createNotificationChannel(channel);

  final androidDetails = AndroidNotificationDetails(
    channel.id,
    channel.name,
    channelDescription: channel.description,
    importance: Importance.max,
    priority: Priority.high,
    icon: '@mipmap/ic_launcher',
  );

  final platformDetails = NotificationDetails(android: androidDetails);

  await flutterLocalNotificationsPlugin.show(
    0,
    message.notification?.title ?? message.data['title'] ?? 'No Title',
    message.notification?.body ?? message.data['body'] ?? 'No Body',
    platformDetails,
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      log('📢 Notifications enabled, displaying notification');
      showNotification(message);
    });

    void handleMessageNavigation(RemoteMessage message) {
      final screen = message.data['screen'];
      log('🔁 Navigating to screen from notification: $screen');

      if (screen == 'offers') {
        navigatorKey.currentState?.pushNamed('/offersScreen');
      } else if (screen == 'profile') {
        navigatorKey.currentState?.pushNamed('/profileScreen');
      }
    }

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      log('🟢 App opened from background notification');
      handleMessageNavigation(message);
    });
    return SafeArea(
      top: false,
      child: Sizer(
        builder: (context, orientation, deviceType) {
          return MultiBlocProvider(
            providers: providers,
            child: MaterialApp(
              navigatorKey: navigatorKey,
              debugShowCheckedModeBanner: false,
              title: 'Flutter Demo',
              theme: ThemeData(
                dialogTheme: DialogThemeData(
                  backgroundColor: AppColor.whiteColor,
                  surfaceTintColor: AppColor.whiteColor,
                ),
                appBarTheme: AppBarTheme(
                  backgroundColor: AppColor.whiteColor,
                  surfaceTintColor: AppColor.whiteColor,
                  iconTheme: IconThemeData(color: AppColor.hintColor),
                ),
                bottomSheetTheme: BottomSheetThemeData(
                  backgroundColor: AppColor.whiteColor,
                  surfaceTintColor: AppColor.whiteColor,
                ),
                scaffoldBackgroundColor: AppColor.whiteColor,
                bottomAppBarTheme: BottomAppBarThemeData(
                  color: AppColor.whiteColor,
                  surfaceTintColor: AppColor.whiteColor,
                ),
              ),
              initialRoute: AppPage.splashScreen,
              routes: appRoutes,
              builder: EasyLoading.init(),
            ),
          );
        },
      ),
    );
  }
}

// ----- Bloc Providers -----
dynamic providers = [
  BlocProvider(create: (context) => AuthCubit()),
  BlocProvider(create: (context) => HomeCubit()),
  BlocProvider(create: (context) => StepperCubit()),
  BlocProvider(create: (context) => ImageUploadCubit()),
  BlocProvider(create: (context) => ProfileImageCubit()),
  BlocProvider(create: (context) => FrontImageCubit()),
  BlocProvider(create: (context) => BackImageCubit()),
  BlocProvider(create: (context) => RadioCubit()),
  BlocProvider(create: (context) => SchemasCubit()),
  BlocProvider(create: (context) => SelectRelationCubit()),
  BlocProvider(create: (context) => SelectStandardCubit()),
  BlocProvider(create: (context) => ProfileCubit()),
  BlocProvider(create: (context) => CommunityCubit()),
  BlocProvider(create: (context) => KitsCubit()),
  BlocProvider(create: (context) => SelectMemberCubit()),
  BlocProvider(create: (context) => VillageCubit()),
  BlocProvider(create: (context) => ExamCubit()),
  BlocProvider(create: (context) => LanguageCubit()),
  BlocProvider(create: (context) => ChangeBorder2Cubit()),
  BlocProvider(create: (context) => DataEntryCubit()),
  BlocProvider(create: (context) => RoleSchemasRegistrationCubit()),
  BlocProvider(create: (context) => StatusRadioCubit()),
];
