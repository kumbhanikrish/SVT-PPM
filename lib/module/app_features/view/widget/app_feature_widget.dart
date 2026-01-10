import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:sizer/sizer.dart';
import 'package:svt_ppm/module/app_features/cubit/schemas/schemas_cubit.dart';
import 'package:svt_ppm/module/app_features/model/schemas_model.dart';
import 'package:svt_ppm/module/app_features/model/village_president_model.dart';
import 'package:svt_ppm/utils/constant/app_page.dart';
import 'package:svt_ppm/utils/theme/colors.dart';
import 'package:svt_ppm/utils/widgets/custom_bottomsheet.dart';
import 'package:svt_ppm/utils/widgets/custom_error_toast.dart';
import 'package:svt_ppm/utils/widgets/custom_image.dart';
import 'package:svt_ppm/utils/widgets/custom_list_tile.dart';

void customVillagePresidentBottomSheet(
  BuildContext context, {
  required Set<int> selectedMemberIds,
  required int schemaId,
  required List<Document> documents,
}) {
  SchemasCubit schemasCubit = BlocProvider.of<SchemasCubit>(context);
  List<VillagePresidentModel> villagePresidentList = [];
  Set<int> selectedVillagePresidentIds = {};

  schemasCubit.villagePresident(context);

  customBottomSheet(
    context,

    buttonOnTap: () {
      if (selectedVillagePresidentIds.length < 2) {
        customErrorToast(context, text: 'Please select at least 2 members');
      } else {
        Navigator.pushNamed(
          context,
          AppPage.selectDocumentScreen,
          arguments: {
            'schemaId': schemaId,
            'selectedVillagePresidentIds': selectedVillagePresidentIds.toList(),
            'memberId': selectedMemberIds.first,
            'documents': documents,
          },
        );
      }
    },

    showButton: true,
    title: 'Village President',
    child: StatefulBuilder(
      builder: (BuildContext context, StateSetter setModalState) {
        return Flexible(
          child: SingleChildScrollView(
            child: Column(
              children: [
                const Gap(10),
                SizedBox(
                  height: 40.h,
                  child: BlocBuilder<SchemasCubit, SchemasState>(
                    builder: (context, state) {
                      if (state is GetSchemasState) {
                        villagePresidentList = state.villagePresidentList;
                      }

                      return ListView.builder(
                        itemCount: villagePresidentList.length,
                        itemBuilder: (BuildContext context, int index) {
                          final villagePresident = villagePresidentList[index];
                          final isSelected = selectedVillagePresidentIds
                              .contains(villagePresident.id);

                          return CustomListTile(
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 16,
                            ),
                            onTap: () {
                              setModalState(() {
                                if (isSelected) {
                                  selectedVillagePresidentIds.remove(
                                    villagePresident.id,
                                  );
                                } else if (selectedVillagePresidentIds.length <
                                    2) {
                                  selectedVillagePresidentIds.add(
                                    villagePresident.id,
                                  );
                                }
                              });
                            },
                            text: villagePresident.name,
                            leadingImage: '',
                            trailing: Checkbox(
                              value: isSelected,
                              onChanged: (bool? value) {
                                setModalState(() {
                                  if (value == true &&
                                      selectedVillagePresidentIds.length < 2) {
                                    selectedVillagePresidentIds.add(
                                      villagePresident.id,
                                    );
                                  } else {
                                    selectedVillagePresidentIds.remove(
                                      villagePresident.id,
                                    );
                                  }
                                });
                              },
                              activeColor: AppColor.themePrimaryColor,
                              side: BorderSide(
                                color: AppColor.dividerColor,
                                width: 1,
                              ),
                            ),
                            leading: ClipOval(
                              child: CustomCachedImage(
                                imageUrl: villagePresident.photo,
                                height: 40,
                                width: 40,
                              ),
                            ),
                          );
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      },
    ),
  );
}
