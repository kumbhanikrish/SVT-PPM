// import 'package:country_code_picker/country_code_picker.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:sizer/sizer.dart';
import 'package:svt_ppm/local_data/local_data_sever.dart';
import 'package:svt_ppm/module/auth/cubit/auth_cubit.dart';
import 'package:svt_ppm/services/api_services.dart';
import 'package:svt_ppm/utils/routes/app_routes.dart';
import 'package:svt_ppm/utils/theme/colors.dart';

void configLoading() {
  EasyLoading.instance
    ..backgroundColor = AppColor.themePrimaryColor2
    ..indicatorColor = AppColor.themeSecondaryColor
    ..textColor = AppColor.themeSecondaryColor
    ..progressColor = AppColor.themeSecondaryColor
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
  await SharedPreferences.getInstance();

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
              dialogTheme: DialogTheme(
                backgroundColor: AppColor.whiteColor,
                surfaceTintColor: AppColor.whiteColor,
              ),

              appBarTheme: AppBarTheme(
                backgroundColor: AppColor.whiteColor,
                surfaceTintColor: AppColor.whiteColor,
                iconTheme: IconThemeData(color: AppColor.greyColor),
              ),
              bottomSheetTheme: BottomSheetThemeData(
                backgroundColor: AppColor.whiteColor,
                surfaceTintColor: AppColor.whiteColor,
              ),
              scaffoldBackgroundColor: AppColor.whiteColor,
              bottomAppBarTheme: BottomAppBarTheme(
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

dynamic providers = [BlocProvider(create: (context) => AuthCubit())];
