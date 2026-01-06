import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:sizer/sizer.dart';
import 'package:svt_ppm/module/home/cubit/home_cubit.dart';
import 'package:svt_ppm/module/home/view/widget/custom_home_widget.dart';
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
      backgroundColor: Colors.white,
      appBar: CustomAppBar(
        title: widget.argument['title'] == 'events' ? 'Events' : 'Broadcast',
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
              Gap(25),

              BlocBuilder<HomeCubit, HomeState>(
                builder: (context, state) {
                  if (state is GetHomeState) {
                    homeSeeAllData = state.homeSeeAllModel;
                  }
                  return homeSeeAllData.isEmpty
                      ? SizedBox(height: 50.h, child: CustomEmpty())
                      : Column(
                    children: homeSeeAllData.entries.map((entry) {
                      final String key = entry.key;
                      final dynamic value = entry.value;
                      String displayTitle = formatTitle(key);

                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildSectionHeader(
                            title: displayTitle,
                            icon: widget.argument['title'] == 'events'
                                ? Icons.event_note
                                : Icons.campaign_rounded,

                            onTap: () {
                              if (value is List) {
                                Navigator.pushNamed(
                                  context,
                                  AppPage.eventViewAllScreen,
                                  arguments: {
                                    'title': displayTitle,
                                    'homeSeeAllData': value,
                                    'isEvent': widget.argument['title'] == 'events',
                                  },
                                );
                              }
                            },
                          ),
                          Gap(10),

                          value is List
                              ? value.isEmpty
                              ? CustomEmpty()
                              : HomeStyleSection(
                            dataList: value,
                            isEvent: widget.argument['title'] == 'events',
                          )
                              : SizedBox(),

                          Gap(20),
                          CustomDivider(),
                          Gap(20),
                        ],
                      );
                    }).toList(),
                  );
                },
              ),
              Gap(50),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionHeader({
    required String title,
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: InkWell(
        onTap: onTap,
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: AppColor.themePrimaryColor,
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: Colors.white, size: 14),
            ),
            const Gap(10),
            Text(
              title,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Colors.grey[700],
              ),
            ),
            const Spacer(),
            Icon(
              Icons.keyboard_double_arrow_right,
              color: AppColor.themePrimaryColor,
              size: 20,
            ),
          ],
        ),
      ),
    );
  }
}
class HomeStyleSection extends StatefulWidget {
  final List<dynamic> dataList;
  final bool isEvent;

  const HomeStyleSection({
    super.key,
    required this.dataList,
    required this.isEvent,
  });

  @override
  State<HomeStyleSection> createState() => _HomeStyleSectionState();
}

class _HomeStyleSectionState extends State<HomeStyleSection> {
  late PageController _pageController;
  final ValueNotifier<int> _indexNotifier = ValueNotifier(0);
  Timer? _timer;

  @override
  void initState() {
    super.initState();

    int initialIndex = 0;
    if (widget.dataList.length > 1) {
      initialIndex = widget.dataList.length * 1000;
    }

    _pageController = PageController(
      viewportFraction: 0.93,
      initialPage: initialIndex,
    );

    _startAutoScroll();
  }

  void _startAutoScroll() {
    if (widget.dataList.length <= 1) return;

    _timer = Timer.periodic(const Duration(seconds: 5), (Timer timer) {
      if (_pageController.hasClients && widget.dataList.isNotEmpty) {
        _pageController.nextPage(
          duration: const Duration(milliseconds: 800),
          curve: Curves.fastOutSlowIn,
        );
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 350,
          child: PageView.builder(
            controller: _pageController,
            itemCount: widget.dataList.length > 1 ? null : 1,

            onPageChanged: (index) {
              _indexNotifier.value = index % widget.dataList.length;
            },
            itemBuilder: (context, index) {
              final int trueIndex = index % widget.dataList.length;
              final eventItem = widget.dataList[trueIndex];

              return CustomMainCard(
                image: eventItem['image'] ?? '',
                date: eventItem['date'] ?? '',
                title: eventItem['title'] ?? '',
                des: eventItem['place'] ?? '',

                joinText: (eventItem['applied'] ?? false) ? 'Joined' : 'Join Event',
                applied: eventItem['applied'] ?? false,
                showButton: widget.isEvent,
                width: null,

                onTap: (eventItem['applied'] ?? false)
                    ? () {}
                    : () {
                  customNoOfMemberBottomSheet(
                    context,
                    eventId: eventItem['id'],
                    extra: true,
                    seeAll: true,
                  );
                },
                onNotJoinTap: () {},
                cardOnTap: () {
                  Navigator.pushNamed(
                    context,
                    AppPage.eventBroadcastDetailScreen,
                    arguments: {
                      'homeData': eventItem,
                      'title': widget.isEvent ? 'Event Detail' : 'Broadcast Detail',
                    },
                  );
                },
              );
            },
          ),
        ),

        Gap(8),

        if (widget.dataList.length > 1)
          ValueListenableBuilder<int>(
            valueListenable: _indexNotifier,
            builder: (context, currentIndex, _) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(widget.dataList.length, (index) {
                  return Container(
                    margin: const EdgeInsets.symmetric(horizontal: 3),
                    height: 6,
                    width: 6,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: currentIndex == index
                          ? AppColor.themePrimaryColor
                          : Colors.grey.withOpacity(0.3),
                    ),
                  );
                }),
              );
            },
          ),
      ],
    );
  }
}