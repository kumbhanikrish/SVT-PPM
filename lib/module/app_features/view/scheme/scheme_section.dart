// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:gap/gap.dart';
// import 'package:sizer/sizer.dart';
//
// import 'package:svt_ppm/module/app_features/cubit/schemes/schemes_cubit.dart';
// import 'package:svt_ppm/module/app_features/model/schemes_model.dart';
// import 'package:svt_ppm/module/app_features/view/widget/app_feature_widget.dart';
// import 'package:svt_ppm/module/home/view/widget/custom_home_widget.dart';
// import 'package:svt_ppm/utils/constant/app_image.dart';
// import 'package:svt_ppm/utils/constant/app_page.dart';
// import 'package:svt_ppm/utils/theme/colors.dart';
// import 'package:svt_ppm/utils/widgets/custom_error_toast.dart';
// import 'package:svt_ppm/utils/widgets/custom_widget.dart';
// import '../../../../utils/widgets/custom_card.dart';
// import '../../../../utils/widgets/custom_text.dart';
//
// class SchemeSection extends StatefulWidget {
//   const SchemeSection({super.key});
//
//   @override
//   State<SchemeSection> createState() => _SchemeSectionState();
// }
//
// class _SchemeSectionState extends State<SchemeSection> {
//   List<SchemesModel> schemesList = [];
//
//   @override
//   void initState() {
//     SchemesCubit schemesCubit = BlocProvider.of<SchemesCubit>(context);
//     schemesCubit.getSchemesData(context);
//     super.initState();
//   }
//
//   Set<int> selectedMemberIds = {};
//
//   @override
//   Widget build(BuildContext context) {
//     SchemesCubit schemesCubit = BlocProvider.of<SchemesCubit>(context);
//
//     return RefreshIndicator(
//       backgroundColor: AppColor.whiteColor,
//       color: AppColor.themePrimaryColor,
//       elevation: 0,
//       onRefresh: () {
//         return schemesCubit.getSchemesData(context);
//       },
//       child: SingleChildScrollView(
//         child: Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 25),
//           child: Column(
//             children: <Widget>[
//               CustomTitleSeeAllWidget(
//                 title: 'Scheme Details',
//                 seeAllOnTap: () {},
//                 image: AppImage.schemeDetails,
//                 child: const SizedBox(),
//               ),
//               const Gap(16),
//               BlocBuilder<SchemesCubit, SchemesState>(
//                 builder: (context, state) {
//                   if (state is GetSchemesState) {
//                     schemesList = state.schemesModel;
//                   }
//                   if (schemesList.isEmpty) {
//                     return const CustomEmpty();
//                   }
//                   return ListView.separated(
//                     shrinkWrap: true,
//                     physics: const NeverScrollableScrollPhysics(),
//                     separatorBuilder: (context, index) => const Gap(15),
//                     itemCount: schemesList.length,
//                     itemBuilder: (context, index) {
//                       final scheme = schemesList[index];
//                       return BlocBuilder<SelectMemberCubit, MemberSelectState>(
//                         builder: (context, state) {
//                           if (state is MemberSelectionChanged) {
//                             selectedMemberIds = state.selectedMemberIds;
//                           }
//                           return SchemeItemCard(
//                             title: scheme.title,
//                             image: scheme.image,
//                             status: scheme.status,
//                             isApplied: scheme.isApplied,
//                             rejectReason: scheme.rejectReason,
//                             cardOnTap: () {
//                               Navigator.pushNamed(
//                                 context,
//                                 AppPage.schemeContentScreen,
//                                 arguments: {
//                                   'template': scheme.template,
//                                   'title': scheme.title,
//                                   'schemeId': scheme.id,
//                                   'isApplied': scheme.isApplied,
//                                 },
//                               );
//                             },
//                             onTap: () {
//                               customNoOfMemberBottomSheet(
//                                 context,
//                                 buttonOnTap: () {
//                                   if (selectedMemberIds.isEmpty) {
//                                     customErrorToast(
//                                       context,
//                                       text: 'Please Select Member',
//                                     );
//                                   } else {
//                                     customVillagePresidentBottomSheet(
//                                       context,
//                                       selectedMemberIds: selectedMemberIds,
//                                       schemeId: scheme.id,
//                                     );
//                                   }
//                                 },
//                                 single: true,
//                                 extra: false,
//                                 buttonName: 'Next',
//                               );
//                             },
//                           );
//                         },
//                       );
//                     },
//                   );
//                 },
//               ),
//               Gap(75.h),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:sizer/sizer.dart';

import 'package:svt_ppm/module/app_features/cubit/schemes/schemes_cubit.dart';
import 'package:svt_ppm/module/app_features/model/schemes_model.dart';
import 'package:svt_ppm/module/app_features/view/widget/app_feature_widget.dart';
import 'package:svt_ppm/module/home/view/widget/custom_home_widget.dart';
import 'package:svt_ppm/utils/constant/app_image.dart';
import 'package:svt_ppm/utils/constant/app_page.dart';
import 'package:svt_ppm/utils/theme/colors.dart';
import 'package:svt_ppm/utils/widgets/custom_error_toast.dart';
import 'package:svt_ppm/utils/widgets/custom_widget.dart';
import '../../../../utils/widgets/custom_card.dart';
import '../../../../utils/widgets/custom_text.dart';

class SchemeSection extends StatefulWidget {
  const SchemeSection({super.key});

  @override
  State<SchemeSection> createState() => _SchemeSectionState();
}

class _SchemeSectionState extends State<SchemeSection> {
  List<SchemesModel> schemesList = [];
  Set<int> selectedMemberIds = {};

  @override
  void initState() {
    super.initState();

    BlocProvider.of<SchemesCubit>(context).getSchemesData(context);
  }

  @override
  Widget build(BuildContext context) {
    SchemesCubit schemesCubit = BlocProvider.of<SchemesCubit>(context);

    return RefreshIndicator(
      backgroundColor: AppColor.whiteColor,
      color: AppColor.themePrimaryColor,
      elevation: 0,
      onRefresh: () {
        return schemesCubit.getSchemesData(context);
      },
      child: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),

        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 25),
          child: Column(
            children: <Widget>[
              CustomTitleSeeAllWidget(
                title: 'Scheme Details',
                seeAllOnTap: () {},
                image: AppImage.schemeDetails,
                child: const SizedBox(),
              ),
              const Gap(16),

              BlocBuilder<SchemesCubit, SchemesState>(
                builder: (context, state) {
                  if (state is GetSchemesState) {
                    schemesList = state.schemesModel;
                  }

                  if (schemesList.isEmpty) {
                    return const CustomEmpty();
                  }

                  return ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    separatorBuilder: (context, index) => const Gap(15),
                    itemCount: schemesList.length,
                    itemBuilder: (context, index) {
                      final scheme = schemesList[index];
                      return BlocBuilder<SelectMemberCubit, MemberSelectState>(
                        builder: (context, state) {
                          if (state is MemberSelectionChanged) {
                            selectedMemberIds = state.selectedMemberIds;
                          }
                          return SchemeItemCard(
                            title: scheme.title,
                            image: scheme.photo,
                            status: scheme.status,
                            isApplied: scheme.isApplied,
                            rejectReason: scheme.remarks,
                            cardOnTap: () {
                              Navigator.pushNamed(
                                context,
                                AppPage.schemeContentScreen,
                                arguments: {
                                  'template': scheme.template,
                                  'pdfTemplate': scheme.pdfTemplate,
                                  'title': scheme.title,
                                  'schemeId': scheme.id,
                                  'isApplied': scheme.isApplied,
                                  'documents': schemesList[index].documents,
                                },
                              );
                            },
                            onTap: () {
                              customNoOfMemberBottomSheet(
                                context,
                                buttonOnTap: () {
                                  if (selectedMemberIds.isEmpty) {
                                    customErrorToast(
                                      context,
                                      text: 'Please Select Member',
                                    );
                                  } else {
                                    customVillagePresidentBottomSheet(
                                      context,
                                      selectedMemberIds: selectedMemberIds,
                                      schemeId: scheme.id,
                                      documents: schemesList[index].documents,
                                    );
                                  }
                                },
                                single: true,
                                extra: false,
                                buttonName: 'Next',
                              );
                            },
                          );
                        },
                      );
                    },
                  );
                },
              ),
              Gap(20.h),
            ],
          ),
        ),
      ),
    );
  }
}
