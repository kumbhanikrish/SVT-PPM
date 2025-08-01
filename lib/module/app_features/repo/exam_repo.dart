import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:svt_ppm/services/api_services.dart';
import 'package:svt_ppm/utils/constant/app_api.dart';

class ExamRepo {
  Future<Response> getExamData(BuildContext context) async {
    Response response = await apiServices.getDynamicData(context, AppApi.exam);

    return response;
  }

  Future<Response> examRegistration(
    BuildContext context, {
    required Map<String, dynamic> params,
  }) async {
    Response response = await apiServices.postDynamicData(
      context,
      AppApi.examsRegistration,
      params,

      showSuccessMessage: false,
    );

    return response;
  }
}
