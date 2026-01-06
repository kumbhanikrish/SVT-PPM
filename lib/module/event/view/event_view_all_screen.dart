import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:svt_ppm/module/home/view/widget/custom_home_widget.dart';
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
  Widget build(BuildContext context) {

    String title = widget.data['title'] ?? '';
    List<dynamic> homeSeeAllData = widget.data['homeSeeAllData'] ?? [];
    bool showButtons = widget.data['isEvent'] ?? false;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(
          title: title,
          notificationOnTap: () {},
          actions: []
      ),
      body: Padding(
        padding: const EdgeInsets.only(
          left: 16,
          right: 16,
          bottom: 16,
          top: 10,
        ),
        child: Column(
          children: <Widget>[
            Gap(10),
            Expanded(
              child: homeSeeAllData.isEmpty
                  ? Center(child: Text("No Data Found"))
                  : GridView.builder(
                physics: const BouncingScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 1,
                  mainAxisSpacing: 15,
                  mainAxisExtent: 350,
                ),
                itemCount: homeSeeAllData.length,
                itemBuilder: (BuildContext context, int index) {
                  final homeData = homeSeeAllData[index];

                  return CustomMainCard(
                    image: homeData['image'] ?? '',
                    date: homeData['date'] ?? '',
                    title: homeData['title'] ?? '',
                    des: homeData['place'] ?? '',

                    joinText: (homeData['applied'] ?? false) ? 'Joined' : 'Join Event',
                    applied: homeData['applied'] ?? false,
                    showButton: showButtons,

                    width: double.infinity,
                    onTap: (homeData['applied'] ?? false)
                        ? () {}
                        : () {
                      customNoOfMemberBottomSheet(
                        context,
                        eventId: homeData['id'],
                        extra: true,
                        seeAll: true,
                      );
                    },

                    onNotJoinTap: () {
                    },

                    cardOnTap: () {
                      Navigator.pushNamed(
                        context,
                        AppPage.eventBroadcastDetailScreen,
                        arguments: {
                          'homeData': homeData,
                          'title': showButtons ? 'Event Detail' : 'Broadcast Detail',
                        },
                      );
                    },
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