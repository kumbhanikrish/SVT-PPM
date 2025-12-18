// import 'package:country_code_picker/country_code_picker.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:sizer/sizer.dart';
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
import 'package:svt_ppm/services/api_services.dart';

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

ApiServices api = ApiServices();

LocalDataSaver localDataSaver = LocalDataSaver();

void main() async {
  await dotenv.load();
  WidgetsFlutterBinding.ensureInitialized();
  await UserSession.load();
  await SharedPreferences.getInstance();
  await Firebase.initializeApp();

  runApp(const MyApp());
  configLoading();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return Sizer(
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
            routes: appRoutes,
            builder: EasyLoading.init(),
          ),
        );
      },
    );
  }
}

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
