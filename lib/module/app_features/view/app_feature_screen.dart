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
    String title = data['title'];
    Widget buildScreen(String title) {
      switch (title) {
        case 'Schema':
          return SchemaSection();
        case 'Kit':
          return KitScreen();

        case 'Exam (GK)':
          return ExamScreen();
        case 'Comity':
          return ComitySection();

        default:
          return Container();
      }
    }

    return Scaffold(
      appBar: CustomAppBar(title: title, notificationOnTap: () {}, actions: []),
      body: buildScreen(title),
    );
  }
}
