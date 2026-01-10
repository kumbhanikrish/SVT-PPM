// // // import 'package:flutter/material.dart';
// // // import 'package:flutter_bloc/flutter_bloc.dart';
// // // import 'package:gap/gap.dart';
// // // import 'package:sizer/sizer.dart';
// // // import 'package:svt_ppm/main.dart';
// // // import 'package:svt_ppm/module/auth/model/login_model.dart';
// // // import 'package:svt_ppm/module/home/cubit/home_cubit.dart';
// // // import 'package:svt_ppm/module/home/model/home_model.dart';
// // // import 'package:svt_ppm/module/home/model/static_model.dart';
// // // import 'package:svt_ppm/module/home/view/app_drawer.dart';
// // // import 'package:svt_ppm/module/home/view/widget/custom_home_widget.dart';
// // // import 'package:svt_ppm/module/profile/view/qr_profile_screen.dart';
// // // import 'package:svt_ppm/utils/constant/app_image.dart';
// // // import 'package:svt_ppm/utils/constant/app_page.dart';
// // // import 'package:svt_ppm/utils/theme/colors.dart';
// // // import 'package:svt_ppm/utils/widgets/custom_app_bar.dart';
// // // import 'package:svt_ppm/utils/widgets/custom_card.dart';
// // // import 'package:svt_ppm/utils/widgets/custom_image.dart';
// // // import 'package:svt_ppm/utils/widgets/custom_text.dart';
// // // import 'package:svt_ppm/utils/widgets/custom_widget.dart';
// // //
// // // class HomeScreen extends StatefulWidget {
// // //   const HomeScreen({super.key});
// // //
// // //   @override
// // //   State<HomeScreen> createState() => _HomeScreenState();
// // // }
// // //
// // // class _HomeScreenState extends State<HomeScreen> {
// // //   final ValueNotifier<LoginModel?> loginModelNotifier = ValueNotifier(null);
// // //   HomeModel homeModel = HomeModel(broadcasts: [], events: []);
// // //   Set<int> selectedMemberIds = {};
// // //
// // //   Future<void> loadLoginData() async {
// // //     final model = await localDataSaver.getLoginModel();
// // //     loginModelNotifier.value = model;
// // //   }
// // //
// // //   @override
// // //   void initState() {
// // //     loadLoginData();
// // //     HomeCubit homeCubit = BlocProvider.of<HomeCubit>(context);
// // //     homeCubit.getHomeData(context);
// // //     super.initState();
// // //   }
// // //
// // //   @override
// // //   Widget build(BuildContext context) {
// // //     List<StaticModel> appFeaturesList = [
// // //       StaticModel(image: AppImage.kit, title: 'Schema'),
// // //       StaticModel(image: AppImage.comity, title: 'Kit'),
// // //       StaticModel(image: AppImage.exam, title: 'Exam (GK)'),
// // //       StaticModel(image: AppImage.comity, title: 'Comity'),
// // //     ];
// // //
// // //     HomeCubit homeCubit = BlocProvider.of<HomeCubit>(context);
// // //
// // //     return Scaffold(
// // //       appBar: CustomAppBar(
// // //         title: 'SVTPPM',
// // //         actions: [
// // //           ValueListenableBuilder<LoginModel?>(
// // //             valueListenable: loginModelNotifier,
// // //             builder: (BuildContext context, LoginModel? model, Widget? child) {
// // //               String imageUrl = model?.photo ?? '';
// // //               return InkWell(
// // //                 onTap: () {
// // //                   Navigator.push(
// // //                     context,
// // //                     MaterialPageRoute(
// // //                       builder: (context) => const QrProfileScreen(),
// // //                     ),
// // //                   );
// // //                 },
// // //                 child: Padding(
// // //                   padding: const EdgeInsets.only(left: 16, bottom: 10),
// // //                   child: ClipOval(
// // //                     child: CustomCachedImage(
// // //                       imageUrl: imageUrl,
// // //                       height: 40,
// // //                       width: 40,
// // //                     ),
// // //                   ),
// // //                 ),
// // //               );
// // //             },
// // //           ),
// // //           Gap(12),
// // //         ],
// // //       ),
// // //       drawer: AppDrawer(loginModelNotifier: loginModelNotifier),
// // //
// // //       body: RefreshIndicator(
// // //         backgroundColor: AppColor.whiteColor,
// // //         color: AppColor.themePrimaryColor,
// // //         elevation: 0,
// // //         onRefresh: () {
// // //           return homeCubit.getHomeData(context);
// // //         },
// // //         child: SingleChildScrollView(
// // //           child: Column(
// // //             children: [
// // //               Gap(25),
// // //
// // //               BlocBuilder<HomeCubit, HomeState>(
// // //                 builder: (context, state) {
// // //                   if (state is GetHomeState) {
// // //                     homeModel = state.homeModel;
// // //                   }
// // //                   return Column(
// // //                     crossAxisAlignment: CrossAxisAlignment.start,
// // //                     children: <Widget>[
// // //                       // ---------------- EVENT SECTION ----------------
// // //                       Padding(
// // //                         padding: const EdgeInsets.symmetric(horizontal: 16),
// // //                         child: CustomTitleSeeAllWidget(
// // //                           title: 'List of Event',
// // //                           seeAllOnTap: () {
// // //                             Navigator.pushNamed(
// // //                               context,
// // //                               AppPage.eventScreen,
// // //                               arguments: {'title': 'events'},
// // //                             );
// // //                           },
// // //                         ),
// // //                       ),
// // //                       Gap(20),
// // //                       SingleChildScrollView(
// // //                         scrollDirection: Axis.horizontal,
// // //                         child: Padding(
// // //                           padding: const EdgeInsets.only(right: 6, left: 16),
// // //                           child:
// // //                               homeModel.events.isEmpty
// // //                                   ? CustomEmpty()
// // //                                   : IntrinsicHeight(
// // //                                     child: Row(
// // //                                       crossAxisAlignment:
// // //                                           CrossAxisAlignment.stretch,
// // //                                       children: List.generate(
// // //                                         homeModel.events.length,
// // //                                         (index) {
// // //                                           Broadcast event =
// // //                                               homeModel.events[index];
// // //                                           return Container(
// // //                                             width: 75.w,
// // //
// // //                                             margin: const EdgeInsets.only(
// // //                                               right: 12,
// // //                                             ),
// // //                                             child: CustomMainCard(
// // //                                               cardOnTap: () {
// // //                                                 Navigator.pushNamed(
// // //                                                   context,
// // //                                                   AppPage.homeEventDetailScreen,
// // //                                                   arguments: {
// // //                                                     'homeData': event,
// // //                                                     'title': 'Event Detail',
// // //                                                   },
// // //                                                 );
// // //                                               },
// // //                                               showButton: true,
// // //                                               onTap: () {
// // //                                                 customNoOfMemberBottomSheet(
// // //                                                   context,
// // //                                                   eventId: event.id,
// // //                                                   extra: true,
// // //                                                 );
// // //                                               },
// // //                                               image: event.image,
// // //                                               date: event.date,
// // //                                               title: event.title,
// // //                                               des: event.place,
// // //                                               joinText:
// // //                                                   event.applied == false
// // //                                                       ? 'Join Event'
// // //                                                       : 'Joined',
// // //                                               applied: event.applied,
// // //                                             ),
// // //                                           );
// // //                                         },
// // //                                       ),
// // //                                     ),
// // //                                   ),
// // //                         ),
// // //                       ),
// // //
// // //                       Gap(24),
// // //                       CustomDivider(),
// // //                       Gap(24),
// // //
// // //                       // ---------------- BROADCAST SECTION ----------------
// // //                       Padding(
// // //                         padding: const EdgeInsets.symmetric(horizontal: 16),
// // //                         child: CustomTitleSeeAllWidget(
// // //                           title: 'Broadcast message',
// // //                           seeAllOnTap: () {
// // //                             Navigator.pushNamed(
// // //                               context,
// // //                               AppPage.eventScreen,
// // //                               arguments: {'title': 'broadcasts'},
// // //                             );
// // //                           },
// // //                         ),
// // //                       ),
// // //                       Gap(20),
// // //                       SingleChildScrollView(
// // //                         scrollDirection: Axis.horizontal,
// // //                         child: Padding(
// // //                           padding: const EdgeInsets.only(right: 6, left: 16),
// // //                           child:
// // //                               homeModel.broadcasts.isEmpty
// // //                                   ? CustomEmpty()
// // //                                   : IntrinsicHeight(
// // //                                     child: Row(
// // //                                       crossAxisAlignment:
// // //                                           CrossAxisAlignment.stretch,
// // //                                       children: List.generate(
// // //                                         homeModel.broadcasts.length,
// // //                                         (index) {
// // //                                           Broadcast broadcast =
// // //                                               homeModel.broadcasts[index];
// // //                                           return Container(
// // //                                             width: 75.w, // Responsive Width
// // //                                             margin: const EdgeInsets.only(
// // //                                               right: 12,
// // //                                             ),
// // //                                             child: CustomMainCard(
// // //                                               showButton: broadcast.applied,
// // //                                               image: broadcast.image,
// // //                                               date: broadcast.date,
// // //                                               title: broadcast.title,
// // //                                               des: broadcast.place,
// // //                                               onTap: () {},
// // //                                               joinText: 'Join Event',
// // //                                               cardOnTap: () {
// // //                                                 Navigator.pushNamed(
// // //                                                   context,
// // //                                                   AppPage.homeEventDetailScreen,
// // //                                                   arguments: {
// // //                                                     'homeData': broadcast,
// // //                                                     'title': 'Broadcast Detail',
// // //                                                   },
// // //                                                 );
// // //                                               },
// // //                                               applied: broadcast.applied,
// // //                                             ),
// // //                                           );
// // //                                         },
// // //                                       ),
// // //                                     ),
// // //                                   ),
// // //                         ),
// // //                       ),
// // //                       Gap(24),
// // //                       CustomDivider(),
// // //
// // //                       Gap(24),
// // //                       Padding(
// // //                         padding: const EdgeInsets.symmetric(horizontal: 16),
// // //                         child: CustomTitleSeeAllWidget(
// // //                           title: 'App Features',
// // //                           seeAllOnTap: () {},
// // //                           child: SizedBox(),
// // //                         ),
// // //                       ),
// // //                     ],
// // //                   );
// // //                 },
// // //               ),
// // //               Gap(20),
// // //               Padding(
// // //                 padding: const EdgeInsets.symmetric(horizontal: 16),
// // //                 child: GridView.builder(
// // //                   shrinkWrap: true,
// // //                   physics: NeverScrollableScrollPhysics(),
// // //                   gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
// // //                     crossAxisCount: 2,
// // //                     mainAxisSpacing: 8,
// // //                     crossAxisSpacing: 8,
// // //                     mainAxisExtent: 17.h,
// // //                   ),
// // //                   itemCount: appFeaturesList.length,
// // //                   itemBuilder: (BuildContext context, int index) {
// // //                     return CustomAppFeatureCard(
// // //                       onTap: () {
// // //                         if (index == 0) {
// // //                           Navigator.pushNamed(
// // //                             context,
// // //                             AppPage.appFeatureScreen,
// // //                             arguments: {'title': 'Schema'},
// // //                           );
// // //                         } else if (index == 1) {
// // //                           Navigator.pushNamed(
// // //                             context,
// // //                             AppPage.appFeatureScreen,
// // //                             arguments: {'title': 'Kit'},
// // //                           );
// // //                         } else if (index == 2) {
// // //                           Navigator.pushNamed(
// // //                             context,
// // //                             AppPage.appFeatureScreen,
// // //                             arguments: {'title': 'Exam (GK)'},
// // //                           );
// // //                         } else {
// // //                           Navigator.pushNamed(
// // //                             context,
// // //                             AppPage.appFeatureScreen,
// // //                             arguments: {'title': 'Comity'},
// // //                           );
// // //                         }
// // //                       },
// // //                       image: appFeaturesList[index].image,
// // //                       title: appFeaturesList[index].title,
// // //                     );
// // //                   },
// // //                 ),
// // //               ),
// // //
// // //               Gap(20.h),
// // //             ],
// // //           ),
// // //         ),
// // //       ),
// // //     );
// // //   }
// // // }
// // import 'dart:async';
// // import 'package:flutter/material.dart';
// // import 'package:flutter_bloc/flutter_bloc.dart';
// // import 'package:gap/gap.dart';
// // import 'package:sizer/sizer.dart';
// // import 'package:svt_ppm/main.dart';
// // import 'package:svt_ppm/module/auth/model/login_model.dart';
// // import 'package:svt_ppm/module/home/cubit/home_cubit.dart';
// // import 'package:svt_ppm/module/home/model/home_model.dart';
// // import 'package:svt_ppm/module/home/model/static_model.dart';
// // import 'package:svt_ppm/module/home/view/app_drawer.dart';
// // import 'package:svt_ppm/module/home/view/widget/custom_home_widget.dart';
// // import 'package:svt_ppm/module/profile/view/qr_profile_screen.dart';
// // import 'package:svt_ppm/utils/constant/app_image.dart';
// // import 'package:svt_ppm/utils/constant/app_page.dart';
// // import 'package:svt_ppm/utils/theme/colors.dart';
// // import 'package:svt_ppm/utils/widgets/custom_app_bar.dart';
// // import 'package:svt_ppm/utils/widgets/custom_card.dart';
// // import 'package:svt_ppm/utils/widgets/custom_image.dart';
// // import 'package:svt_ppm/utils/widgets/custom_text.dart';
// // import 'package:svt_ppm/utils/widgets/custom_widget.dart';
// //
// // class HomeScreen extends StatefulWidget {
// //   const HomeScreen({super.key});
// //
// //   @override
// //   State<HomeScreen> createState() => _HomeScreenState();
// // }
// //
// // class _HomeScreenState extends State<HomeScreen> {
// //   final ValueNotifier<LoginModel?> loginModelNotifier = ValueNotifier(null);
// //   HomeModel homeModel = HomeModel(broadcasts: [], events: []);
// //
// //   final PageController _eventPageController = PageController(viewportFraction: 0.93);
// //   final PageController _broadcastPageController = PageController(viewportFraction: 0.93);
// //
// //   final ValueNotifier<int> _eventIndexNotifier = ValueNotifier(0);
// //   final ValueNotifier<int> _broadcastIndexNotifier = ValueNotifier(0);
// //
// //   Timer? _eventTimer;
// //   Timer? _broadcastTimer;
// //
// //   Future<void> loadLoginData() async {
// //     final model = await localDataSaver.getLoginModel();
// //     loginModelNotifier.value = model;
// //   }
// //
// //   @override
// //   void initState() {
// //     loadLoginData();
// //     HomeCubit homeCubit = BlocProvider.of<HomeCubit>(context);
// //     homeCubit.getHomeData(context);
// //
// //     _startAutoScroll();
// //
// //     super.initState();
// //   }
// //
// //   void _startAutoScroll() {
// //     _eventTimer = Timer.periodic(const Duration(seconds: 5), (Timer timer) {
// //       if (homeModel.events.isNotEmpty && _eventPageController.hasClients) {
// //         int nextPage = _eventIndexNotifier.value + 1;
// //         if (nextPage >= homeModel.events.length) {
// //           nextPage = 0;
// //         }
// //         _eventPageController.animateToPage(
// //           nextPage,
// //           duration: const Duration(milliseconds: 800),
// //           curve: Curves.fastOutSlowIn,
// //         );
// //       }
// //     });
// //     _broadcastTimer = Timer.periodic(const Duration(seconds: 5), (Timer timer) {
// //       if (homeModel.broadcasts.isNotEmpty && _broadcastPageController.hasClients) {
// //         int nextPage = _broadcastIndexNotifier.value + 1;
// //         if (nextPage >= homeModel.broadcasts.length) {
// //           nextPage = 0;
// //         }
// //         _broadcastPageController.animateToPage(
// //           nextPage,
// //           duration: const Duration(milliseconds: 800),
// //           curve: Curves.fastOutSlowIn,
// //         );
// //       }
// //     });
// //   }
// //
// //   @override
// //   void dispose() {
// //     _eventTimer?.cancel();
// //     _broadcastTimer?.cancel();
// //     _eventPageController.dispose();
// //     _broadcastPageController.dispose();
// //     super.dispose();
// //   }
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     List<StaticModel> appFeaturesList = [
// //       StaticModel(image: AppImage.kit, title: 'Schema'),
// //       StaticModel(image: AppImage.comity, title: 'Kit'),
// //       StaticModel(image: AppImage.exam, title: 'Exam (GK)'),
// //       StaticModel(image: AppImage.comity, title: 'Comity'),
// //     ];
// //
// //     HomeCubit homeCubit = BlocProvider.of<HomeCubit>(context);
// //
// //     return Scaffold(
// //       backgroundColor: Colors.white,
// //       appBar: CustomAppBar(
// //         title: 'SVTPPM',
// //         actions: [
// //           ValueListenableBuilder<LoginModel?>(
// //             valueListenable: loginModelNotifier,
// //             builder: (BuildContext context, LoginModel? model, Widget? child) {
// //               String imageUrl = model?.photo ?? '';
// //               return InkWell(
// //                 onTap: () {
// //                   Navigator.push(
// //                     context,
// //                     MaterialPageRoute(
// //                       builder: (context) => const QrProfileScreen(),
// //                     ),
// //                   );
// //                 },
// //                 child: Padding(
// //                   padding: const EdgeInsets.only(left: 16, bottom: 10),
// //                   child: ClipOval(
// //                     child: CustomCachedImage(
// //                       imageUrl: imageUrl,
// //                       height: 40,
// //                       width: 40,
// //                     ),
// //                   ),
// //                 ),
// //               );
// //             },
// //           ),
// //           Gap(12),
// //         ],
// //       ),
// //       drawer: AppDrawer(loginModelNotifier: loginModelNotifier),
// //
// //       body: RefreshIndicator(
// //         backgroundColor: AppColor.whiteColor,
// //         color: AppColor.themePrimaryColor,
// //         elevation: 0,
// //         onRefresh: () {
// //           return homeCubit.getHomeData(context);
// //         },
// //         child: SingleChildScrollView(
// //           child: Column(
// //             children: [
// //               Gap(25),
// //
// //               BlocBuilder<HomeCubit, HomeState>(
// //                 builder: (context, state) {
// //                   if (state is GetHomeState) {
// //                     homeModel = state.homeModel;
// //                   }
// //                   return Column(
// //                     crossAxisAlignment: CrossAxisAlignment.start,
// //                     children: <Widget>[
// //                       _buildSectionHeader(
// //                         title: 'List of Event',
// //                         icon: Icons.event_note, // Event Icon
// //                         onTap: () {
// //                           Navigator.pushNamed(
// //                             context,
// //                             AppPage.eventScreen,
// //                             arguments: {'title': 'events'},
// //                           );
// //                         },
// //                       ),
// //                       Gap(10),
// //                       homeModel.events.isEmpty
// //                           ? Center(child: CustomEmpty())
// //                           : Column(
// //                         children: [
// //                           SizedBox(
// //                             height: 340,
// //                             child: PageView.builder(
// //                               controller: _eventPageController,
// //                               itemCount: homeModel.events.length,
// //                               onPageChanged: (index) {
// //                                 _eventIndexNotifier.value = index;
// //                               },
// //                               itemBuilder: (context, index) {
// //                                 final event = homeModel.events[index];
// //                                 return CustomMainCard(
// //                                   image: event.image,
// //                                   date: event.date,
// //                                   title: event.title,
// //                                   des: event.place,
// //                                   joinText: event.applied == false ? 'Join Event' : 'Joined',
// //                                   applied: event.applied,
// //                                   showButton: true,
// //                                   onTap: () {
// //                                     customNoOfMemberBottomSheet(
// //                                       context,
// //                                       eventId: event.id,
// //                                       extra: true,
// //                                     );
// //                                   },
// //                                   onNotJoinTap: () {},
// //                                   cardOnTap: () {
// //                                     Navigator.pushNamed(
// //                                       context,
// //                                       AppPage.homeEventDetailScreen,
// //                                       arguments: {
// //                                         'homeData': event,
// //                                         'title': 'Event Detail',
// //                                       },
// //                                     );
// //                                   },
// //                                 );
// //                               },
// //                             ),
// //                           ),
// //                           Gap(8),
// //                           _buildDots(homeModel.events.length, _eventIndexNotifier),
// //                         ],
// //                       ),
// //
// //                       Gap(24),
// //                       CustomDivider(),
// //                       Gap(24),
// //                       _buildSectionHeader(
// //                         title: 'Broadcast message',
// //                         icon: Icons.campaign_rounded, // Broadcast Icon
// //                         onTap: () {
// //                           Navigator.pushNamed(
// //                             context,
// //                             AppPage.eventScreen,
// //                             arguments: {'title': 'broadcasts'},
// //                           );
// //                         },
// //                       ),
// //                       Gap(10),
// //                       homeModel.broadcasts.isEmpty
// //                           ? Center(child: CustomEmpty())
// //                           : Column(
// //                         children: [
// //                           SizedBox(
// //                             height: 340,
// //                             child: PageView.builder(
// //                               controller: _broadcastPageController,
// //                               itemCount: homeModel.broadcasts.length,
// //                               onPageChanged: (index) {
// //                                 _broadcastIndexNotifier.value = index;
// //                               },
// //                               itemBuilder: (context, index) {
// //                                 final broadcast = homeModel.broadcasts[index];
// //                                 return CustomMainCard(
// //                                   image: broadcast.image,
// //                                   date: broadcast.date,
// //                                   title: broadcast.title,
// //                                   des: broadcast.place,
// //                                   joinText: 'Join Event',
// //                                   applied: broadcast.applied,
// //                                   showButton: broadcast.applied,
// //                                   onTap: () {},
// //                                   onNotJoinTap: () {},
// //                                   cardOnTap: () {
// //                                     Navigator.pushNamed(
// //                                       context,
// //                                       AppPage.homeEventDetailScreen,
// //                                       arguments: {
// //                                         'homeData': broadcast,
// //                                         'title': 'Broadcast Detail',
// //                                       },
// //                                     );
// //                                   },
// //                                 );
// //                               },
// //                             ),
// //                           ),
// //                           Gap(8),
// //                           _buildDots(homeModel.broadcasts.length, _broadcastIndexNotifier),
// //                         ],
// //                       ),
// //                       Gap(24),
// //                       CustomDivider(),
// //                       Gap(24),
// //                       _buildSectionHeader(
// //                         title: 'App Features',
// //                         icon: Icons.grid_view_rounded, // Features Icon
// //                         showArrow: false, // No arrow needed here
// //                         onTap: () {},
// //                       ),
// //                     ],
// //                   );
// //                 },
// //               ),
// //               Gap(20),
// //               Padding(
// //                 padding: const EdgeInsets.symmetric(horizontal: 16),
// //                 child: GridView.builder(
// //                   shrinkWrap: true,
// //                   physics: NeverScrollableScrollPhysics(),
// //                   gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
// //                     crossAxisCount: 2,
// //                     mainAxisSpacing: 8,
// //                     crossAxisSpacing: 8,
// //                     mainAxisExtent: 17.h,
// //                   ),
// //                   itemCount: appFeaturesList.length,
// //                   itemBuilder: (BuildContext context, int index) {
// //                     return CustomAppFeatureCard(
// //                       onTap: () {
// //                         if (index == 0) {
// //                           Navigator.pushNamed(
// //                             context,
// //                             AppPage.appFeatureScreen,
// //                             arguments: {'title': 'Schema'},
// //                           );
// //                         } else if (index == 1) {
// //                           Navigator.pushNamed(
// //                             context,
// //                             AppPage.appFeatureScreen,
// //                             arguments: {'title': 'Kit'},
// //                           );
// //                         } else if (index == 2) {
// //                           Navigator.pushNamed(
// //                             context,
// //                             AppPage.appFeatureScreen,
// //                             arguments: {'title': 'Exam (GK)'},
// //                           );
// //                         } else {
// //                           Navigator.pushNamed(
// //                             context,
// //                             AppPage.appFeatureScreen,
// //                             arguments: {'title': 'Comity'},
// //                           );
// //                         }
// //                       },
// //                       image: appFeaturesList[index].image,
// //                       title: appFeaturesList[index].title,
// //                     );
// //                   },
// //                 ),
// //               ),
// //
// //               Gap(20.h),
// //             ],
// //           ),
// //         ),
// //       ),
// //     );
// //   }
// //   Widget _buildSectionHeader({
// //     required String title,
// //     required IconData icon,
// //     required VoidCallback onTap,
// //     bool showArrow = true,
// //   }) {
// //     return Padding(
// //       padding: const EdgeInsets.symmetric(horizontal: 16),
// //       child: InkWell(
// //         onTap: onTap,
// //         child: Row(
// //           children: [
// //             // Left Circle Icon
// //             Container(
// //               padding: const EdgeInsets.all(6),
// //               decoration: BoxDecoration(
// //                 color: AppColor.themePrimaryColor, // Purple Background
// //                 shape: BoxShape.circle,
// //               ),
// //               child: Icon(icon, color: Colors.white, size: 14),
// //             ),
// //             const Gap(10),
// //             // Title Text
// //             Text(
// //               title,
// //               style: TextStyle(
// //                 fontSize: 16,
// //                 fontWeight: FontWeight.w600,
// //                 color: Colors.grey[700],
// //               ),
// //             ),
// //             const Spacer(),
// //             // Right Arrow Icon
// //             if (showArrow)
// //               Icon(
// //                 Icons.keyboard_double_arrow_right,
// //                 color: AppColor.themePrimaryColor,
// //                 size: 20,
// //               ),
// //           ],
// //         ),
// //       ),
// //     );
// //   }
// //
// //   Widget _buildDots(int count, ValueNotifier<int> notifier) {
// //     return ValueListenableBuilder<int>(
// //       valueListenable: notifier,
// //       builder: (context, currentIndex, _) {
// //         return Row(
// //           mainAxisAlignment: MainAxisAlignment.center,
// //           children: List.generate(count, (index) {
// //             return Container(
// //               margin: const EdgeInsets.symmetric(horizontal: 3),
// //               height: 6,
// //               width: 6,
// //               decoration: BoxDecoration(
// //                 shape: BoxShape.circle,
// //                 color: currentIndex == index
// //                     ? AppColor.themePrimaryColor
// //                     : Colors.grey.withOpacity(0.3),
// //               ),
// //             );
// //           }),
// //         );
// //       },
// //     );
// //   }
// // }
// import 'dart:async';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:gap/gap.dart';
// import 'package:sizer/sizer.dart';
// import 'package:svt_ppm/main.dart';
// import 'package:svt_ppm/module/auth/model/login_model.dart';
// import 'package:svt_ppm/module/home/cubit/home_cubit.dart';
// import 'package:svt_ppm/module/home/model/home_model.dart';
// import 'package:svt_ppm/module/home/model/static_model.dart';
// import 'package:svt_ppm/module/home/view/app_drawer.dart';
// import 'package:svt_ppm/module/home/view/widget/custom_home_widget.dart';
// import 'package:svt_ppm/module/profile/view/qr_profile_screen.dart';
// import 'package:svt_ppm/utils/constant/app_image.dart';
// import 'package:svt_ppm/utils/constant/app_page.dart';
// import 'package:svt_ppm/utils/theme/colors.dart';
// import 'package:svt_ppm/utils/widgets/custom_app_bar.dart';
// import 'package:svt_ppm/utils/widgets/custom_card.dart';
// import 'package:svt_ppm/utils/widgets/custom_image.dart';
// import 'package:svt_ppm/utils/widgets/custom_text.dart';
// import 'package:svt_ppm/utils/widgets/custom_widget.dart';
//
// class HomeScreen extends StatefulWidget {
//   const HomeScreen({super.key});
//
//   @override
//   State<HomeScreen> createState() => _HomeScreenState();
// }
//
// class _HomeScreenState extends State<HomeScreen> {
//   final ValueNotifier<LoginModel?> loginModelNotifier = ValueNotifier(null);
//   HomeModel homeModel = HomeModel(broadcasts: [], events: []);
//
//   // --- SLIDER CONTROLLERS ---
//   final PageController _eventPageController = PageController(viewportFraction: 0.93);
//   final PageController _broadcastPageController = PageController(viewportFraction: 0.93);
//
//   final ValueNotifier<int> _eventIndexNotifier = ValueNotifier(0);
//   final ValueNotifier<int> _broadcastIndexNotifier = ValueNotifier(0);
//
//   // --- TIMERS ---
//   Timer? _eventTimer;
//   Timer? _broadcastTimer;
//
//   Future<void> loadLoginData() async {
//     final model = await localDataSaver.getLoginModel();
//     loginModelNotifier.value = model;
//   }
//
//   @override
//   void initState() {
//     loadLoginData();
//     HomeCubit homeCubit = BlocProvider.of<HomeCubit>(context);
//     homeCubit.getHomeData(context);
//
//     // Auto Scroll Start
//     _startAutoScroll();
//
//     super.initState();
//   }
//
//   void _startAutoScroll() {
//     // Event Slider Timer (5 Seconds)
//     _eventTimer = Timer.periodic(const Duration(seconds: 5), (Timer timer) {
//       if (homeModel.events.isNotEmpty && _eventPageController.hasClients) {
//         int nextPage = _eventIndexNotifier.value + 1;
//         if (nextPage >= homeModel.events.length) {
//           nextPage = 0;
//         }
//         _eventPageController.animateToPage(
//           nextPage,
//           duration: const Duration(milliseconds: 800),
//           curve: Curves.fastOutSlowIn,
//         );
//       }
//     });
//
//     // Broadcast Slider Timer (5 Seconds)
//     _broadcastTimer = Timer.periodic(const Duration(seconds: 5), (Timer timer) {
//       if (homeModel.broadcasts.isNotEmpty && _broadcastPageController.hasClients) {
//         int nextPage = _broadcastIndexNotifier.value + 1;
//         if (nextPage >= homeModel.broadcasts.length) {
//           nextPage = 0;
//         }
//         _broadcastPageController.animateToPage(
//           nextPage,
//           duration: const Duration(milliseconds: 800),
//           curve: Curves.fastOutSlowIn,
//         );
//       }
//     });
//   }
//
//   @override
//   void dispose() {
//     _eventTimer?.cancel();
//     _broadcastTimer?.cancel();
//     _eventPageController.dispose();
//     _broadcastPageController.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     List<StaticModel> appFeaturesList = [
//       StaticModel(image: AppImage.kit, title: 'Schema'),
//       StaticModel(image: AppImage.comity, title: 'Kit'),
//       StaticModel(image: AppImage.exam, title: 'Exam (GK)'),
//       StaticModel(image: AppImage.comity, title: 'Comity'),
//     ];
//
//     HomeCubit homeCubit = BlocProvider.of<HomeCubit>(context);
//
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: CustomAppBar(
//         title: 'SVTPPM',
//         actions: [
//           ValueListenableBuilder<LoginModel?>(
//             valueListenable: loginModelNotifier,
//             builder: (BuildContext context, LoginModel? model, Widget? child) {
//               String imageUrl = model?.photo ?? '';
//               return InkWell(
//                 onTap: () {
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                       builder: (context) => const QrProfileScreen(),
//                     ),
//                   );
//                 },
//                 child: Padding(
//                   padding: const EdgeInsets.only(left: 16, bottom: 10),
//                   child: ClipOval(
//                     child: CustomCachedImage(
//                       imageUrl: imageUrl,
//                       height: 40,
//                       width: 40,
//                     ),
//                   ),
//                 ),
//               );
//             },
//           ),
//           Gap(12),
//         ],
//       ),
//       drawer: AppDrawer(loginModelNotifier: loginModelNotifier),
//
//       body: RefreshIndicator(
//         backgroundColor: AppColor.whiteColor,
//         color: AppColor.themePrimaryColor,
//         elevation: 0,
//         onRefresh: () {
//           return homeCubit.getHomeData(context);
//         },
//         child: SingleChildScrollView(
//           child: Column(
//             children: [
//               Gap(25),
//
//               BlocBuilder<HomeCubit, HomeState>(
//                 builder: (context, state) {
//                   if (state is GetHomeState) {
//                     homeModel = state.homeModel;
//                   }
//                   return Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: <Widget>[
//                       // ---------------- EVENT SECTION ----------------
//                       _buildSectionHeader(
//                         title: 'List of Event',
//                         icon: Icons.event_note,
//                         onTap: () {
//                           Navigator.pushNamed(
//                             context,
//                             AppPage.eventScreen,
//                             arguments: {'title': 'events'},
//                           );
//                         },
//                       ),
//                       Gap(10),
//
//                       homeModel.events.isEmpty
//                           ? Center(child: CustomEmpty())
//                           : Column(
//                         children: [
//                           SizedBox(
//                             height: 340,
//                             child: PageView.builder(
//                               controller: _eventPageController,
//                               itemCount: homeModel.events.length,
//                               onPageChanged: (index) {
//                                 _eventIndexNotifier.value = index;
//                               },
//                               itemBuilder: (context, index) {
//                                 final event = homeModel.events[index];
//                                 return CustomMainCard(
//                                   image: event.image,
//                                   date: event.date,
//                                   title: event.title,
//                                   des: event.place,
//                                   joinText: event.applied == false ? 'Join Event' : 'Joined',
//                                   applied: event.applied,
//                                   showButton: true,
//                                   onTap: () {
//                                     customNoOfMemberBottomSheet(
//                                       context,
//                                       eventId: event.id,
//                                       extra: true,
//                                     );
//                                   },
//                                   onNotJoinTap: () {},
//                                   cardOnTap: () {
//                                     Navigator.pushNamed(
//                                       context,
//                                       AppPage.homeEventDetailScreen,
//                                       arguments: {
//                                         'homeData': event,
//                                         'title': 'Event Detail',
//                                       },
//                                     );
//                                   },
//                                 );
//                               },
//                             ),
//                           ),
//                           Gap(8),
//                           _buildDots(homeModel.events.length, _eventIndexNotifier),
//                         ],
//                       ),
//
//                       Gap(24),
//                       CustomDivider(),
//                       Gap(24),
//
//                       // ---------------- BROADCAST SECTION (UPDATED) ----------------
//                       _buildSectionHeader(
//                         title: 'Broadcast message',
//                         icon: Icons.campaign_rounded,
//                         onTap: () {
//                           Navigator.pushNamed(
//                             context,
//                             AppPage.eventScreen,
//                             arguments: {'title': 'broadcasts'},
//                           );
//                         },
//                       ),
//                       Gap(10),
//
//                       homeModel.broadcasts.isEmpty
//                           ? Center(child: CustomEmpty())
//                           : Column(
//                         children: [
//                           SizedBox(
//                             height: 340,
//                             child: PageView.builder(
//                               controller: _broadcastPageController,
//                               itemCount: homeModel.broadcasts.length,
//                               onPageChanged: (index) {
//                                 _broadcastIndexNotifier.value = index;
//                               },
//                               itemBuilder: (context, index) {
//                                 final broadcast = homeModel.broadcasts[index];
//
//                                 // --- SAME STYLE AS EVENT CARD ---
//                                 return CustomMainCard(
//                                   image: broadcast.image,
//                                   date: broadcast.date,
//                                   title: broadcast.title,
//                                   des: broadcast.place,
//
//                                   // બટન અને ટેક્સ્ટ લોજીક અહીં ઉમેર્યું છે
//                                   joinText: broadcast.applied ? 'Joined' : 'Join Event',
//                                   applied: broadcast.applied,
//                                   showButton: true, // Always show buttons for Broadcast
//
//                                   onTap: () {
//                                     // Broadcast Join Action
//                                   },
//                                   onNotJoinTap: () {
//                                     // Broadcast Not Join Action
//                                   },
//                                   cardOnTap: () {
//                                     Navigator.pushNamed(
//                                       context,
//                                       AppPage.homeEventDetailScreen,
//                                       arguments: {
//                                         'homeData': broadcast,
//                                         'title': 'Broadcast Detail',
//                                       },
//                                     );
//                                   },
//                                 );
//                               },
//                             ),
//                           ),
//                           Gap(8),
//                           _buildDots(homeModel.broadcasts.length, _broadcastIndexNotifier),
//                         ],
//                       ),
//
//                       Gap(24),
//                       CustomDivider(),
//
//                       Gap(24),
//
//                       // ---------------- APP FEATURES ----------------
//                       _buildSectionHeader(
//                         title: 'App Features',
//                         icon: Icons.grid_view_rounded,
//                         showArrow: false,
//                         onTap: () {},
//                       ),
//                     ],
//                   );
//                 },
//               ),
//               Gap(20),
//               Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 16),
//                 child: GridView.builder(
//                   shrinkWrap: true,
//                   physics: NeverScrollableScrollPhysics(),
//                   gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                     crossAxisCount: 2,
//                     mainAxisSpacing: 8,
//                     crossAxisSpacing: 8,
//                     mainAxisExtent: 17.h,
//                   ),
//                   itemCount: appFeaturesList.length,
//                   itemBuilder: (BuildContext context, int index) {
//                     return CustomAppFeatureCard(
//                       onTap: () {
//                         if (index == 0) {
//                           Navigator.pushNamed(
//                             context,
//                             AppPage.appFeatureScreen,
//                             arguments: {'title': 'Schema'},
//                           );
//                         } else if (index == 1) {
//                           Navigator.pushNamed(
//                             context,
//                             AppPage.appFeatureScreen,
//                             arguments: {'title': 'Kit'},
//                           );
//                         } else if (index == 2) {
//                           Navigator.pushNamed(
//                             context,
//                             AppPage.appFeatureScreen,
//                             arguments: {'title': 'Exam (GK)'},
//                           );
//                         } else {
//                           Navigator.pushNamed(
//                             context,
//                             AppPage.appFeatureScreen,
//                             arguments: {'title': 'Comity'},
//                           );
//                         }
//                       },
//                       image: appFeaturesList[index].image,
//                       title: appFeaturesList[index].title,
//                     );
//                   },
//                 ),
//               ),
//
//               Gap(20.h),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//   Widget _buildSectionHeader({
//     required String title,
//     required IconData icon,
//     required VoidCallback onTap,
//     bool showArrow = true,
//   }) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 16),
//       child: InkWell(
//         onTap: onTap,
//         child: Row(
//           children: [
//             Container(
//               padding: const EdgeInsets.all(6),
//               decoration: BoxDecoration(
//                 color: AppColor.themePrimaryColor,
//                 shape: BoxShape.circle,
//               ),
//               child: Icon(icon, color: Colors.white, size: 14),
//             ),
//             const Gap(10),
//             Text(
//               title,
//               style: TextStyle(
//                 fontSize: 16,
//                 fontWeight: FontWeight.w600,
//                 color: Colors.grey[700],
//               ),
//             ),
//             const Spacer(),
//             if (showArrow)
//               Icon(
//                 Icons.keyboard_double_arrow_right,
//                 color: AppColor.themePrimaryColor,
//                 size: 20,
//               ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget _buildDots(int count, ValueNotifier<int> notifier) {
//     return ValueListenableBuilder<int>(
//       valueListenable: notifier,
//       builder: (context, currentIndex, _) {
//         return Row(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: List.generate(count, (index) {
//             return Container(
//               margin: const EdgeInsets.symmetric(horizontal: 3),
//               height: 6,
//               width: 6,
//               decoration: BoxDecoration(
//                 shape: BoxShape.circle,
//                 color: currentIndex == index
//                     ? AppColor.themePrimaryColor
//                     : Colors.grey.withOpacity(0.3),
//               ),
//             );
//           }),
//         );
//       },
//     );
//   }
// }
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:sizer/sizer.dart';
import 'package:svt_ppm/main.dart';
import 'package:svt_ppm/module/auth/model/login_model.dart';
import 'package:svt_ppm/module/home/cubit/home_cubit.dart';
import 'package:svt_ppm/module/home/model/home_model.dart';
import 'package:svt_ppm/module/home/model/static_model.dart';
import 'package:svt_ppm/module/home/view/app_drawer.dart';
import 'package:svt_ppm/module/home/view/widget/custom_home_widget.dart';
import 'package:svt_ppm/module/profile/view/qr_profile_screen.dart';
import 'package:svt_ppm/utils/constant/app_image.dart';
import 'package:svt_ppm/utils/constant/app_page.dart';
import 'package:svt_ppm/utils/theme/colors.dart';
import 'package:svt_ppm/utils/widgets/custom_app_bar.dart';
import 'package:svt_ppm/utils/widgets/custom_card.dart';
import 'package:svt_ppm/utils/widgets/custom_image.dart';
import 'package:svt_ppm/utils/widgets/custom_widget.dart';

import '../../../utils/widgets/custom_text.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ValueNotifier<LoginModel?> loginModelNotifier = ValueNotifier(null);
  HomeModel homeModel = HomeModel(broadcasts: [], events: []);

  final PageController _eventPageController = PageController(
    viewportFraction: 0.93,
  );
  final PageController _broadcastPageController = PageController(
    viewportFraction: 0.93,
  );

  final ValueNotifier<int> _eventIndexNotifier = ValueNotifier(0);
  final ValueNotifier<int> _broadcastIndexNotifier = ValueNotifier(0);

  Timer? _eventTimer;
  Timer? _broadcastTimer;
  bool _isEventLoopSet = false;
  bool _isBroadcastLoopSet = false;

  List<Broadcast> filteredEvents = [];

  Future<void> loadLoginData() async {
    final model = await localDataSaver.getLoginModel();
    loginModelNotifier.value = model;
  }

  @override
  void initState() {
    loadLoginData();
    HomeCubit homeCubit = BlocProvider.of<HomeCubit>(context);
    homeCubit.getHomeData(context);
    _startAutoScroll();

    super.initState();
  }

  void _startAutoScroll() {
    _eventTimer = Timer.periodic(const Duration(seconds: 5), (Timer timer) {
      if (filteredEvents.length > 1 && _eventPageController.hasClients) {
        _eventPageController.nextPage(
          duration: const Duration(milliseconds: 800),
          curve: Curves.fastOutSlowIn,
        );
      }
    });

    _broadcastTimer = Timer.periodic(const Duration(seconds: 5), (Timer timer) {
      if (homeModel.broadcasts.length > 1 &&
          _broadcastPageController.hasClients) {
        _broadcastPageController.nextPage(
          duration: const Duration(milliseconds: 800),
          curve: Curves.fastOutSlowIn,
        );
      }
    });
  }

  @override
  void dispose() {
    _eventTimer?.cancel();
    _broadcastTimer?.cancel();
    _eventPageController.dispose();
    _broadcastPageController.dispose();
    super.dispose();
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

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(
        title: 'SVTPPM',
        actions: [
          ValueListenableBuilder<LoginModel?>(
            valueListenable: loginModelNotifier,
            builder: (BuildContext context, LoginModel? model, Widget? child) {
              String imageUrl = model?.photo ?? '';
              return InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const QrProfileScreen(),
                    ),
                  );
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
      drawer: AppDrawer(loginModelNotifier: loginModelNotifier),

      body: RefreshIndicator(
        backgroundColor: AppColor.whiteColor,
        color: AppColor.themePrimaryColor,
        elevation: 0,
        onRefresh: () {
          _isEventLoopSet = false;
          _isBroadcastLoopSet = false;
          return homeCubit.getHomeData(context);
        },
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: Column(
            children: [
              Gap(25),

              BlocBuilder<HomeCubit, HomeState>(
                builder: (context, state) {
                  if (state is GetHomeState) {
                    homeModel = state.homeModel;

                    DateTime now = DateTime.now();
                    DateTime today = DateTime(now.year, now.month, now.day);

                    filteredEvents =
                        homeModel.events.where((element) {
                          try {
                            String dateStr = element.date.trim().replaceAll(
                              '-',
                              '/',
                            );
                            List<String> parts = dateStr.split('/');
                            if (parts.length == 3) {
                              int day = int.parse(parts[0]);
                              int month = int.parse(parts[1]);
                              int year = int.parse(parts[2]);
                              DateTime eventDate = DateTime(year, month, day);
                              return eventDate.isAtSameMomentAs(today) ||
                                  eventDate.isAfter(today);
                            }
                            return false;
                          } catch (e) {
                            return false;
                          }
                        }).toList();

                    if (!_isEventLoopSet && filteredEvents.isNotEmpty) {
                      WidgetsBinding.instance.addPostFrameCallback((_) {
                        // Only Jump if more than 1 item (Infinite Loop)
                        if (filteredEvents.length > 1 &&
                            _eventPageController.hasClients) {
                          int middleZero = filteredEvents.length * 1000;
                          _eventPageController.jumpToPage(middleZero);
                        }
                      });
                      _isEventLoopSet = true;
                    }

                    if (!_isBroadcastLoopSet &&
                        homeModel.broadcasts.isNotEmpty) {
                      WidgetsBinding.instance.addPostFrameCallback((_) {
                        if (homeModel.broadcasts.length > 1 &&
                            _broadcastPageController.hasClients) {
                          int middleZero = homeModel.broadcasts.length * 1000;
                          _broadcastPageController.jumpToPage(middleZero);
                        }
                      });
                      _isBroadcastLoopSet = true;
                    }
                  }

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      _buildSectionHeader(
                        title: 'List of Event',
                        icon: Icons.event_note,
                        onTap: () {
                          Navigator.pushNamed(
                            context,
                            AppPage.eventScreen,
                            arguments: {'title': 'events'},
                          );
                        },
                      ),
                      Gap(10),

                      filteredEvents.isEmpty
                          ? Center(child: CustomEmpty())
                          : Column(
                            children: [
                              SizedBox(
                                height: 340,
                                child: PageView.builder(
                                  controller: _eventPageController,
                                  itemCount:
                                      filteredEvents.length > 1 ? null : 1,

                                  onPageChanged: (index) {
                                    _eventIndexNotifier.value =
                                        index % filteredEvents.length;
                                  },
                                  itemBuilder: (context, index) {
                                    final int trueIndex =
                                        index % filteredEvents.length;
                                    final event = filteredEvents[trueIndex];

                                    return CustomMainCard(
                                      image: event.image,
                                      date: event.date,
                                      title: event.title,
                                      des: event.place,
                                      joinText:
                                          event.applied == false
                                              ? 'Join Event'
                                              : 'Joined',
                                      applied: event.applied,
                                      showButton: true,
                                      onTap: () {
                                        customNoOfMemberBottomSheet(
                                          context,
                                          eventId: event.id,
                                          extra: true,
                                        );
                                      },
                                      onNotJoinTap: () {},
                                      onCancelTap: () {},
                                      cardOnTap: () {
                                        Navigator.pushNamed(
                                          context,
                                          AppPage.homeEventDetailScreen,
                                          arguments: {
                                            'homeData': event,
                                            'title': 'Event Detail',
                                          },
                                        );
                                      },
                                    );
                                  },
                                ),
                              ),
                              Gap(8),
                              // Hide Dots if only 1 item
                              if (filteredEvents.length > 1)
                                _buildDots(
                                  filteredEvents.length,
                                  _eventIndexNotifier,
                                ),
                            ],
                          ),

                      Gap(24),
                      CustomDivider(),
                      Gap(24),
                      _buildSectionHeader(
                        title: 'Broadcast message',
                        icon: Icons.campaign_rounded,
                        onTap: () {
                          Navigator.pushNamed(
                            context,
                            AppPage.eventScreen,
                            arguments: {'title': 'broadcasts'},
                          );
                        },
                      ),
                      Gap(10),

                      homeModel.broadcasts.isEmpty
                          ? Center(child: CustomEmpty())
                          : Column(
                            children: [
                              SizedBox(
                                height: 340,
                                child: PageView.builder(
                                  controller: _broadcastPageController,

                                  itemCount:
                                      homeModel.broadcasts.length > 1
                                          ? null
                                          : 1,

                                  onPageChanged: (index) {
                                    _broadcastIndexNotifier.value =
                                        index % homeModel.broadcasts.length;
                                  },
                                  itemBuilder: (context, index) {
                                    final int trueIndex =
                                        index % homeModel.broadcasts.length;
                                    final broadcast =
                                        homeModel.broadcasts[trueIndex];

                                    return CustomMainCard(
                                      image: broadcast.image,
                                      date: broadcast.date,
                                      title: broadcast.title,
                                      des: broadcast.place,
                                      joinText: '',
                                      applied: broadcast.applied,
                                      showButton: false,
                                      onTap: () {},
                                      onNotJoinTap: () {},
                                      onCancelTap: () {},
                                      cardOnTap: () {
                                        Navigator.pushNamed(
                                          context,
                                          AppPage.homeEventDetailScreen,
                                          arguments: {
                                            'homeData': broadcast,
                                            'title': 'Broadcast Detail',
                                          },
                                        );
                                      },
                                    );
                                  },
                                ),
                              ),
                              Gap(8),
                              if (homeModel.broadcasts.length > 1)
                                _buildDots(
                                  homeModel.broadcasts.length,
                                  _broadcastIndexNotifier,
                                ),
                            ],
                          ),

                      Gap(24),
                      CustomDivider(),
                      Gap(24),

                      _buildSectionHeader(
                        title: 'App Features',
                        icon: Icons.grid_view_rounded,
                        showArrow: false,
                        onTap: () {},
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
                        // Navigation Logic
                        String pageTitle = '';
                        if (index == 0) {
                          pageTitle = 'Schema';
                        } else if (index == 1) {
                          pageTitle = 'Kit';
                        } else if (index == 2) {
                          pageTitle = 'Exam (GK)';
                        } else {
                          pageTitle = 'Committee';
                        }
                        Navigator.pushNamed(
                          context,
                          AppPage.appFeatureScreen,
                          arguments: {'title': pageTitle},
                        );
                      },
                      image: appFeaturesList[index].image,
                      title: appFeaturesList[index].title,
                    );
                  },
                ),
              ),

              Gap(20.h),
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
    bool showArrow = true,
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
            if (showArrow)
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

  Widget _buildDots(int count, ValueNotifier<int> notifier) {
    return ValueListenableBuilder<int>(
      valueListenable: notifier,
      builder: (context, currentIndex, _) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(count, (index) {
            return Container(
              margin: const EdgeInsets.symmetric(horizontal: 3),
              height: 6,
              width: 6,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color:
                    currentIndex == index
                        ? AppColor.themePrimaryColor
                        : Colors.grey.withOpacity(0.3),
              ),
            );
          }),
        );
      },
    );
  }
}
