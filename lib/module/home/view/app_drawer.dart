import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
                        child: model?.photo == null || model!.photo.isEmpty
                            ? const Icon(Icons.person, size: 40)
                            : null,
                      ),
                    ),

                    _drawerItem(
                      context,
                      title: "Profile",
                      route: AppPage.profileScreen,
                    ),

                    _drawerItem(
                      context,
                      title: "Family Detail",
                      route: AppPage.profileScreen,
                    ),

                    _drawerItem(
                      context,
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
                        title: "Schema Registration",
                        route: AppPage.roleSchemaRegistrationScreen,
                      ),
                    ],
                    if (UserSession.hasRole(UserRoles.getEntry)) ...[
                      _drawerItem(
                        context,
                        title: "Get Entry",
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
      case "Schema":
        return Icons.description;
      case "Schema Registration":
        return Icons.how_to_reg ;
      case "Get Entry":
        return Icons.post_add ;
      case "Kit Distributor":
        return Icons.local_shipping ;
      case "Kit Payment":
        return Icons.currency_rupee ;
      case "Kit":
        return Icons.shopping_bag;
      case "Exam (GK)":
        return Icons.book;
      case "Committee":
        return Icons.groups;
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

        leading: Icon(
          icon,
          color: AppColor.themePrimaryColor,
          size: 24,
        ),

        onTap: () {
          Navigator.of(context).pop();
          Navigator.of(context).pushNamed(route, arguments: arguments);
        },
      ),
    );
  }
}