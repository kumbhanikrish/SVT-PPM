// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:gap/gap.dart';
// import 'package:sizer/sizer.dart';
//
// import 'package:svt_ppm/module/app_features/cubit/schemas/schemas_cubit.dart';
// import 'package:svt_ppm/module/app_features/model/schemas_model.dart';
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
// class SchemaSection extends StatefulWidget {
//   const SchemaSection({super.key});
//
//   @override
//   State<SchemaSection> createState() => _SchemaSectionState();
// }
//
// class _SchemaSectionState extends State<SchemaSection> {
//   List<SchemasModel> schemasList = [];
//
//   @override
//   void initState() {
//     SchemasCubit schemasCubit = BlocProvider.of<SchemasCubit>(context);
//     schemasCubit.getSchemasData(context);
//     super.initState();
//   }
//
//   Set<int> selectedMemberIds = {};
//
//   @override
//   Widget build(BuildContext context) {
//     SchemasCubit schemasCubit = BlocProvider.of<SchemasCubit>(context);
//
//     return RefreshIndicator(
//       backgroundColor: AppColor.whiteColor,
//       color: AppColor.themePrimaryColor,
//       elevation: 0,
//       onRefresh: () {
//         return schemasCubit.getSchemasData(context);
//       },
//       child: SingleChildScrollView(
//         child: Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 25),
//           child: Column(
//             children: <Widget>[
//               CustomTitleSeeAllWidget(
//                 title: 'Schema Details',
//                 seeAllOnTap: () {},
//                 image: AppImage.schemaDetails,
//                 child: const SizedBox(),
//               ),
//               const Gap(16),
//               BlocBuilder<SchemasCubit, SchemasState>(
//                 builder: (context, state) {
//                   if (state is GetSchemasState) {
//                     schemasList = state.schemasModel;
//                   }
//                   if (schemasList.isEmpty) {
//                     return const CustomEmpty();
//                   }
//                   return ListView.separated(
//                     shrinkWrap: true,
//                     physics: const NeverScrollableScrollPhysics(),
//                     separatorBuilder: (context, index) => const Gap(15),
//                     itemCount: schemasList.length,
//                     itemBuilder: (context, index) {
//                       final schema = schemasList[index];
//                       return BlocBuilder<SelectMemberCubit, MemberSelectState>(
//                         builder: (context, state) {
//                           if (state is MemberSelectionChanged) {
//                             selectedMemberIds = state.selectedMemberIds;
//                           }
//                           return SchemaItemCard(
//                             title: schema.title,
//                             image: schema.image,
//                             status: schema.status,
//                             isApplied: schema.isApplied,
//                             rejectReason: schema.rejectReason,
//                             cardOnTap: () {
//                               Navigator.pushNamed(
//                                 context,
//                                 AppPage.schemaContentScreen,
//                                 arguments: {
//                                   'template': schema.template,
//                                   'title': schema.title,
//                                   'schemaId': schema.id,
//                                   'isApplied': schema.isApplied,
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
//                                       schemaId: schema.id,
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

import 'package:svt_ppm/module/app_features/cubit/schemas/schemas_cubit.dart';
import 'package:svt_ppm/module/app_features/model/schemas_model.dart';
import 'package:svt_ppm/module/app_features/view/widget/app_feature_widget.dart';
import 'package:svt_ppm/module/home/view/widget/custom_home_widget.dart';
import 'package:svt_ppm/utils/constant/app_image.dart';
import 'package:svt_ppm/utils/constant/app_page.dart';
import 'package:svt_ppm/utils/theme/colors.dart';
import 'package:svt_ppm/utils/widgets/custom_error_toast.dart';
import 'package:svt_ppm/utils/widgets/custom_widget.dart';
import '../../../../utils/widgets/custom_card.dart';
import '../../../../utils/widgets/custom_text.dart';

class SchemaSection extends StatefulWidget {
  const SchemaSection({super.key});

  @override
  State<SchemaSection> createState() => _SchemaSectionState();
}

class _SchemaSectionState extends State<SchemaSection> {
  List<SchemasModel> schemasList = [];
  Set<int> selectedMemberIds = {};

  @override
  void initState() {
    super.initState();

    BlocProvider.of<SchemasCubit>(context).getSchemasData(context);
  }

  @override
  Widget build(BuildContext context) {
    SchemasCubit schemasCubit = BlocProvider.of<SchemasCubit>(context);

    return RefreshIndicator(
      backgroundColor: AppColor.whiteColor,
      color: AppColor.themePrimaryColor,
      elevation: 0,
      onRefresh: () {
        return schemasCubit.getSchemasData(context);
      },
      child: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),

        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 25),
          child: Column(
            children: <Widget>[
              CustomTitleSeeAllWidget(
                title: 'Schema Details',
                seeAllOnTap: () {},
                image: AppImage.schemaDetails,
                child: const SizedBox(),
              ),
              const Gap(16),

              BlocBuilder<SchemasCubit, SchemasState>(
                builder: (context, state) {
                  if (state is GetSchemasState) {
                    schemasList = state.schemasModel;
                  }

                  if (schemasList.isEmpty) {
                    return const CustomEmpty();
                  }

                  return ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    separatorBuilder: (context, index) => const Gap(15),
                    itemCount: schemasList.length,
                    itemBuilder: (context, index) {
                      final schema = schemasList[index];
                      return BlocBuilder<SelectMemberCubit, MemberSelectState>(
                        builder: (context, state) {
                          if (state is MemberSelectionChanged) {
                            selectedMemberIds = state.selectedMemberIds;
                          }
                          return SchemaItemCard(
                            title: schema.title,
                            image: schema.photo,
                            status: schema.status,
                            isApplied: schema.isApplied,
                            rejectReason: schema.remarks,
                            cardOnTap: () {
                              Navigator.pushNamed(
                                context,
                                AppPage.schemaContentScreen,
                                arguments: {
                                  'template': schema.template,
                                  'pdfTemplate': schema.pdfTemplate,
                                  'title': schema.title,
                                  'schemaId': schema.id,
                                  'isApplied': schema.isApplied,
                                  'documents': schemasList[index].documents,
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
                                      schemaId: schema.id,
                                      documents: schemasList[index].documents,
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
