import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:svt_ppm/main.dart';
import 'package:svt_ppm/module/auth/cubit/auth_cubit.dart';
import 'package:svt_ppm/module/auth/model/login_model.dart';
import 'package:svt_ppm/utils/constant/app_page.dart';
import 'package:svt_ppm/utils/enum/enums.dart';
import 'package:svt_ppm/utils/formatter/format.dart';
import 'package:svt_ppm/utils/theme/colors.dart';
import 'package:svt_ppm/utils/widgets/custom_list_tile.dart';
import 'package:svt_ppm/utils/widgets/custom_success_dialog.dart';
import 'package:svt_ppm/utils/widgets/custom_text.dart';

class AppDrawer extends StatelessWidget {
  final ValueNotifier<LoginModel?> loginModelNotifier;

  const AppDrawer({super.key, required this.loginModelNotifier});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.white,
      child: ValueListenableBuilder<LoginModel?>(
        valueListenable: loginModelNotifier,
        builder: (BuildContext context, LoginModel? model, Widget? child) {
          log('model in drawer: ${model?.familyHeadId}');
          return Column(
            children: [
              Expanded(
                child: ListView(
                  padding: EdgeInsets.zero,
                  children: [
                    Container(
                      color: AppColor.themePrimaryColor,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Gap(50),
                            CircleAvatar(
                              radius: 40,
                              backgroundColor: AppColor.whiteColor,
                              backgroundImage:
                                  model?.photo != null &&
                                          model!.photo.isNotEmpty
                                      ? NetworkImage(model.photo)
                                      : null,
                              child:
                                  model?.photo == null || model!.photo.isEmpty
                                      ? const Icon(Icons.person, size: 40)
                                      : null,
                            ),
                            Gap(10),
                            CustomText(
                              text: model?.name ?? "",
                              color: AppColor.whiteColor,
                              fontWeight: FontWeight.bold,

                              fontSize: 18,
                            ),
                            if (model?.email != null &&
                                model!.email.isNotEmpty) ...[
                              Gap(5),

                              CustomText(
                                text: model.email,
                                color: AppColor.whiteColor,
                                fontSize: 14,
                              ),
                            ],
                            Gap(20),
                          ],
                        ),
                      ),
                    ),

                    _drawerItem(
                      context,
                      title: "Profile",
                      route: AppPage.profileScreen,
                    ),

                    // _drawerItem(
                    //   context,
                    //   title: "Family Detail",
                    //   route: AppPage.profileScreen,

                    // ),
                    _drawerItem(
                      context,
                      title: "Scheme",
                      route: AppPage.appFeatureScreen,
                      arguments: {'title': 'Scheme'},
                    ),

                    if (UserSession.hasAnyRole([
                      UserRoles.villagePresident,
                      UserRoles.user,
                    ])) ...[
                      _drawerItem(
                        context,
                        title: "Scheme Registration",
                        route: AppPage.roleSchemeRegistrationScreen,
                      ),
                    ],
                    if (UserSession.hasRole(UserRoles.getEntry)) ...[
                      _drawerItem(
                        context,
                        title: "Gate Entry",
                        route: AppPage.dataEntryScreen,
                      ),
                    ],
                    if (UserSession.hasAnyRole([UserRoles.kitDistributor])) ...[
                      _drawerItem(
                        context,
                        title: "Kit Distributor",
                        route: AppPage.kitPaymentDistributorPaymentScreen,

                        arguments: {'title': "Kit Distributor"},
                      ),
                    ],
                    if (UserSession.hasAnyRole([UserRoles.kitPayment])) ...[
                      _drawerItem(
                        context,
                        title: "Kit Payment",
                        route: AppPage.kitPaymentDistributorPaymentScreen,

                        arguments: {'title': "Kit Payment"},
                      ),
                    ],

                    _drawerItem(
                      context,
                      title: "Kit",
                      route: AppPage.appFeatureScreen,
                      arguments: {'title': 'Kit'},
                    ),

                    _drawerItem(
                      context,
                      title: "Exam (GK)",
                      route: AppPage.appFeatureScreen,
                      arguments: {'title': 'Exam (GK)'},
                    ),

                    _drawerItem(
                      context,
                      title: "Committee",
                      route: AppPage.appFeatureScreen,
                      arguments: {'title': 'Committee'},
                    ),

                    _drawerItem(
                      context,
                      title: "Benefit",
                      route: AppPage.benefitScreen,
                    ),
                  ],
                ),
              ),

              const Divider(thickness: 1),

              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
                child: CustomListTile(
                  text: "Logout",
                  textColor: Colors.grey.shade700,
                  leadingImage: '',
                  leading: Icon(
                    _getIconByName("Logout"),
                    color: AppColor.themePrimaryColor,
                  ),
                  trailing: const SizedBox.shrink(),
                  onTap: () {
                    showCustomDialog(
                      context,
                      title: 'Logout',
                      subTitle: 'Are you sure you want to logout?',
                      buttonText: 'Logout',
                      onTap: () {
                        Navigator.pop(context);
                        context.read<AuthCubit>().logout(context);
                      },
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  IconData _getIconByName(String title) {
    switch (title) {
      case "Profile":
        return Icons.person;
      case "Family Detail":
        return Icons.family_restroom;
      case "Scheme":
        return Icons.description;
      case "Scheme Registration":
        return Icons.how_to_reg;
      case "Gate Entry":
        return Icons.post_add;
      case "Kit Distributor":
        return Icons.local_shipping;
      case "Kit Payment":
        return Icons.currency_rupee;
      case "Kit":
        return Icons.shopping_bag;
      case "Exam (GK)":
        return Icons.book;
      case "Committee":
        return Icons.groups;
      case "Benefit":
        return Icons.card_giftcard;
      case "Logout":
        return Icons.logout;
      default:
        return Icons.circle;
    }
  }

  Widget _drawerItem(
    BuildContext context, {
    required String title,
    required String route,

    Map<String, dynamic>? arguments,
  }) {
    final IconData icon = _getIconByName(title);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: CustomListTile(
        text: title,
        textColor: Colors.grey.shade700,

        leadingImage: '',

        leading: Icon(icon, color: AppColor.themePrimaryColor, size: 24),

        onTap: () async {
          int headId = await localDataSaver.getHeadId();

          log('headIdheadId :$headId');

          if ((title == 'Scheme' ||
                  title == 'Kit' ||
                  title == 'Exam (GK)' ||
                  title == 'Scheme Registration') &&
              headId != 0) {
            showCustomDialog(
              context,
              title: 'Access Denied',
              subTitle: 'You do not have access to this feature.',
              buttonText: 'OK',
              onTap: () {
                Navigator.pop(context);
              },
            );
          } else {
            Navigator.of(context).pop();
            Navigator.of(context).pushNamed(route, arguments: arguments);
          }
        },
      ),
    );
  }
}
