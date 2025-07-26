import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:sizer/sizer.dart';
import 'package:svt_ppm/utils/constant/app_image.dart';
import 'package:svt_ppm/utils/constant/app_page.dart';
import 'package:svt_ppm/utils/widgets/custom_card.dart';
import 'package:svt_ppm/utils/widgets/custom_widget.dart';

class ExamScreen extends StatelessWidget {
  const ExamScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Gap(25),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: CustomTitleSeeAllWidget(
              title: 'Upcoming Exam (GK)',
              image: AppImage.president,
              seeAllOnTap: () {},
              child: Padding(
                padding: const EdgeInsets.only(left: 20, top: 10, bottom: 10),
                child: SvgPicture.asset(AppImage.rightArrow),
              ),
            ),
          ),

          Gap(20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: GridView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 7,
                mainAxisSpacing: 13,

                mainAxisExtent: 22.h,
              ),
              itemCount: 3,
              itemBuilder: (BuildContext context, int index) {
                return CustomCard(
                  image:
                      'https://images.unsplash.com/photo-1633332755192-727a05c4013d?fm=jpg&q=60&w=3000&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mnx8dXNlcnxlbnwwfHwwfHx8MA%3D%3D',
                  date: '15/05/2025',
                  title: 'Albert Flores',
                  des: 'Yuva - Team of Comity',
                  joinText: 'Apply',
                  time: '12:00pm',
                  onTap: () {
                    Navigator.pushNamed(context, AppPage.examFormScreen);
                  },
                );
              },
            ),
          ),

          CustomDivider(),
          Gap(10),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: CustomTitleSeeAllWidget(
              title: 'Current Exam (GK)',
              image: AppImage.president,
              seeAllOnTap: () {},
              child: Padding(
                padding: const EdgeInsets.only(left: 20, top: 10, bottom: 10),
                child: SvgPicture.asset(AppImage.rightArrow),
              ),
            ),
          ),
          Gap(20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: GridView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 7,
                mainAxisSpacing: 13,

                mainAxisExtent: 22.h,
              ),
              itemCount: 3,
              itemBuilder: (BuildContext context, int index) {
                return CustomCard(
                  image:
                      'https://images.unsplash.com/photo-1633332755192-727a05c4013d?fm=jpg&q=60&w=3000&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mnx8dXNlcnxlbnwwfHwwfHx8MA%3D%3D',
                  date: '15/05/2025',
                  title: 'Albert Flores',
                  des: 'Yuva - Team of Comity',
                  joinText: 'Apply',
                  time: '12:00pm',
                  onTap: () {
                    Navigator.pushNamed(context, AppPage.examFormScreen);
                  },
                );
              },
            ),
          ),

          CustomDivider(),
          Gap(10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: CustomTitleSeeAllWidget(
              title: 'Old Participant Exam (GK)',
              image: AppImage.president,
              seeAllOnTap: () {},
              child: Padding(
                padding: const EdgeInsets.only(left: 20, top: 10, bottom: 10),
                child: SvgPicture.asset(AppImage.rightArrow),
              ),
            ),
          ),
          Gap(20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: GridView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 7,
                mainAxisSpacing: 13,

                mainAxisExtent: 19.h,
              ),
              itemCount: 3,
              itemBuilder: (BuildContext context, int index) {
                return CustomCard(
                  image:
                      'https://images.unsplash.com/photo-1633332755192-727a05c4013d?fm=jpg&q=60&w=3000&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mnx8dXNlcnxlbnwwfHwwfHx8MA%3D%3D',
                  date: '15/05/2025',
                  title: 'Albert Flores',
                  des: 'Yuva - Team of Comity',
                  joinText: 'Apply',
                  time: '12:00pm',
                  imageBorderRadius: BorderRadius.only(
                    topLeft: Radius.circular(15),
                    topRight: Radius.circular(15),
                  ),
                  showButton: false,
                );
              },
            ),
          ),
          Gap(10.h),
        ],
      ),
    );
  }
}
