import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:sizer/sizer.dart';
import 'package:svt_ppm/module/home/model/static_model.dart';
import 'package:svt_ppm/utils/constant/app_image.dart';
import 'package:svt_ppm/utils/constant/app_page.dart';
import 'package:svt_ppm/utils/widgets/custom_app_bar.dart';
import 'package:svt_ppm/utils/widgets/custom_card.dart';
import 'package:svt_ppm/utils/widgets/custom_widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});
  @override
  Widget build(BuildContext context) {
    List<StaticModel> appFeaturesList = [
      StaticModel(image: AppImage.kit, title: 'Schema'),
      StaticModel(image: AppImage.comity, title: 'Kit'),
      StaticModel(image: AppImage.exam, title: 'Exam (GK)'),
      StaticModel(image: AppImage.comity, title: 'Comity'),
    ];
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
                seeAllOnTap: () {
                  Navigator.pushNamed(context, AppPage.eventScreen);
                },
              ),
            ),
            Gap(20),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Padding(
                padding: const EdgeInsets.only(right: 6, left: 16),
                child: Row(
                  children: List.generate(20, (index) {
                    return CustomMainCard(
                      image:
                          'https://www.singaporeflyer.com/storage/meeting-events/June2021/yttsLF5xhRz8fvrnwpLa.png',
                      date: '15/05/2025',
                      title: 'It is a long established fact that...',
                      des:
                          'It is a long established fact that a reader will be distracted by the readable It is a long established fact that a reader will be distracted by the readable....',
                      joinText: 'Join Event',
                    );
                  }),
                ),
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
            Gap(20),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Padding(
                padding: const EdgeInsets.only(right: 6, left: 16),
                child: Row(
                  children: List.generate(20, (index) {
                    return CustomMainCard(
                      image:
                          'https://www.singaporeflyer.com/storage/meeting-events/June2021/yttsLF5xhRz8fvrnwpLa.png',
                      date: '15/05/2025',
                      title: 'It is a long established fact that...',
                      des:
                          'It is a long established fact that a reader will be distracted by the readable It is a long established fact that a reader will be distracted by the readable....',
                      joinText: 'Join Event',
                    );
                  }),
                ),
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
            Gap(20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: GridView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 8,
                  crossAxisSpacing: 8,
                  mainAxisExtent: 17.h,
                ),
                itemCount: appFeaturesList.length,
                itemBuilder: (BuildContext context, int index) {
                  return CustomAppFeatureCard(
                    onTap: () {
                      if (index == 0) {
                        Navigator.pushNamed(
                          context,
                          AppPage.appFeatureScreen,
                          arguments: {'title': 'Schema'},
                        );
                      } else if (index == 1) {
                        Navigator.pushNamed(
                          context,
                          AppPage.appFeatureScreen,
                          arguments: {'title': 'Kit'},
                        );
                      } else if (index == 2) {
                        Navigator.pushNamed(
                          context,
                          AppPage.appFeatureScreen,
                          arguments: {'title': 'Exam (GK)'},
                        );
                      } else {
                        Navigator.pushNamed(
                          context,
                          AppPage.appFeatureScreen,
                          arguments: {'title': 'Comity'},
                        );
                      }
                    },
                    image: appFeaturesList[index].image,
                    title: appFeaturesList[index].title,
                  );
                },
              ),
            ),

            Gap(20),
          ],
        ),
      ),
    );
  }
}
