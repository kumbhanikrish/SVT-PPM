import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:sizer/sizer.dart';
import 'package:svt_ppm/utils/theme/colors.dart';
import 'package:svt_ppm/utils/widgets/custom_app_bar.dart';
import 'package:svt_ppm/utils/widgets/custom_image.dart';
import 'package:svt_ppm/utils/widgets/custom_text.dart';

class EventBroadcastDetailScreen extends StatelessWidget {
  final dynamic argument;
  const EventBroadcastDetailScreen({super.key, this.argument});
  @override
  Widget build(BuildContext context) {
    final homeData = argument['homeData'];
    final title = argument['title'];
    return Scaffold(
      appBar: CustomAppBar(title: title, actions: []),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(18),
                child: CustomCachedImage(
                  imageUrl: homeData['image'],

                  width: 100.w,
                  height: 20.h,
                ),
              ),
              Gap(10),

              CustomText(
                text: homeData['date'],
                fontSize: 10,
                color: AppColor.seeAllTitleColor,
              ),
              Gap(10),

              CustomText(
                text: homeData['title'],
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
              Gap(10),

              CustomText(
                text: homeData['place'],
                color: AppColor.seeAllTitleColor,
                fontSize: 12,
                textAlign: TextAlign.start,
              ),
              Gap(10),
              CustomHTMLText(text: homeData['description'] ?? ''),

              Gap(10.h),
            ],
          ),
        ),
      ),
    );
  }
}
