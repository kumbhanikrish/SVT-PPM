// import 'package:flutter/material.dart';
// import 'package:svt_ppm/module/app_features/view/comity/comity_section.dart';
// import 'package:svt_ppm/module/app_features/view/exam/exam_screen.dart';
// import 'package:svt_ppm/module/app_features/view/kit/kit_screen.dart';
// import 'package:svt_ppm/module/app_features/view/schema/schema_section.dart';
// import 'package:svt_ppm/utils/widgets/custom_app_bar.dart';
//
// class AppFeatureScreen extends StatelessWidget {
//   final dynamic data;
//   const AppFeatureScreen({super.key, this.data});
//   @override
//   Widget build(BuildContext context) {
//     String title = data['title'];
//     Widget buildScreen(String title) {
//       switch (title) {
//         case 'Schema':
//           return SchemaSection();
//         case 'Kit':
//           return KitScreen();
//
//         case 'Exam (GK)':
//           return ExamScreen();
//         case 'Comity':
//           return ComitySection();
//
//         default:
//           return Container();
//       }
//     }
//
//     return Scaffold(
//       appBar: CustomAppBar(title: title, notificationOnTap: () {}, actions: []),
//       body: buildScreen(title),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:svt_ppm/module/app_features/view/comity/comity_section.dart';
import 'package:svt_ppm/module/app_features/view/exam/exam_screen.dart';
import 'package:svt_ppm/module/app_features/view/kit/kit_screen.dart';
import 'package:svt_ppm/module/app_features/view/schema/schema_section.dart';
import 'package:svt_ppm/utils/widgets/custom_app_bar.dart';

class AppFeatureScreen extends StatelessWidget {
  final dynamic data;
  const AppFeatureScreen({super.key, this.data});

  @override
  Widget build(BuildContext context) {
    // ✅ સુધારો: ડેટા પહેલા Constructor (BottomBar) માં ચેક કરો, નહિતર Route (Navigation) માં ચેક કરો
    final dynamic finalData =
        data ?? ModalRoute.of(context)?.settings.arguments;

    String title = '';
    if (finalData != null && finalData is Map) {
      title = finalData['title'] ?? '';
    }

    // ✅ સ્ક્રીન નક્કી કરવાનું લોજિક
    Widget buildScreen(String title) {
      switch (title) {
        case 'Schema':
          return SchemaSection();
        case 'Kit':
          return KitScreen();
        case 'Exam (GK)':
          return ExamScreen();
        case 'Committee':
          return ComitySection();
        default:
          return const Center(child: Text("No Data Found"));
      }
    }

    // ✅ Back Arrow લોજિક:
    // જો 'data' ભરેલો હોય, તો તેનો અર્થ કે આપણે BottomBar પર છીએ -> Arrow છુપાવો (SizedBox).
    // જો 'data' ખાલી હોય, તો આપણે PushNamed થી આવ્યા છીએ -> Arrow બતાવો (null).
    Widget? leadingIcon = (data != null) ? const SizedBox() : null;

    return Scaffold(
      appBar: CustomAppBar(
        title: title,
        notificationOnTap: () {},
        leading: leadingIcon, // અહીં સેટ કર્યું
        actions: const [],
      ),
      body: buildScreen(title),
    );
  }
}
