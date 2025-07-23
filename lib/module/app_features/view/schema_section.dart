import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:sizer/sizer.dart';
import 'package:svt_ppm/module/app_features/cubit/schemas/schemas_cubit.dart';
import 'package:svt_ppm/module/app_features/model/schemas_model.dart';
import 'package:svt_ppm/utils/constant/app_image.dart';
import 'package:svt_ppm/utils/theme/colors.dart';
import 'package:svt_ppm/utils/widgets/custom_bottomsheet.dart';
import 'package:svt_ppm/utils/widgets/custom_list_tile.dart';
import 'package:svt_ppm/utils/widgets/custom_text.dart';
import 'package:svt_ppm/utils/widgets/custom_widget.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:open_file/open_file.dart';

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

  Future<void> generateAndDownloadPdf({
    required String title,
    required String content,
  }) async {
    final pdf = pw.Document();

    pdf.addPage(
      pw.Page(
        build:
            (pw.Context context) => pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                pw.Text(
                  title,
                  style: pw.TextStyle(
                    fontSize: 24,
                    fontWeight: pw.FontWeight.bold,
                  ),
                ),
                pw.SizedBox(height: 20),
                pw.Text(content, style: pw.TextStyle(fontSize: 14)),
              ],
            ),
      ),
    );

    try {
      final dir = await getApplicationDocumentsDirectory();
      final file = File('${dir.path}/$title.pdf');

      await file.writeAsBytes(await pdf.save());

      await OpenFile.open(file.path); // Opens the PDF file
    } catch (e) {
      log('Error generating PDF: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
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
                            customSchemaContent(
                              context,
                              title: schemasList[index].title,
                              template: schemasList[index].template,
                            );
                          },
                          borderRadius: BorderRadius.circular(15),
                          tileColor: AppColor.fillColor,
                          contentPadding: EdgeInsets.symmetric(horizontal: 12),
                          text: '${index + 1}. ${schemasList[index].title}',
                          leadingImage: '',
                          trailing: InkWell(
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
          ],
        ),
      ),
    );
  }
}

customSchemaContent(
  BuildContext context, {
  required String template,
  required String title,
}) {
  customBottomSheet(
    context,
    title: title,
    child: SizedBox(
      height: 50.h,
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 25),
          child: Column(children: [CustomHTMLText(text: template)]),
        ),
      ),
    ),
    showButton: false,
    buttonOnTap: () {},
  );
}
