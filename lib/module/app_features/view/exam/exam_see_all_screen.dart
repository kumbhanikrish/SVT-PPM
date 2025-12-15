import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:svt_ppm/module/app_features/view/exam/exam_custom_widget.dart';
import 'package:svt_ppm/utils/formatter/format.dart';
import 'package:svt_ppm/utils/widgets/custom_app_bar.dart';
import 'package:svt_ppm/utils/widgets/custom_card.dart';
import 'package:svt_ppm/utils/widgets/custom_downloader.dart';
import 'package:svt_ppm/utils/widgets/custom_text.dart';

class ExamSeeAllScreen extends StatelessWidget {
  final dynamic argument;
  const ExamSeeAllScreen({super.key, this.argument});
  @override
  Widget build(BuildContext context) {
    List<dynamic> examData = argument['examData'];
    String formattedTitle = argument['formattedTitle'];
    return Scaffold(
      appBar: CustomAppBar(
        title: formattedTitle,
        notificationOnTap: () {},
        actions: [],
      ),

      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 25),
        child:
            examData.isEmpty
                ? CustomEmpty()
                : GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 7,
                    mainAxisSpacing: 13,
                    mainAxisExtent: 23.h,
                  ),
                  itemCount: examData.length,
                  itemBuilder: (context, index) {
                    final member = examData[index];
                    return CustomCard(
                      showTag: true,
                      status: member['status'] ?? '',
                      image: member['photo'],
                      date: member['exam_date'] ?? getCurrentDateFormat(),
                      title: member['name'],
                      des: member['place'] ?? 'No Place',
                      joinText:
                          member['result'] != null
                              ? 'Result'
                              : member['hall_ticket'] != null
                              ? 'Hall Ticket'
                              : member['is_registered'] == true
                              ? 'Edit'
                              : 'Apply',
                      time: formatTo12Hour(time24h: member['exam_time']),
                      onTap: () {
                        if (member['hall_ticket'] != null) {
                          generateAndDownloadPdf(
                            title: '',
                            content: member['hall_ticket'],
                          );
                        } else if (member['result'] != null) {
                          generateAndDownloadPdf(
                            title: '',
                            content: member['result'],
                          );
                        } else {
                          languageBottomSheet(context, memberId: member['id']);
                        }
                      },
                    );
                  },
                ),
      ),
    );
  }
}
