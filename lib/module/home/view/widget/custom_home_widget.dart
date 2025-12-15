import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:sizer/sizer.dart';
import 'package:svt_ppm/module/app_features/cubit/schemas/schemas_cubit.dart';
import 'package:svt_ppm/module/auth/model/login_model.dart';
import 'package:svt_ppm/module/home/cubit/home_cubit.dart';
import 'package:svt_ppm/utils/theme/colors.dart';
import 'package:svt_ppm/utils/widgets/custom_bottomsheet.dart';
import 'package:svt_ppm/utils/widgets/custom_image.dart';
import 'package:svt_ppm/utils/widgets/custom_list_tile.dart';
import 'package:svt_ppm/utils/widgets/custom_text.dart';
import 'package:svt_ppm/utils/widgets/custom_textfield.dart';

void customNoOfMemberBottomSheet(
  BuildContext context, {
  bool single = false,
  bool extra = false,
  bool seeAll = false,
  int eventId = 0,

  String? buttonName,
  void Function()? buttonOnTap,
}) {
  HomeCubit homeCubit = BlocProvider.of<HomeCubit>(context);
  SelectMemberCubit selectMemberCubit = BlocProvider.of<SelectMemberCubit>(
    context,
  );
  Set<int> selectedMemberIds = {};

  List<LoginModel> noOfMemberList = [];

  bool showExtraMemberInput = false;
  TextEditingController extraMemberController = TextEditingController();

  homeCubit.memberFamily(context, pageName: '');

  customBottomSheet(
    context,
    buttonName: buttonName ?? 'Submit',
    buttonOnTap:
        buttonOnTap ??
        () {
          if (selectMemberCubit.state is MemberSelectionChanged) {
            selectedMemberIds =
                (selectMemberCubit.state as MemberSelectionChanged)
                    .selectedMemberIds;
          }

          homeCubit.eventsRegistration(
            context,
            seeAll: seeAll,
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

                      return noOfMemberList.isEmpty
                          ? CustomEmpty()
                          : BlocBuilder<SelectMemberCubit, MemberSelectState>(
                            builder: (context, state) {
                              if (state is MemberSelectionChanged) {
                                selectedMemberIds = state.selectedMemberIds;
                              }
                              return ListView.builder(
                                itemCount:
                                    extra
                                        ? noOfMemberList.length + 1
                                        : noOfMemberList
                                            .length, // +1 for "Extra Member"
                                itemBuilder: (BuildContext context, int index) {
                                  if (extra) {
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
                                              showExtraMemberInput =
                                                  value ?? false;
                                            });
                                          },
                                          activeColor:
                                              AppColor.themePrimaryColor,
                                          side: BorderSide(
                                            color: AppColor.dividerColor,
                                            width: 1,
                                          ),
                                        ),

                                        onTap: () {
                                          setModalState(() {
                                            showExtraMemberInput =
                                                !showExtraMemberInput;
                                          });
                                        },
                                      );
                                    }
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
                                      selectMemberCubit.toggleMemberSelection(
                                        member.id,
                                        single: single,
                                      );
                                      // setModalState(() {
                                      //   if (single) {
                                      //     selectedMemberIds = {member.id};
                                      //   } else {
                                      //     if (isSelected) {
                                      //       selectedMemberIds.remove(member.id);
                                      //     } else {
                                      //       selectedMemberIds.add(member.id);
                                      //     }
                                      //   }
                                      // });
                                    },
                                    text: member.name,
                                    leadingImage: '',
                                    trailing: Checkbox(
                                      value: isSelected,
                                      onChanged: (bool? value) {
                                        selectMemberCubit.toggleMemberSelection(
                                          member.id,
                                          single: single,
                                        );
                                        // setModalState(() {
                                        //   if (single) {
                                        //     selectedMemberIds =
                                        //         value == true ? {member.id} : {};
                                        //   } else {
                                        //     if (value == true) {
                                        //       selectedMemberIds.add(member.id);
                                        //     } else {
                                        //       selectedMemberIds.remove(member.id);
                                        //     }
                                        //   }
                                        // });
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
                          );
                    },
                  ),
                ),

                if (showExtraMemberInput) ...[
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: CustomTextField(
                      hintText: 'Number of Extra Members',
                      labelText: 'Members',
                      controller: extraMemberController,
                      keyboardType: TextInputType.number,
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
