import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:svt_ppm/module/app_features/cubit/exam/exam_cubit.dart';
import 'package:svt_ppm/utils/constant/app_image.dart';
import 'package:svt_ppm/utils/theme/colors.dart';
import 'package:svt_ppm/utils/widgets/custom_bottomsheet.dart';
import 'package:svt_ppm/utils/widgets/custom_radio_list_tile.dart';

languageBottomSheet(BuildContext context, {required int memberId}) {
  ExamCubit examCubit = BlocProvider.of<ExamCubit>(context);
  LanguageCubit languageCubit = BlocProvider.of<LanguageCubit>(context);
  languageCubit.init();
  return customBottomSheet(
    context,
    title: 'Select Language',
    child: BlocBuilder<LanguageCubit, String>(
      builder: (context, selectedLanguage) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
          child: Column(
            children: <Widget>[
              customRadio(
                buttonImage:
                    selectedLanguage == 'English'
                        ? AppImage.radioButton
                        : AppImage.circle,
                title: 'English',
                genderIcon: '',
                borderColor: AppColor.transparentColor,
                padding: EdgeInsets.zero,
                onTap: () async {
                  languageCubit.selectLanguage('English');
                },
              ),
              Gap(16),
              customRadio(
                buttonImage:
                    selectedLanguage == 'Gujarati'
                        ? AppImage.radioButton
                        : AppImage.circle,
                title: 'Gujarati',
                genderIcon: '',
                borderColor: AppColor.transparentColor,
                padding: EdgeInsets.zero,
                onTap: () async {
                  languageCubit.selectLanguage('Gujarati');
                },
              ),
            ],
          ),
        );
      },
    ),
    showButton: true,
    buttonOnTap: () async {
      await examCubit.examRegistration(
        context,
        memberId: memberId,
        language: languageCubit.state,
      );
    },
  );
}

// customResultAndHallTicketBottomSheet(
//   BuildContext context, {
//   String? result,
//   String? hallTicket,
// }) {
//   return customBottomSheet(
//     context,
//     title: hallTicket == null ? 'Result' : 'Hall Ticket',
//     child: Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
//       child: Column(
//         children: <Widget>[CustomHTMLText(text: hallTicket ?? (result ?? ''))],
//       ),
//     ),
//     showButton: false,
//     buttonOnTap: () {},
//   );
// }
