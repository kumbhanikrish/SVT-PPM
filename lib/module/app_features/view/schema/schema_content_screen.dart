import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:sizer/sizer.dart';
import 'package:svt_ppm/module/app_features/cubit/schemas/schemas_cubit.dart';
import 'package:svt_ppm/module/app_features/model/village_president_model.dart';
import 'package:svt_ppm/module/app_features/view/widget/app_feature_widget.dart';
import 'package:svt_ppm/module/home/view/widget/custom_home_widget.dart';
import 'package:svt_ppm/utils/theme/colors.dart';
import 'package:svt_ppm/utils/widgets/custom_app_bar.dart';
import 'package:svt_ppm/utils/widgets/custom_bottomsheet.dart';
import 'package:svt_ppm/utils/widgets/custom_button.dart';
import 'package:svt_ppm/utils/widgets/custom_error_toast.dart';
import 'package:svt_ppm/utils/widgets/custom_image.dart';
import 'package:svt_ppm/utils/widgets/custom_list_tile.dart';
import 'package:svt_ppm/utils/widgets/custom_text.dart';

class SchemaContentScreen extends StatefulWidget {
  final dynamic argument;
  const SchemaContentScreen({super.key, this.argument});

  @override
  State<SchemaContentScreen> createState() => _SchemaContentScreenState();
}

class _SchemaContentScreenState extends State<SchemaContentScreen> {
  Set<int> selectedMemberIds = {};

  @override
  Widget build(BuildContext context) {
    String title = widget.argument['title'];
    String template = widget.argument['template'];
    int schemaId = widget.argument['schemaId'];
    SelectMemberCubit selectMemberCubit = BlocProvider.of<SelectMemberCubit>(
      context,
    );
    selectMemberCubit.init();
    return Scaffold(
      appBar: CustomAppBar(title: title, actions: []),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 25),
          child: Column(
            children: [
              CustomHTMLText(text: template, color: AppColor.blackColor),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        child: BlocBuilder<SelectMemberCubit, MemberSelectState>(
          builder: (context, state) {
            if (state is MemberSelectionChanged) {
              selectedMemberIds = state.selectedMemberIds;
            }

            return CustomButton(
              text: 'Next',
              onTap: () {
                customNoOfMemberBottomSheet(
                  context,
                  buttonOnTap: () {
                    if (selectedMemberIds.isEmpty) {
                      customErrorToast(context, text: 'Please Select Member');
                    } else {
                      customVillagePresidentBottomSheet(
                        context,
                        selectedMemberIds: selectedMemberIds,
                        schemaId: schemaId,
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
        ),
      ),
    );
  }
}
