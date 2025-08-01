import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:sizer/sizer.dart';

import 'package:svt_ppm/utils/constant/app_page.dart';
import 'package:svt_ppm/utils/widgets/custom_app_bar.dart';
import 'package:svt_ppm/utils/widgets/custom_card.dart';

class EventViewAllScreen extends StatefulWidget {
  final dynamic data;
  const EventViewAllScreen({super.key, this.data});

  @override
  State<EventViewAllScreen> createState() => _EventViewAllScreenState();
}

class _EventViewAllScreenState extends State<EventViewAllScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    String title = widget.data['title'];

    List<dynamic> homeSeeAllData = widget.data['homeSeeAllData'];

    return Scaffold(
      appBar: CustomAppBar(title: title, notificationOnTap: () {}, actions: []),
      body: Padding(
        padding: const EdgeInsets.only(
          left: 16,
          right: 10,
          bottom: 16,
          top: 25,
        ),
        child: Column(
          children: <Widget>[
            Gap(16),
            Expanded(
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 13,
                  mainAxisExtent: 23.h,
                ),
                itemCount: homeSeeAllData.length,
                itemBuilder: (BuildContext context, int index) {
                  final homeData = homeSeeAllData[index];
                  return CustomCard(
                    cardOnTap: () {
                      Navigator.pushNamed(
                        context,
                        AppPage.eventBroadcastDetailScreen,
                        arguments: {
                          'homeData': homeData,
                          'title': '$title Detail',
                        },
                      );
                    },
                    image: homeData['image'],
                    date: homeData['date'],
                    title: homeData['title'],
                    des: homeData['place'],
                    showButton: homeData['applied'] == false ? true : false,
                    joinText: 'Join Event',
                    time: '',
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
