import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:sizer/sizer.dart';
import 'package:svt_ppm/utils/constant/app_image.dart';
import 'package:svt_ppm/utils/widgets/custom_card.dart';
import 'package:svt_ppm/utils/widgets/custom_widget.dart';

class ComitySection extends StatelessWidget {
  const ComitySection({super.key});
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          Gap(10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 15),
            child: CustomTitleSeeAllWidget(
              title: 'List of Comity',
              seeAllOnTap: () {},
              image: AppImage.schemaDetails,
              child: SizedBox(),
            ),
          ),

          CustomDivider(),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 15),
            child: CustomTitleSeeAllWidget(
              title: 'President',
              seeAllOnTap: () {},
              image: AppImage.president,
              child: SizedBox(),
            ),
          ),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: CustomPresidentCard(
              image:
                  'https://images.unsplash.com/photo-1633332755192-727a05c4013d?fm=jpg&q=60&w=3000&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mnx8dXNlcnxlbnwwfHwwfHx8MA%3D%3D',
              name: 'Ronald Richards',
              position: 'Vise-President of Commity',
              des:
                  'It is a long established fact that. It is a long established fact that. ',
            ),
          ),
          Gap(15),
          CustomDivider(),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 15),
            child: CustomTitleSeeAllWidget(
              title: 'Vise - President',
              seeAllOnTap: () {},
              image: AppImage.president,
              child: SizedBox(),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: CustomPresidentCard(
              image:
                  'https://images.unsplash.com/photo-1633332755192-727a05c4013d?fm=jpg&q=60&w=3000&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mnx8dXNlcnxlbnwwfHwwfHx8MA%3D%3D',
              name: 'Ronald Richards',
              position: 'Vise-President of Commity',
              des:
                  'It is a long established fact that. It is a long established fact that. ',
            ),
          ),
          Gap(15),
          CustomDivider(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 15),
            child: CustomTitleSeeAllWidget(
              title: 'Yuva - Team',
              seeAllOnTap: () {},
              image: AppImage.president,
              child: SizedBox(),
            ),
          ),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: GridView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 7,
                mainAxisSpacing: 13,

                mainAxisExtent: 16.h,
              ),
              itemCount: 3,
              itemBuilder: (BuildContext context, int index) {
                return CustomTeamCard(
                  image:
                      'https://images.unsplash.com/photo-1633332755192-727a05c4013d?fm=jpg&q=60&w=3000&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mnx8dXNlcnxlbnwwfHwwfHx8MA%3D%3D',
                  name: 'Albert Flores',
                  position: 'Yuva - Team of Commity',
                );
              },
            ),
          ),

          Gap(15),
          CustomDivider(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 15),
            child: CustomTitleSeeAllWidget(
              title: 'User Team',
              seeAllOnTap: () {},
              image: AppImage.president,
              child: SizedBox(),
            ),
          ),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: GridView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 7,
                mainAxisSpacing: 13,

                mainAxisExtent: 16.h,
              ),
              itemCount: 3,
              itemBuilder: (BuildContext context, int index) {
                return CustomTeamCard(
                  image:
                      'https://images.unsplash.com/photo-1633332755192-727a05c4013d?fm=jpg&q=60&w=3000&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mnx8dXNlcnxlbnwwfHwwfHx8MA%3D%3D',
                  name: 'Albert Flores',
                  position: 'Yuva - Team of Commity',
                );
              },
            ),
          ),
          Gap(16),
        ],
      ),
    );
  }
}
