import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:sizer/sizer.dart';
import 'package:svt_ppm/main.dart';
import 'package:svt_ppm/module/auth/model/login_model.dart';
import 'package:svt_ppm/module/home/cubit/home_cubit.dart';
import 'package:svt_ppm/module/home/model/home_model.dart';
import 'package:svt_ppm/module/home/model/static_model.dart';
import 'package:svt_ppm/module/home/view/widget/custom_home_widget.dart';
import 'package:svt_ppm/utils/constant/app_image.dart';
import 'package:svt_ppm/utils/constant/app_page.dart';
import 'package:svt_ppm/utils/widgets/custom_app_bar.dart';
import 'package:svt_ppm/utils/widgets/custom_card.dart';
import 'package:svt_ppm/utils/widgets/custom_image.dart';
import 'package:svt_ppm/utils/widgets/custom_text.dart';
import 'package:svt_ppm/utils/widgets/custom_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ValueNotifier<LoginModel?> loginModelNotifier = ValueNotifier(null);
  HomeModel homeModel = HomeModel(broadcasts: [], events: []);
  Set<int> selectedMemberIds = {};
  Future<void> loadLoginData() async {
    final model = await localDataSaver.getLoginModel();
    loginModelNotifier.value = model;
  }

  @override
  void initState() {
    loadLoginData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<StaticModel> appFeaturesList = [
      StaticModel(image: AppImage.kit, title: 'Schema'),
      StaticModel(image: AppImage.comity, title: 'Kit'),
      StaticModel(image: AppImage.exam, title: 'Exam (GK)'),
      StaticModel(image: AppImage.comity, title: 'Comity'),
    ];

    HomeCubit homeCubit = BlocProvider.of<HomeCubit>(context);
    homeCubit.getHomeData(context);
    return Scaffold(
      appBar: CustomAppBar(
        title: 'SVTPPM App',
        actions: [
          ValueListenableBuilder<LoginModel?>(
            valueListenable: loginModelNotifier,
            builder: (BuildContext context, LoginModel? model, Widget? child) {
              String imageUrl = model?.photo ?? '';
              return InkWell(
                onTap: () {
                  Navigator.pushNamed(context, AppPage.profileScreen);
                },
                child: Padding(
                  padding: const EdgeInsets.only(left: 16, bottom: 10),
                  child: ClipOval(
                    child: CustomCachedImage(
                      imageUrl: imageUrl,
                      height: 40,
                      width: 40,
                    ),
                  ),
                ),
              );
            },
          ),
          Gap(12),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Gap(25),

            BlocBuilder<HomeCubit, HomeState>(
              builder: (context, state) {
                if (state is GetHomeState) {
                  homeModel = state.homeModel;
                }
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: CustomTitleSeeAllWidget(
                        title: 'List of Event',
                        seeAllOnTap: () {
                          Navigator.pushNamed(context, AppPage.eventScreen);
                        },
                      ),
                    ),
                    Gap(20),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Padding(
                        padding: const EdgeInsets.only(right: 6, left: 16),
                        child:
                            homeModel.events.isEmpty
                                ? CustomEmpty()
                                : Row(
                                  children: List.generate(
                                    homeModel.events.length,
                                    (index) {
                                      Broadcast event = homeModel.events[index];
                                      return CustomMainCard(
                                        onTap: () {
                                          customNoOfMemberBottomSheet(
                                            context,
                                            eventId: event.id,
                                            extra: true,
                                            
                                          );
                                        },

                                        image: event.image,
                                        date: event.date,
                                        title: event.title,
                                        des: event.place,
                                        joinText: 'Join Event',
                                      );
                                    },
                                  ),
                                ),
                      ),
                    ),

                    Gap(24),
                    CustomDivider(),
                    Gap(24),

                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: CustomTitleSeeAllWidget(
                        title: 'Broadcast message',
                        seeAllOnTap: () {
                          Navigator.pushNamed(context, AppPage.eventScreen);
                        },
                      ),
                    ),
                    Gap(20),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Padding(
                        padding: const EdgeInsets.only(right: 6, left: 16),
                        child:
                            homeModel.broadcasts.isEmpty
                                ? CustomEmpty()
                                : Row(
                                  children: List.generate(
                                    homeModel.broadcasts.length,
                                    (index) {
                                      Broadcast broadcast =
                                          homeModel.broadcasts[index];
                                      return CustomMainCard(
                                        image: broadcast.image,
                                        date: broadcast.date,
                                        title: broadcast.title,
                                        des: broadcast.place,
                                        onTap: () {},
                                        joinText: 'Join Event',
                                      );
                                    },
                                  ),
                                ),
                      ),
                    ),
                    Gap(24),
                    CustomDivider(),

                    Gap(24),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: CustomTitleSeeAllWidget(
                        title: 'App Features',
                        seeAllOnTap: () {},
                      ),
                    ),
                  ],
                );
              },
            ),
            Gap(20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: GridView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 8,
                  crossAxisSpacing: 8,
                  mainAxisExtent: 17.h,
                ),
                itemCount: appFeaturesList.length,
                itemBuilder: (BuildContext context, int index) {
                  return CustomAppFeatureCard(
                    onTap: () {
                      if (index == 0) {
                        Navigator.pushNamed(
                          context,
                          AppPage.appFeatureScreen,
                          arguments: {'title': 'Schema'},
                        );
                      } else if (index == 1) {
                        Navigator.pushNamed(
                          context,
                          AppPage.appFeatureScreen,
                          arguments: {'title': 'Kit'},
                        );
                      } else if (index == 2) {
                        Navigator.pushNamed(
                          context,
                          AppPage.appFeatureScreen,
                          arguments: {'title': 'Exam (GK)'},
                        );
                      } else {
                        Navigator.pushNamed(
                          context,
                          AppPage.appFeatureScreen,
                          arguments: {'title': 'Comity'},
                        );
                      }
                    },
                    image: appFeaturesList[index].image,
                    title: appFeaturesList[index].title,
                  );
                },
              ),
            ),

            Gap(20),
          ],
        ),
      ),
    );
  }
}
