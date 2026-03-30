import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:sizer/sizer.dart';
import 'package:svt_ppm/module/app_features/cubit/schemes/schemes_cubit.dart';
import 'package:svt_ppm/module/app_features/model/schemes_model.dart';
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
  required int schemeId,
  required List<Document> documents,
}) {
  SchemesCubit schemesCubit = BlocProvider.of<SchemesCubit>(context);
  List<VillagePresidentModel> villagePresidentList = [];
  Set<int> selectedVillagePresidentIds = {};

  schemesCubit.villagePresident(context);

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
            'schemeId': schemeId,
            'selectedVillagePresidentIds': selectedVillagePresidentIds.toList(),
            'memberId': selectedMemberIds.first,
            'documents': documents,
          },
        );
      }
    },

    showButton: true,
    title: 'Gam Pratinidhi',
    child: StatefulBuilder(
      builder: (BuildContext context, StateSetter setModalState) {
        return Flexible(
          child: SingleChildScrollView(
            child: Column(
              children: [
                const Gap(10),
                SizedBox(
                  height: 40.h,
                  child: BlocBuilder<SchemesCubit, SchemesState>(
                    builder: (context, state) {
                      if (state is GetSchemesState) {
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
