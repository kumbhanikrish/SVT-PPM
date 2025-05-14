import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:sizer/sizer.dart';
import 'package:svt_ppm/utils/constant/app_image.dart';
import 'package:svt_ppm/utils/constant/app_page.dart';
import 'package:svt_ppm/utils/widgets/custom_app_bar.dart';
import 'package:svt_ppm/utils/widgets/custom_card.dart';
import 'package:svt_ppm/utils/widgets/custom_widget.dart';

class EventScreen extends StatelessWidget {
  const EventScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Event', notificationOnTap: () {}),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Gap(25),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: CustomTitleSeeAllWidget(
                title: 'Upcoming Event',
                image: AppImage.dateTime,
                seeAllOnTap: () {
                  Navigator.pushNamed(
                    context,
                    AppPage.eventViewAllScreen,
                    arguments: {'title': 'Upcoming Event'},
                  );
                },
                child: Padding(
                  padding: const EdgeInsets.only(left: 20, top: 10, bottom: 10),
                  child: SvgPicture.asset(AppImage.rightArrow),
                ),
              ),
            ),
            Gap(20),
            Padding(
              padding: const EdgeInsets.only(left: 16, right: 10),
              child: GridView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,

                  mainAxisExtent: 22.h,
                ),
                itemCount: 3,
                itemBuilder: (BuildContext context, int index) {
                  return CustomCard(
                    image:
                        'https://www.singaporeflyer.com/storage/meeting-events/June2021/yttsLF5xhRz8fvrnwpLa.png',
                    date: '15/05/2025',
                    title: 'Albert Flores',
                    des: 'Yuva - Team of Comity',
                    joinText: 'Join Event',
                    time: '12:00pm',
                  );
                },
              ),
            ),

            CustomDivider(),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: CustomTitleSeeAllWidget(
                title: 'Current Event',
                image: AppImage.dateTime,
                seeAllOnTap: () {
                  Navigator.pushNamed(
                    context,
                    AppPage.eventViewAllScreen,
                    arguments: {'title': 'Current Event'},
                  );
                },
                child: Padding(
                  padding: const EdgeInsets.only(left: 20, top: 10, bottom: 10),
                  child: SvgPicture.asset(AppImage.rightArrow),
                ),
              ),
            ),
            Gap(20),
            Padding(
              padding: const EdgeInsets.only(left: 16, right: 10),
              child: GridView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,

                  mainAxisExtent: 22.h,
                ),
                itemCount: 3,
                itemBuilder: (BuildContext context, int index) {
                  return CustomCard(
                    image:
                        'https://www.singaporeflyer.com/storage/meeting-events/June2021/yttsLF5xhRz8fvrnwpLa.png',
                    date: '15/05/2025',
                    title: 'Albert Flores',
                    des: 'Yuva - Team of Comity',
                    joinText: 'Join Event',
                    time: '12:00pm',
                  );
                },
              ),
            ),

            CustomDivider(),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: CustomTitleSeeAllWidget(
                title: 'Past Event',
                seeAllOnTap: () {
                  Navigator.pushNamed(
                    context,
                    AppPage.eventViewAllScreen,
                    arguments: {'title': 'Past Event'},
                  );
                },
                image: AppImage.pastEvent,
                child: Padding(
                  padding: const EdgeInsets.only(left: 20, top: 10, bottom: 10),
                  child: SvgPicture.asset(AppImage.rightArrow),
                ),
              ),
            ),
            Gap(20),
            Padding(
              padding: const EdgeInsets.only(left: 16, right: 10),
              child: GridView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,

                  mainAxisExtent: 19.h,
                ),
                itemCount: 3,
                itemBuilder: (BuildContext context, int index) {
                  return CustomCard(
                    borderRadius: BorderRadius.circular(15),
                    imageBorderRadius: BorderRadius.only(
                      topLeft: Radius.circular(15),
                      topRight: Radius.circular(15),
                    ),
                    showButton: false,
                    image:
                        'https://www.singaporeflyer.com/storage/meeting-events/June2021/yttsLF5xhRz8fvrnwpLa.png',
                    date: '15/05/2025',
                    title: 'Albert Flores',
                    des: 'Yuva - Team of Comity',
                    joinText: 'Join Event',
                    time: '12:00pm',
                  );
                },
              ),
            ),
            Gap(10),
          ],
        ),
      ),
    );
  }
}
