import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:sizer/sizer.dart';
import 'package:svt_ppm/module/app_features/cubit/community/community_cubit.dart';
import 'package:svt_ppm/utils/constant/app_image.dart';
import 'package:svt_ppm/utils/constant/app_page.dart';
import 'package:svt_ppm/utils/formatter/format.dart';
import 'package:svt_ppm/utils/theme/colors.dart';
import 'package:svt_ppm/utils/widgets/custom_card.dart';
import 'package:svt_ppm/utils/widgets/custom_text.dart';
import 'package:svt_ppm/utils/widgets/custom_widget.dart';

class ComitySection extends StatefulWidget {
  const ComitySection({super.key});

  @override
  State<ComitySection> createState() => _ComitySectionState();
}

class _ComitySectionState extends State<ComitySection> {
  @override
  void initState() {
    CommunityCubit communityCubit = BlocProvider.of<CommunityCubit>(context);
    communityCubit.getCommunityMembers(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    CommunityCubit communityCubit = BlocProvider.of<CommunityCubit>(context);

    Map<String, dynamic> committeeData = {};
    return RefreshIndicator(
      backgroundColor: AppColor.whiteColor,
      color: AppColor.themePrimaryColor,
      elevation: 0,
      onRefresh: () {
        return communityCubit.getCommunityMembers(context);
      },
      child: SingleChildScrollView(
        child: BlocBuilder<CommunityCubit, CommunityState>(
          builder: (context, state) {
            if (state is GetCommunityMembersState) {
              committeeData = state.communityMembersModel;
            }
            return Column(
              children:
                  committeeData.entries.map((entry) {
                    final String key = entry.key;
                    final dynamic value = entry.value;
                    String formattedTitle = formatTitle(key);

                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Gap(10),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 15,
                          ),
                          child: CustomTitleSeeAllWidget(
                            title: formattedTitle,
                            seeAllOnTap: () {
                              if (value is List) {
                                Navigator.pushNamed(
                                  context,
                                  AppPage.comitySeeAllScreen,
                                  arguments: {
                                    'comityData': value,
                                    'formattedTitle': formattedTitle,
                                    'showNo':
                                        key == 'karobari' ||
                                                key == 'working' ||
                                                key == 'yuva_yoddha'
                                            ? false
                                            : true,
                                  },
                                );
                              }
                            },
                            image: AppImage.president,
                            child:
                                value is List
                                    ? Padding(
                                      padding: const EdgeInsets.only(
                                        left: 20,
                                        // top: 10,
                                        bottom: 10,
                                      ),
                                      child: SvgPicture.asset(
                                        AppImage.rightArrow,
                                      ),
                                    )
                                    : SizedBox(),
                          ),
                        ),
                        value is List
                            ? value.isEmpty
                                ? CustomEmpty()
                                : Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 16,
                                  ),
                                  child: GridView.builder(
                                    shrinkWrap: true,
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    gridDelegate:
                                        SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisCount: 2,
                                          crossAxisSpacing: 7,
                                          mainAxisSpacing: 13,
                                          mainAxisExtent: 21.h,
                                        ),
                                    itemCount: value.length,
                                    itemBuilder: (context, index) {
                                      final member = value[index];
                                      return CustomTeamCard(
                                        image: member['photo'],
                                        name: member['name'],
                                        number:
                                            key == 'karobari' ||
                                                    key == 'working' ||
                                                    key == 'yuva_yoddha'
                                                ? ''
                                                : member['mobile_no'],

                                        position: member['village_name'],
                                      );
                                    },
                                  ),
                                )
                            : value == null
                            ? CustomEmpty()
                            : Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16,
                              ),
                              child: CustomPresidentCard(
                                image: value['photo'] ?? '',
                                name: value['name'] ?? '',
                                position: value['village_name'],

                                // des: 'Mobile: ${value['mobile_no']}',
                              ),
                            ),
                        Gap(15),
                        CustomDivider(),
                      ],
                    );
                  }).toList(),
            );
          },
        ),
      ),
    );
  }
}
