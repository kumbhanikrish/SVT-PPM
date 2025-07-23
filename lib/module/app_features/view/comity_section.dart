import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:sizer/sizer.dart';
import 'package:svt_ppm/module/app_features/cubit/community/community_cubit.dart';
import 'package:svt_ppm/utils/constant/app_image.dart';
import 'package:svt_ppm/utils/constant/app_page.dart';
import 'package:svt_ppm/utils/widgets/custom_card.dart';
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
    Map<String, dynamic> committeeData = {};
    return SingleChildScrollView(
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
                  String formattedTitle = _formatTitle(key);

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
                          ? Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: GridView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 3,
                                    crossAxisSpacing: 7,
                                    mainAxisSpacing: 13,
                                    mainAxisExtent: 16.h,
                                  ),
                              itemCount: value.length,
                              itemBuilder: (context, index) {
                                final member = value[index];
                                return CustomTeamCard(
                                  image: member['photo'],
                                  name: member['name'],
                                  position: formattedTitle,
                                );
                              },
                            ),
                          )
                          : Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: CustomPresidentCard(
                              image: value['photo'],
                              name: value['name'],
                              position: formattedTitle,
                              des: 'Mobile: ${value['mobile_no']}',
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
    );
  }

  String _formatTitle(String key) {
    return key
        .replaceAll('_', ' ') // snake_case to words
        .replaceAllMapped(
          RegExp(r'(^\w|\s\w)'),
          (match) => match.group(0)!.toUpperCase(),
        ); // Capitalize first letter of each word
  }
}
