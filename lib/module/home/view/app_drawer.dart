
import 'package:flutter/material.dart';
import 'package:svt_ppm/module/auth/model/login_model.dart';
import 'package:svt_ppm/utils/constant/app_page.dart';
import 'package:svt_ppm/utils/enum/enums.dart';
import 'package:svt_ppm/utils/formatter/format.dart';
import 'package:svt_ppm/utils/theme/colors.dart';
import 'package:svt_ppm/utils/widgets/custom_list_tile.dart';
import 'package:svt_ppm/utils/widgets/custom_text.dart';

class AppDrawer extends StatelessWidget {
  final ValueNotifier<LoginModel?> loginModelNotifier;

  const AppDrawer({super.key, required this.loginModelNotifier});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.white,
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          /// Header
          ValueListenableBuilder<LoginModel?>(
            valueListenable: loginModelNotifier,
            builder: (context, value, child) {
              return UserAccountsDrawerHeader(
                decoration: BoxDecoration(color: AppColor.themePrimaryColor),
                accountName: CustomText(
                  text: value?.name ?? "",
                  color: AppColor.whiteColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
                accountEmail: CustomText(
                  text: value?.email ?? "",
                  color: AppColor.whiteColor,
                  fontSize: 14,
                ),
                currentAccountPicture: CircleAvatar(
                  backgroundColor: AppColor.whiteColor,
                  backgroundImage:
                      value?.photo != null && value!.photo.isNotEmpty
                          ? NetworkImage(value.photo)
                          : null,
                  child:
                      value?.photo == null || value!.photo.isEmpty
                          ? const Icon(Icons.person, size: 40)
                          : null,
                ),
              );
            },
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
              icon: Icons.schema,
              title: "Schema Registration",
              route: AppPage.roleSchemaRegistrationScreen,
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
          Navigator.of(context).pop(); // Close the drawer
          Navigator.of(context).pushNamed(route, arguments: arguments);
        },
      ),
    );
  }
}
