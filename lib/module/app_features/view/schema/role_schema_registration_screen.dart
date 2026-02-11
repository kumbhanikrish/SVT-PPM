import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:sizer/sizer.dart';
import 'package:svt_ppm/module/app_features/cubit/role_schemas_registration/role_schemas_registration_cubit.dart';
import 'package:svt_ppm/utils/constant/app_page.dart';
import 'package:svt_ppm/utils/theme/colors.dart';
import 'package:svt_ppm/utils/widgets/custom_app_bar.dart';
import 'package:svt_ppm/utils/widgets/custom_image.dart';
import 'package:svt_ppm/utils/widgets/custom_list_tile.dart';
import 'package:svt_ppm/utils/widgets/custom_text.dart';

class RoleSchemaRegistrationScreen extends StatefulWidget {
  const RoleSchemaRegistrationScreen({super.key});

  @override
  State<RoleSchemaRegistrationScreen> createState() =>
      _RoleSchemaRegistrationScreenState();
}

class _RoleSchemaRegistrationScreenState
    extends State<RoleSchemaRegistrationScreen> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<RoleSchemasRegistrationCubit>(
      context,
    ).roleSchemasRegistration(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Schema Registration', actions: []),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
        child: RefreshIndicator(
          backgroundColor: AppColor.whiteColor,
          color: AppColor.themePrimaryColor,
          elevation: 0,
          onRefresh: () {
            return BlocProvider.of<RoleSchemasRegistrationCubit>(
              context,
            ).roleSchemasRegistration(context);
          },
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: BlocBuilder<
              RoleSchemasRegistrationCubit,
              RoleSchemasRegistrationState
            >(
              builder: (context, state) {
                if (state is SchemasRegistrationState) {
                  final schemasList = state.schemasRegistrationList;

                  return schemasList.isEmpty
                      ? SizedBox(height: 50.h, child: CustomEmpty())
                      : ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: schemasList.length,
                        itemBuilder: (context, index) {
                          final schemasRegistrationModel = schemasList[index];
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              CustomText(
                                text: schemasRegistrationModel.year.toString(),
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                              ),

                              Padding(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 16,
                                ),
                                child:
                                    schemasRegistrationModel.schemas.isEmpty
                                        ? CustomEmpty()
                                        : ListView.separated(
                                          padding: EdgeInsets.zero,
                                          shrinkWrap: true,
                                          physics:
                                              const NeverScrollableScrollPhysics(),
                                          itemCount:
                                              schemasRegistrationModel
                                                  .schemas
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
                                            final schemaItem =
                                                schemasRegistrationModel
                                                    .schemas[index];
                                            return CustomListTile(
                                              onTap: () {
                                                Navigator.pushNamed(
                                                  context,

                                                  AppPage
                                                      .roleSchemaRegistrationUserScreen,
                                                  arguments: {
                                                    'schemaUser':
                                                        schemaItem.items,
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
                                              text: schemaItem.schemaName,
                                              leadingImage: '',
                                              leading: CustomCachedImage(
                                                imageUrl:
                                                    schemaItem.schemaPhoto,
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
                                                      schemaItem
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
