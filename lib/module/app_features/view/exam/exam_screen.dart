import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:sizer/sizer.dart';
import 'package:svt_ppm/module/app_features/cubit/exam/exam_cubit.dart';
import 'package:svt_ppm/module/app_features/view/exam/exam_custom_widget.dart';
import 'package:svt_ppm/utils/constant/app_image.dart';
import 'package:svt_ppm/utils/constant/app_page.dart';
import 'package:svt_ppm/utils/formatter/format.dart';
import 'package:svt_ppm/utils/theme/colors.dart';
import 'package:svt_ppm/utils/widgets/custom_card.dart';
import 'package:svt_ppm/utils/widgets/custom_downloader.dart';
import 'package:svt_ppm/utils/widgets/custom_text.dart';
import 'package:svt_ppm/utils/widgets/custom_widget.dart';

class ExamScreen extends StatefulWidget {
  const ExamScreen({super.key});

  @override
  State<ExamScreen> createState() => _ExamScreenState();
}

class _ExamScreenState extends State<ExamScreen> {
  Map<String, dynamic> examData = {};

  @override
  void initState() {
    ExamCubit examCubit = BlocProvider.of<ExamCubit>(context);
    examCubit.init();
    examCubit.getExamData(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ExamCubit examCubit = BlocProvider.of<ExamCubit>(context);

    return RefreshIndicator(
      backgroundColor: AppColor.whiteColor,
      color: AppColor.themePrimaryColor,
      elevation: 0,
      onRefresh: () {
        return examCubit.getExamData(context);
      },
      child: BlocBuilder<ExamCubit, ExamState>(
        builder: (context, state) {
          if (state is GetExamState) {
            examData = state.examData;
          }
          return examData.isEmpty ||
                  examData.values.every((members) => (members as List).isEmpty)
              ? CustomEmpty()
              : SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children:
                      examData.entries.map((entry) {
                        final String year = entry.key;
                        final List<dynamic> members = entry.value;

                        String formattedTitle = formatTitle(year);

                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Year Title
                            Gap(10),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 15,
                              ),
                              child: CustomTitleSeeAllWidget(
                                title: formattedTitle,
                                seeAllOnTap: () {
                                  Navigator.pushNamed(
                                    context,
                                    AppPage.examSeeAllScreen,
                                    arguments: {
                                      'examData': members,
                                      'formattedTitle': formattedTitle,
                                    },
                                  );
                                },
                                image: '',
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                    left: 20,
                                    // top: 10,
                                    bottom: 10,
                                  ),
                                  child: SvgPicture.asset(AppImage.rightArrow),
                                ),
                              ),
                            ),

                            // Grid of members
                            SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 16,
                                ),
                                child: SizedBox(
                                  width: 100.w,
                                  height: 23.2.h,
                                  child:
                                      members.isEmpty
                                          ? CustomEmpty()
                                          : GridView.builder(
                                            scrollDirection: Axis.horizontal,
                                            physics:
                                                const BouncingScrollPhysics(), // optional smooth scroll

                                            gridDelegate:
                                                SliverGridDelegateWithFixedCrossAxisCount(
                                                  crossAxisCount: 1,
                                                  crossAxisSpacing: 7,
                                                  mainAxisSpacing: 7,
                                                  mainAxisExtent: 21.h,
                                                ),
                                            itemCount: members.length,
                                            itemBuilder: (context, index) {
                                              final member = members[index];
                                              return CustomCard(
                                                image: member['photo'],
                                                status: member['status'] ?? '',
                                                showTag: true,
                                                date:
                                                    member['exam_date'] ??
                                                    getCurrentDateFormat(),
                                                applied:
                                                    member['is_registered'],

                                                title: member['name'],
                                                des: member['place'] ?? '',
                                                joinText:
                                                    member['result'] != null
                                                        ? 'Result'
                                                        : member['hall_ticket'] !=
                                                            null
                                                        ? 'Hall Ticket'
                                                        : member['is_registered'] ==
                                                            true
                                                        ? 'Edit'
                                                        : 'Apply',
                                                time: formatTo12Hour(
                                                  time24h: member['exam_time'],
                                                ),
                                                onTap: () {
                                                  if (member['hall_ticket'] !=
                                                      null) {
                                                    generateAndDownloadPdf(
                                                      title: '',
                                                      content:
                                                          member['hall_ticket'],
                                                    );
                                                  } else if (member['result'] !=
                                                      null) {
                                                    generateAndDownloadPdf(
                                                      title: '',
                                                      content: member['result'],
                                                    );
                                                  } else {
                                                    languageBottomSheet(
                                                      context,
                                                      memberId: member['id'],
                                                    );
                                                  }
                                                },
                                              );
                                            },
                                          ),
                                ),
                              ),
                            ),
                            Gap(15),
                            CustomDivider(),
                          ],
                        );
                      }).toList(),
                ),
              );
        },
      ),
    );
  }
}
