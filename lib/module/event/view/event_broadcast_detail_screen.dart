import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:sizer/sizer.dart';
import 'package:svt_ppm/module/home/view/widget/custom_home_widget.dart';
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

    bool isEvent = title.toString().toLowerCase().contains('event');
    bool isJoined = homeData['applied'] ?? false;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(title: title, actions: []),

      bottomNavigationBar: isEvent
          ? Container(
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: Colors.transparent,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, -5),
            ),
          ],
        ),
        child: isJoined
            ? Row(
          children: [
            Expanded(
              child: InkWell(
                onTap: null,
                child: Container(
                  height: 50,
                  decoration: BoxDecoration(
                    color: AppColor.themePrimaryColor,
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(10),
                      bottomLeft: Radius.circular(10),
                    ),
                  ),
                  child: const Center(
                    child: Text(
                      'Joined Event',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: InkWell(
                onTap: null,
                child: Container(
                  height: 50,
                  decoration: BoxDecoration(
                    color: const Color(0xFFFFF9C4),
                    borderRadius: const BorderRadius.only(
                      topRight: Radius.circular(10),
                      bottomRight: Radius.circular(10),
                    ),
                  ),
                  child: Center(
                    child: Text(
                      'Cancel',
                      style: TextStyle(
                        color: AppColor.themePrimaryColor,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        )
            : InkWell(
          onTap: () {
            customNoOfMemberBottomSheet(
              context,
              eventId: homeData['id'],
              extra: true,
              seeAll: true,
            );
          },
          child: Container(
            height: 50,
            width: double.infinity,
            decoration: BoxDecoration(
              color: AppColor.themePrimaryColor,
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Center(
              child: Text(
                'Join Event',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ),
      )
          : const SizedBox.shrink(),

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