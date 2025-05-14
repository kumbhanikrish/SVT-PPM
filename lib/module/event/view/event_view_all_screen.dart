import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:svt_ppm/module/event/view/current_event_section.dart';
import 'package:svt_ppm/module/event/view/past_event_section.dart';
import 'package:svt_ppm/module/event/view/upcoming_event_section.dart';
import 'package:svt_ppm/utils/constant/app_image.dart';
import 'package:svt_ppm/utils/widgets/custom_app_bar.dart';
import 'package:svt_ppm/utils/widgets/custom_widget.dart';

class EventViewAllScreen extends StatelessWidget {
  final dynamic data;
  const EventViewAllScreen({super.key, this.data});
  @override
  Widget build(BuildContext context) {
    String title = data['title'];

    Widget buildScreen(String title) {
      switch (title) {
        case 'Upcoming Event':
          return UpcomingEventSection();
        case 'Current Event':
          return CurrentEventSection();

        case 'Past Event':
          return PastEventSection();

        default:
          return Container();
      }
    }

    return Scaffold(
      appBar: CustomAppBar(title: title, notificationOnTap: () {}),
      body: Padding(
        padding: const EdgeInsets.only(
          left: 16,
          right: 10,
          bottom: 16,
          top: 25,
        ),
        child: Column(
          children: <Widget>[
            CustomTitleSeeAllWidget(
              title: title,
              seeAllOnTap: () {},
              image:
                  title == 'Past Event'
                      ? AppImage.pastEvent
                      : AppImage.dateTime,
              child: SizedBox(),
            ),
            Gap(16),
            buildScreen(title),
          ],
        ),
      ),
    );
  }
}
