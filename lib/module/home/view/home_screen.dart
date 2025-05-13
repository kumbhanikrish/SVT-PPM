import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:svt_ppm/utils/constant/app_image.dart';
import 'package:svt_ppm/utils/widgets/custom_app_bar.dart';
import 'package:svt_ppm/utils/widgets/custom_widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'SVTPPM App',
        actions: [
          Padding(
            padding: const EdgeInsets.only(left: 16, bottom: 10),
            child: ClipOval(
              child: Image.asset(
                AppImage.user,
                width: 44,
                height: 44,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Gap(12),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Gap(25),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: CustomTitleSeeAllWidget(
                title: 'List of Event',
                seeAllOnTap: () {},
              ),
            ),
            Gap(24),
            CustomDivider(),
            Gap(24),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: CustomTitleSeeAllWidget(
                title: 'Broadcast message',
                seeAllOnTap: () {},
              ),
            ),
            Gap(24),
            CustomDivider(),

            Gap(24),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: CustomTitleSeeAllWidget(
                title: 'App Features',
                seeAllOnTap: () {},
              ),
            ),
          ],
        ),
      ),
    );
  }
}
