import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:svt_ppm/utils/widgets/custom_card.dart';

class UpcomingEventSection extends StatelessWidget {
  const UpcomingEventSection({super.key});
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          mainAxisSpacing: 13,
          mainAxisExtent: 22.h,
        ),
        itemCount: 20,
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
    );
  }
}
