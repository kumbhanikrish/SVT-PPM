import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:sizer/sizer.dart';
import 'package:svt_ppm/module/auth/model/login_model.dart';
import 'package:svt_ppm/module/home/cubit/home_cubit.dart';
import 'package:svt_ppm/utils/theme/colors.dart';
import 'package:svt_ppm/utils/widgets/custom_bottomsheet.dart';
import 'package:svt_ppm/utils/widgets/custom_image.dart';
import 'package:svt_ppm/utils/widgets/custom_list_tile.dart';
import 'package:svt_ppm/utils/widgets/custom_textfield.dart';

void customNoOfMemberBottomSheet(
  BuildContext context, {
  bool single = false,
  required int eventId,
}) {
  HomeCubit homeCubit = BlocProvider.of<HomeCubit>(context);

  List<LoginModel> noOfMemberList = [];
  Set<int> selectedMemberIds = {};
  bool showExtraMemberInput = false;
  TextEditingController extraMemberController = TextEditingController();

  homeCubit.memberFamily(context);

  customBottomSheet(
    context,
    buttonOnTap: () {
      homeCubit.eventsRegistration(
        context,
        eventId: eventId, // Example event ID
        memberIds: selectedMemberIds.toList(),
        extraMember: int.tryParse(extraMemberController.text) ?? 0,
      );
    },
    showButton: true,
    title: 'No of Member',

    child: StatefulBuilder(
      builder: (BuildContext context, StateSetter setModalState) {
        return Flexible(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Gap(10),
                SizedBox(
                  height: 40.h,
                  child: BlocBuilder<HomeCubit, HomeState>(
                    builder: (context, state) {
                      if (state is GetHomeState) {
                        noOfMemberList = state.noOfMemberList;
                      }

                      return ListView.builder(
                        itemCount:
                            noOfMemberList.length + 1, // +1 for "Extra Member"
                        itemBuilder: (BuildContext context, int index) {
                          // Last item is "Extra Member"
                          if (index == noOfMemberList.length) {
                            return CustomListTile(
                              contentPadding: EdgeInsets.symmetric(
                                horizontal: 16,
                              ),
                              text: 'Extra Member',
                              leadingImage: '',
                              trailing: Checkbox(
                                value: showExtraMemberInput,
                                onChanged: (bool? value) {
                                  setModalState(() {
                                    showExtraMemberInput = value ?? false;
                                  });
                                },
                                activeColor: AppColor.themePrimaryColor,
                                side: BorderSide(
                                  color: AppColor.dividerColor,
                                  width: 1,
                                ),
                              ),

                              onTap: () {
                                setModalState(() {
                                  showExtraMemberInput = !showExtraMemberInput;
                                });
                              },
                            );
                          }

                          final member = noOfMemberList[index];
                          final isSelected = selectedMemberIds.contains(
                            member.id,
                          );

                          return CustomListTile(
                            contentPadding: EdgeInsets.symmetric(
                              horizontal: 16,
                            ),
                            onTap: () {
                              setModalState(() {
                                if (single) {
                                  selectedMemberIds = {member.id};
                                } else {
                                  if (isSelected) {
                                    selectedMemberIds.remove(member.id);
                                  } else {
                                    selectedMemberIds.add(member.id);
                                  }
                                }
                              });
                            },
                            text: member.name,
                            leadingImage: '',
                            trailing: Checkbox(
                              value: isSelected,
                              onChanged: (bool? value) {
                                setModalState(() {
                                  if (single) {
                                    selectedMemberIds =
                                        value == true ? {member.id} : {};
                                  } else {
                                    if (value == true) {
                                      selectedMemberIds.add(member.id);
                                    } else {
                                      selectedMemberIds.remove(member.id);
                                    }
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
                                imageUrl: member.photo,
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

                /// 👇 Show TextField if "Extra Member" is selected
                if (showExtraMemberInput) ...[
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: CustomTextField(
                      hintText: 'Number of Extra Members',
                      labelText: 'Members',
                      controller: extraMemberController,
                    ),
                  ),
                ],
              ],
            ),
          ),
        );
      },
    ),
  );
}
