import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:svt_ppm/module/app_features/repo/exam_repo.dart';
import 'package:svt_ppm/utils/widgets/custom_success_dialog.dart';

part 'exam_state.dart';

class ExamCubit extends Cubit<ExamState> {
  ExamCubit() : super(ExamInitial());

  ExamRepo examRepo = ExamRepo();

  getExamData(BuildContext context) async {
    Response response = await examRepo.getExamData(context);
    if (response.data['success'] == true) {
      final data = response.data['data'];

      emit(GetExamState(examData: data));
      return data;
    }
  }

  Future<Response> examRegistration(
    BuildContext context, {
    required int memberId,
    required String language,
  }) async {
    Map<String, dynamic> params = {
      'member_id': memberId.toString(),
      'language': language,
    };

    Response response = await examRepo.examRegistration(
      context,
      params: params,
    );

    if (response.data['success'] == true) {
      Navigator.pop(context);
      getExamData(context);

      showCustomDialog(
        context,
        title: 'Success',
        subTitle: 'Exam Registered Successfully',
        buttonText: 'OK',
      );
    }
    return response;
  }

  init() {
    emit(GetExamState(examData: {}));
  }
}

class LanguageCubit extends Cubit<String> {
  LanguageCubit() : super(''); // default selection

  void selectLanguage(String language) {
    emit(language);
  }

  init() {
    emit('');
  }
}
