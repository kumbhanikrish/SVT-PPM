import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:sizer/sizer.dart';

import 'package:svt_ppm/module/app_features/cubit/schemas/schemas_cubit.dart';
import 'package:svt_ppm/module/app_features/model/schemas_model.dart';
import 'package:svt_ppm/utils/constant/app_image.dart';
import 'package:svt_ppm/utils/constant/app_page.dart';

import 'package:svt_ppm/utils/theme/colors.dart';
import 'package:svt_ppm/utils/widgets/custom_downloader.dart';
import 'package:svt_ppm/utils/widgets/custom_list_tile.dart';
import 'package:svt_ppm/utils/widgets/custom_text.dart';
import 'package:svt_ppm/utils/widgets/custom_widget.dart';

class SchemaSection extends StatefulWidget {
  const SchemaSection({super.key});

  @override
  State<SchemaSection> createState() => _SchemaSectionState();
}

class _SchemaSectionState extends State<SchemaSection> {
  List<SchemasModel> schemasList = [];

  @override
  void initState() {
    SchemasCubit schemasCubit = BlocProvider.of<SchemasCubit>(context);

    schemasCubit.getSchemasData(context);
    super.initState();
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
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 25),
          child: Column(
            children: <Widget>[
              CustomTitleSeeAllWidget(
                title: 'Schema Details',
                seeAllOnTap: () {},
                image: AppImage.schemaDetails,
                child: SizedBox(),
              ),
              Gap(16),

              BlocBuilder<SchemasCubit, SchemasState>(
                builder: (context, state) {
                  if (state is GetSchemasState) {
                    schemasList = state.schemasModel;
                  }
                  return schemasList.isEmpty
                      ? CustomEmpty()
                      : ListView.separated(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        separatorBuilder: (context, index) {
                          return Gap(10);
                        },
                        itemCount: schemasList.length,
                        itemBuilder: (context, index) {
                          return CustomListTile(
                            onTap: () {
                              Navigator.pushNamed(
                                context,
                                AppPage.schemaContentScreen,
                                arguments: {
                                  'template': schemasList[index].template,
                                  'title': schemasList[index].title,
                                  'schemaId': schemasList[index].id,
                                  'isApplied': schemasList[index].isApplied,
                                },
                              );
                            },
                            borderRadius: BorderRadius.circular(15),
                            tileColor: AppColor.fillColor,
                            contentPadding: EdgeInsets.symmetric(
                              horizontal: 12,
                            ),
                            text: '${index + 1}. ${schemasList[index].title}',
                            leadingImage: '',
                            trailing:
                                schemasList[index].isApplied
                                    ? Icon(
                                      Icons.check_circle,
                                      color: AppColor.greenColor,
                                    )
                                    : InkWell(
                                      onTap: () {
                                        generateAndDownloadPdf(
                                          title: schemasList[index].title,
                                          content: schemasList[index].template,
                                        );
                                      },
                                      child: SvgPicture.asset(AppImage.pdf),
                                    ),
                          );
                        },
                      );
                },
              ),
              Gap(75.h),
            ],
          ),
        ),
      ),
    );
  }
}
