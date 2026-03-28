import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:sizer/sizer.dart';
import 'package:svt_ppm/module/app_features/cubit/role_schemes_registration/role_schemes_registration_cubit.dart';
import 'package:svt_ppm/utils/constant/app_page.dart';
import 'package:svt_ppm/utils/theme/colors.dart';
import 'package:svt_ppm/utils/widgets/custom_app_bar.dart';
import 'package:svt_ppm/utils/widgets/custom_image.dart';
import 'package:svt_ppm/utils/widgets/custom_list_tile.dart';
import 'package:svt_ppm/utils/widgets/custom_text.dart';

class RoleSchemeRegistrationScreen extends StatefulWidget {
  const RoleSchemeRegistrationScreen({super.key});

  @override
  State<RoleSchemeRegistrationScreen> createState() =>
      _RoleSchemeRegistrationScreenState();
}

class _RoleSchemeRegistrationScreenState
    extends State<RoleSchemeRegistrationScreen> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<RoleSchemesRegistrationCubit>(
      context,
    ).roleSchemesRegistration(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Scheme Registration', actions: []),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
        child: RefreshIndicator(
          backgroundColor: AppColor.whiteColor,
          color: AppColor.themePrimaryColor,
          elevation: 0,
          onRefresh: () {
            return BlocProvider.of<RoleSchemesRegistrationCubit>(
              context,
            ).roleSchemesRegistration(context);
          },
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: BlocBuilder<
              RoleSchemesRegistrationCubit,
              RoleSchemesRegistrationState
            >(
              builder: (context, state) {
                if (state is SchemesRegistrationState) {
                  final schemesList = state.schemesRegistrationList;

                  return schemesList.isEmpty
                      ? SizedBox(height: 50.h, child: CustomEmpty())
                      : ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: schemesList.length,
                        itemBuilder: (context, index) {
                          final schemesRegistrationModel = schemesList[index];
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              CustomText(
                                text: schemesRegistrationModel.year.toString(),
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                              ),

                              Padding(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 16,
                                ),
                                child:
                                    schemesRegistrationModel.schemes.isEmpty
                                        ? CustomEmpty()
                                        : ListView.separated(
                                          padding: EdgeInsets.zero,
                                          shrinkWrap: true,
                                          physics:
                                              const NeverScrollableScrollPhysics(),
                                          itemCount:
                                              schemesRegistrationModel
                                                  .schemes
                                                  .length,
                                          separatorBuilder: (
                                            BuildContext context,
                                            int index,
                                          ) {
                                            return Gap(16);
                                          },
                                          itemBuilder: (
                                            BuildContext context,
                                            int index,
                                          ) {
                                            final schemeItem =
                                                schemesRegistrationModel
                                                    .schemes[index];
                                            return CustomListTile(
                                              onTap: () {
                                                Navigator.pushNamed(
                                                  context,

                                                  AppPage
                                                      .roleSchemeRegistrationUserScreen,
                                                  arguments: {
                                                    'schemeUser':
                                                        schemeItem.items,
                                                  },
                                                );
                                              },
                                              borderRadius:
                                                  BorderRadius.circular(15),
                                              tileColor: AppColor.fillColor,
                                              contentPadding:
                                                  EdgeInsets.symmetric(
                                                    horizontal: 12,
                                                    vertical: 10,
                                                  ),
                                              text: schemeItem.schemeName,
                                              leadingImage: '',
                                              leading: CustomCachedImage(
                                                imageUrl:
                                                    schemeItem.schemePhoto,
                                                height: 60,
                                                width: 60,
                                              ),
                                              trailing: CircleAvatar(
                                                backgroundColor:
                                                    AppColor
                                                        .themeSecondaryColor,
                                                radius: 12,
                                                child: CustomText(
                                                  text:
                                                      schemeItem
                                                          .notApprovedCount
                                                          .toString(),
                                                  fontSize: 12,
                                                ),
                                              ),
                                            );
                                          },
                                        ),
                              ),
                            ],
                          );
                        },
                      );
                } else {
                  return CustomEmpty();
                }
              },
            ),
          ),
        ),
      ),
    );
  }
}
