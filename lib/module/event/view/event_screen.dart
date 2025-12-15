import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:sizer/sizer.dart';
import 'package:svt_ppm/module/home/cubit/home_cubit.dart';
import 'package:svt_ppm/module/home/view/widget/custom_home_widget.dart';
import 'package:svt_ppm/utils/constant/app_image.dart';
import 'package:svt_ppm/utils/constant/app_page.dart';
import 'package:svt_ppm/utils/formatter/format.dart';
import 'package:svt_ppm/utils/theme/colors.dart';
import 'package:svt_ppm/utils/widgets/custom_app_bar.dart';
import 'package:svt_ppm/utils/widgets/custom_card.dart';
import 'package:svt_ppm/utils/widgets/custom_text.dart';
import 'package:svt_ppm/utils/widgets/custom_widget.dart';

class EventScreen extends StatefulWidget {
  final dynamic argument;
  const EventScreen({super.key, this.argument});

  @override
  State<EventScreen> createState() => _EventScreenState();
}

class _EventScreenState extends State<EventScreen> {
  @override
  void initState() {
    HomeCubit homeCubit = BlocProvider.of<HomeCubit>(context);

    homeCubit.init();
    homeCubit.getHomeSeeAll(context, type: widget.argument['title']);
    super.initState();
  }

  Map<String, dynamic> homeSeeAllData = {};

  @override
  Widget build(BuildContext context) {
    HomeCubit homeCubit = BlocProvider.of<HomeCubit>(context);

    return Scaffold(
      appBar: CustomAppBar(
        title: widget.argument['title'] == 'events' ? 'Events' : 'BoardCast',
        notificationOnTap: () {},
        actions: [],
      ),
      body: RefreshIndicator(
        backgroundColor: AppColor.whiteColor,
        color: AppColor.themePrimaryColor,
        elevation: 0,
        onRefresh: () {
          return homeCubit.getHomeSeeAll(
            context,
            type: widget.argument['title'],
          );
        },
        child: SingleChildScrollView(
          child: Column(
            children: [
              BlocBuilder<HomeCubit, HomeState>(
                builder: (context, state) {
                  if (state is GetHomeState) {
                    homeSeeAllData = state.homeSeeAllModel;
                  }
                  return homeSeeAllData.isEmpty
                      ? SizedBox(height: 50.h, child: CustomEmpty())
                      : Column(
                        children:
                            homeSeeAllData.entries.map((entry) {
                              final String key = entry.key;
                              final dynamic value = entry.value;
                              String formattedTitle = formatTitle(key);

                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Gap(10),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 16,
                                    ),
                                    child: CustomTitleSeeAllWidget(
                                      title: formattedTitle,
                                      image: AppImage.dateTime,
                                      seeAllOnTap: () {
                                        if (value is List) {
                                          Navigator.pushNamed(
                                            context,
                                            AppPage.eventViewAllScreen,
                                            arguments: {
                                              'title': formattedTitle,
                                              'homeSeeAllData': value,
                                            },
                                          );
                                        }
                                      },
                                      child:
                                          value is List
                                              ? Padding(
                                                padding: const EdgeInsets.only(
                                                  left: 20,
                                                  top: 10,
                                                  bottom: 10,
                                                ),
                                                child: SvgPicture.asset(
                                                  AppImage.rightArrow,
                                                ),
                                              )
                                              : SizedBox(),
                                    ),
                                  ),
                                  Gap(10),
                                  value is List
                                      ? value.isEmpty
                                          ? CustomEmpty()
                                          : Padding(
                                            padding: const EdgeInsets.symmetric(
                                              horizontal: 16,
                                            ),
                                            child: SizedBox(
                                              width: 100.w,
                                              height: 23.h,
                                              child: GridView.builder(
                                                shrinkWrap: true,
                                                scrollDirection:
                                                    Axis.horizontal,
                                                physics:
                                                    const BouncingScrollPhysics(),
                                                gridDelegate:
                                                    SliverGridDelegateWithFixedCrossAxisCount(
                                                      crossAxisCount: 1,
                                                      crossAxisSpacing: 7,
                                                      mainAxisSpacing: 13,

                                                      mainAxisExtent: 22.h,
                                                    ),
                                                itemCount: value.length,
                                                itemBuilder: (context, index) {
                                                  final homeSeeAllData =
                                                      value[index];
                                                  return CustomCard(
                                                    onTap:
                                                        homeSeeAllData['applied']
                                                            ? null
                                                            : () {
                                                              customNoOfMemberBottomSheet(
                                                                context,
                                                                eventId:
                                                                    homeSeeAllData['id'],
                                                                extra: true,
                                                                seeAll: true
                                                              );
                                                            },
                                                    cardOnTap: () {
                                                      Navigator.pushNamed(
                                                        context,
                                                        AppPage
                                                            .eventBroadcastDetailScreen,
                                                        arguments: {
                                                          'homeData':
                                                              homeSeeAllData,
                                                          'title':
                                                              widget.argument['title'] ==
                                                                      'events'
                                                                  ? 'Event Detail'
                                                                  : 'BoardCast Detail',
                                                        },
                                                      );
                                                    },
                                                    image:
                                                        homeSeeAllData['image'],
                                                    date:
                                                        homeSeeAllData['date'],
                                                    title:
                                                        homeSeeAllData['title'],
                                                    des:
                                                        homeSeeAllData['place'],
                                                    showButton:
                                                        widget.argument['title'] ==
                                                                'events'
                                                            ? true
                                                            : false,
                                                    joinText: 'Join Event',
                                                    time: '',
                                                    applied:
                                                        homeSeeAllData['applied'],
                                                  );
                                                },
                                              ),
                                            ),
                                          )
                                      : SizedBox(),

                                  CustomDivider(),
                                ],
                              );
                            }).toList(),
                      );
                },
              ),

              Gap(60.h),
            ],
          ),
        ),
      ),
    );
  }
}
