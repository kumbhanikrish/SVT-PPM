import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:svt_ppm/utils/constant/app_image.dart';
import 'package:svt_ppm/utils/theme/colors.dart';
import 'package:svt_ppm/utils/widgets/custom_list_tile.dart';
import 'package:svt_ppm/utils/widgets/custom_widget.dart';

class SchemaSection extends StatelessWidget {
  const SchemaSection({super.key});
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 25),
        child: Column(
          children: <Widget>[
            CustomTitleSeeAllWidget(
              title: 'Schema Details',
              seeAllOnTap: () {},
              image: AppImage.schemaDetails,
              child: SizedBox(),
            ),
            Gap(16),

            ListView.separated(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              separatorBuilder: (context, index) {
                return Gap(10);
              },
              itemCount: 20,
              itemBuilder: (context, index) {
                return CustomListTile(
                  borderRadius: BorderRadius.circular(15),
                  tileColor: AppColor.fillColor,
                  contentPadding: EdgeInsets.symmetric(horizontal: 12),
                  text: '${index + 1}. It is a long established fact that...',
                  leadingImage: '',
                  trailing: SvgPicture.asset(AppImage.pdf),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
