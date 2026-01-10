import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:svt_ppm/module/app_features/cubit/role_schemas_registration/role_schemas_registration_cubit.dart';
import 'package:svt_ppm/module/app_features/model/schemas_registration_model.dart';
import 'package:svt_ppm/module/auth/cubit/auth_cubit.dart';
import 'package:svt_ppm/utils/constant/app_image.dart';
import 'package:svt_ppm/utils/enum/enums.dart';
import 'package:svt_ppm/utils/formatter/format.dart';
import 'package:svt_ppm/utils/theme/colors.dart';
import 'package:svt_ppm/utils/widgets/custom_app_bar.dart';
import 'package:svt_ppm/utils/widgets/custom_bottomsheet.dart';
import 'package:svt_ppm/utils/widgets/custom_button.dart';
import 'package:svt_ppm/utils/widgets/custom_image.dart';
import 'package:svt_ppm/utils/widgets/custom_radio_list_tile.dart';
import 'package:svt_ppm/utils/widgets/custom_text.dart';
import 'package:svt_ppm/utils/widgets/custom_textfield.dart';
import 'package:svt_ppm/utils/widgets/custom_widget.dart';

class RoleSchemaRegistrationUserScreen extends StatelessWidget {
  final dynamic argument;
  const RoleSchemaRegistrationUserScreen({super.key, this.argument});
  @override
  Widget build(BuildContext context) {
    List<Item> schemaUser = argument['schemaUser'];
    return Scaffold(
      appBar: CustomAppBar(title: 'Schema User', actions: []),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
        child: BlocListener<
          RoleSchemasRegistrationCubit,
          RoleSchemasRegistrationState
        >(
          listener: (context, state) {
            if (state is SchemasRegistrationChangeStatusSuccessState) {
              Navigator.pop(context);
            }
          },
          child: ListView.separated(
            itemCount: schemaUser.length,
            separatorBuilder: (BuildContext context, int index) {
              return Gap(16);
            },
            itemBuilder: (BuildContext context, int index) {
              final schemaUserItem = schemaUser[index];
              return Container(
                decoration: BoxDecoration(
                  color: AppColor.fillColor,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                  child: Column(
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,

                        children: <Widget>[
                          CustomCachedImage(
                            height: 70,
                            width: 70,
                            borderRadius: BorderRadius.circular(15),
                            imageUrl: schemaUserItem.memberPhoto,
                          ),
                          Gap(12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,

                              children: <Widget>[
                                Row(
                                  children: [
                                    Expanded(
                                      child: CustomText(
                                        text: schemaUserItem.memberName,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),

                                    UserSession.hasRole(
                                          UserRoles.villagePresident,
                                        )
                                        ? CustomIconButton(
                                          icon: Icons.more_vert_rounded,
                                          onPressed: () {
                                            changeStatusBottomSheet(
                                              context,
                                              registrationId: schemaUserItem.id,
                                              status:
                                                  schemaUserItem
                                                      .villagePresidentStatus,
                                            );
                                          },
                                          color: AppColor.themePrimaryColor,
                                        )
                                        : SizedBox.shrink(),
                                  ],
                                ),

                                Row(
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        CustomText(
                                          text: 'Admin',
                                          fontSize: 12,
                                          fontWeight: FontWeight.w600,
                                          color: AppColor.blackColor,
                                        ),
                                        Gap(10),
                                        CustomStatusButton(
                                          color:
                                              schemaUserItem.adminStatus ==
                                                      'pending'
                                                  ? AppColor.amberColor
                                                      .withOpacity(0.1)
                                                  : schemaUserItem
                                                          .adminStatus ==
                                                      'rejected'
                                                  ? AppColor.redColor
                                                      .withOpacity(0.1)
                                                  : schemaUserItem
                                                          .adminStatus ==
                                                      'approved'
                                                  ? AppColor.greenColor
                                                      .withOpacity(0.1)
                                                  : AppColor.themePrimaryColor
                                                      .withOpacity(0.1),
                                          status: capitalize(
                                            schemaUserItem.adminStatus,
                                          ),
                                          textColor:
                                              schemaUserItem.adminStatus ==
                                                      'pending'
                                                  ? AppColor.amberColor
                                                  : schemaUserItem
                                                          .adminStatus ==
                                                      'rejected'
                                                  ? AppColor.redColor
                                                  : schemaUserItem
                                                          .adminStatus ==
                                                      'approved'
                                                  ? AppColor.greenColor
                                                  : AppColor.themePrimaryColor,
                                        ),
                                      ],
                                    ),
                                    Gap(25),
                                    CustomVerticalDivider(),
                                    Gap(25),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        CustomText(
                                          text: 'Village President',
                                          fontSize: 12,
                                          fontWeight: FontWeight.w600,
                                          color: AppColor.blackColor,
                                        ),
                                        Gap(10),
                                        CustomStatusButton(
                                          color:
                                              schemaUserItem
                                                          .villagePresidentStatus ==
                                                      'pending'
                                                  ? AppColor.amberColor
                                                      .withOpacity(0.1)
                                                  : schemaUserItem
                                                          .villagePresidentStatus ==
                                                      'rejected'
                                                  ? AppColor.redColor
                                                      .withOpacity(0.1)
                                                  : schemaUserItem
                                                          .villagePresidentStatus ==
                                                      'approved'
                                                  ? AppColor.greenColor
                                                      .withOpacity(0.1)
                                                  : AppColor.themePrimaryColor
                                                      .withOpacity(0.1),
                                          status: capitalize(
                                            schemaUserItem
                                                .villagePresidentStatus,
                                          ),
                                          textColor:
                                              schemaUserItem
                                                          .villagePresidentStatus ==
                                                      'pending'
                                                  ? AppColor.amberColor
                                                  : schemaUserItem
                                                          .villagePresidentStatus ==
                                                      'rejected'
                                                  ? AppColor.redColor
                                                  : schemaUserItem
                                                          .villagePresidentStatus ==
                                                      'approved'
                                                  ? AppColor.greenColor
                                                  : AppColor.themePrimaryColor,
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      if (schemaUserItem.remarks != null &&
                          schemaUserItem.remarks.isNotEmpty) ...[
                        Gap(16),
                        CustomTitleName(
                          text: schemaUserItem.remarks,
                          title: 'Reason',
                          color: AppColor.redColor,
                          fontWeight: FontWeight.w600,
                          textColor: AppColor.redColor.withOpacity(0.5),
                        ),
                      ],
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

void changeStatusBottomSheet(
  BuildContext context, {
  required int registrationId,
  required String status,
}) {
  TextEditingController remarksController = TextEditingController();
  BlocProvider.of<StatusRadioCubit>(context).selectStatusType(
    status == 'pending'
        ? StatusType.pending
        : status == 'approved'
        ? StatusType.approved
        : StatusType.rejected,
  );
  customBottomSheet(
    context,
    title: 'Change Status',
    child: Flexible(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),

          child: BlocBuilder<StatusRadioCubit, StatusType>(
            builder: (context, selectedType) {
              return Column(
                children: [
                  customRadio(
                    buttonImage:
                        selectedType == StatusType.pending
                            ? AppImage.radioButton
                            : AppImage.circle,
                    genderIcon: '',
                    title: 'Pending',
                    onTap: () {
                      BlocProvider.of<StatusRadioCubit>(
                        context,
                      ).selectStatusType(StatusType.pending);
                    },
                  ),
                  Gap(16),
                  customRadio(
                    buttonImage:
                        selectedType == StatusType.approved
                            ? AppImage.radioButton
                            : AppImage.circle,
                    genderIcon: '',
                    title: 'Approved',
                    onTap: () {
                      BlocProvider.of<StatusRadioCubit>(
                        context,
                      ).selectStatusType(StatusType.approved);
                    },
                  ),
                  Gap(16),

                  customRadio(
                    buttonImage:
                        selectedType == StatusType.rejected
                            ? AppImage.radioButton
                            : AppImage.circle,
                    genderIcon: '',
                    title: 'Rejected',
                    onTap: () {
                      BlocProvider.of<StatusRadioCubit>(
                        context,
                      ).selectStatusType(StatusType.rejected);
                    },
                  ),
                  if (selectedType == StatusType.rejected) ...[
                    Gap(16),
                    CustomTextField(
                      hintText: 'Enter Remarks',
                      labelText: 'Remarks',
                      controller: remarksController,
                    ),
                  ],
                ],
              );
            },
          ),
        ),
      ),
    ),
    showButton: true,
    buttonOnTap: () {
      StatusType status = BlocProvider.of<StatusRadioCubit>(context).state;

      BlocProvider.of<RoleSchemasRegistrationCubit>(
        context,
      ).schemasRegistrationChangeStatus(
        context,
        registrationId: registrationId.toString(),
        status: status.name,
        remarks: remarksController.text.trim(),
      );
    },
  );
}
