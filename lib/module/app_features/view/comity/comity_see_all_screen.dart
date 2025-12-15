import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
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
    bool showNo = argument['showNo'] ?? false;
    return Scaffold(
      appBar: CustomAppBar(
        title: formattedTitle,
        notificationOnTap: () {},
        actions: [],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 25),
        child: ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),

          itemCount: comityData.length,
          itemBuilder: (context, index) {
            final member = comityData[index];
            return CustomPresidentCard(
              image: member['photo'],
              name: member['name'],
              number: showNo ? member['mobile_no'] : '',
              position: member['village_name'],
            );
          },
          separatorBuilder: (BuildContext context, int index) {
            return Gap(16);
          },
        ),
      ),
    );
  }
}
