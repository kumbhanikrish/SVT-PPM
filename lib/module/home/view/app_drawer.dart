import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
          return Column(
            children: [
              Expanded(
                child: ListView(
                  padding: EdgeInsets.zero,
                  children: [
                    UserAccountsDrawerHeader(
                      decoration: BoxDecoration(
                        color: AppColor.themePrimaryColor,
                      ),
                      accountName: CustomText(
                        text: model?.name ?? "",
                        color: AppColor.whiteColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                      accountEmail: CustomText(
                        text: model?.email ?? "",
                        color: AppColor.whiteColor,
                        fontSize: 14,
                      ),
                      currentAccountPicture: CircleAvatar(
                        backgroundColor: AppColor.whiteColor,
                        backgroundImage:
                            model?.photo != null && model!.photo.isNotEmpty
                                ? NetworkImage(model.photo)
                                : null,
                        child:
                            model?.photo == null || model!.photo.isEmpty
                                ? const Icon(Icons.person, size: 40)
                                : null,
                      ),
                    ),

                    _drawerItem(
                      context,
                      icon: Icons.person,
                      title: "Profile",
                      route: AppPage.profileScreen,
                    ),

                    _drawerItem(
                      context,
                      icon: Icons.family_restroom,
                      title: "Family Detail",
                      route: AppPage.profileScreen,
                    ),

                    _drawerItem(
                      context,
                      icon: Icons.schema,
                      title: "Schema",
                      route: AppPage.appFeatureScreen,
                      arguments: {'title': 'Schema'},
                    ),

                    if (UserSession.hasAnyRole([
                      UserRoles.villagePresident,
                      UserRoles.user,
                    ])) ...[
                      _drawerItem(
                        context,
                        icon: Icons.app_registration,
                        title: "Schema Registration",
                        route: AppPage.roleSchemaRegistrationScreen,
                      ),
                    ],
                    if (UserSession.hasRole(UserRoles.getEntry)) ...[
                      _drawerItem(
                        context,
                        icon: Icons.app_registration,
                        title: "Get Entry",
                        route: AppPage.dataEntryScreen,
                      ),
                    ],

                    _drawerItem(
                      context,
                      icon: Icons.shopping_bag,
                      title: "Kit",
                      route: AppPage.appFeatureScreen,
                      arguments: {'title': 'Kit'},
                    ),

                    _drawerItem(
                      context,
                      icon: Icons.book,
                      title: "Exam (GK)",
                      route: AppPage.appFeatureScreen,
                      arguments: {'title': 'Exam (GK)'},
                    ),

                    _drawerItem(
                      context,
                      icon: Icons.groups,
                      title: "Committee",
                      route: AppPage.appFeatureScreen,
                      arguments: {'title': 'Comity'},
                    ),
                  ],
                ),
              ),

              const Divider(thickness: 1),
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
                child: CustomListTile(
                  text: "Logout",
                  leadingImage: '',
                  leading: const Icon(Icons.logout, color: Colors.red),
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

  Widget _drawerItem(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String route,
    Map<String, dynamic>? arguments,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: CustomListTile(
        text: title,
        leadingImage: '',
        leading: Icon(icon, color: Colors.grey),
        onTap: () {
          Navigator.of(context).pop();
          Navigator.of(context).pushNamed(route, arguments: arguments);
        },
      ),
    );
  }
}
