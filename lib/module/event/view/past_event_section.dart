import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:svt_ppm/utils/widgets/custom_card.dart';

class PastEventSection extends StatelessWidget {
  const PastEventSection({super.key});
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          mainAxisSpacing: 13,

          mainAxisExtent: 19.h,
        ),
        itemCount: 20,
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
    );
  }
}
