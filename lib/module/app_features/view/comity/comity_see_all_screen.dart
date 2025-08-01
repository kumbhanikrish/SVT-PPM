import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:svt_ppm/utils/widgets/custom_app_bar.dart';
import 'package:svt_ppm/utils/widgets/custom_card.dart';

class ComitySeeAllScreen extends StatelessWidget {
  final dynamic argument;
  const ComitySeeAllScreen({super.key, this.argument});
  @override
  Widget build(BuildContext context) {
    List<dynamic> comityData = argument['comityData'];
    String formattedTitle = argument['formattedTitle'];
    return Scaffold(
      appBar: CustomAppBar(
        title: formattedTitle,
        notificationOnTap: () {},
        actions: [],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 25),
        child: GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 7,
            mainAxisSpacing: 13,
            mainAxisExtent: 21.h,
          ),
          itemCount: comityData.length,
          itemBuilder: (context, index) {
            final member = comityData[index];
            return CustomTeamCard(
              image: member['photo'],
              name: member['name'],
              number: member['mobile_no'],
              position: member['village_name'],
            );
          },
        ),
      ),
    );
  }
}
