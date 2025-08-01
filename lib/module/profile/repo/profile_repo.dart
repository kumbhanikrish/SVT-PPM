import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:svt_ppm/services/api_services.dart';
import 'package:svt_ppm/utils/constant/app_api.dart';

class ProfileRepo {
  Future<Response> addMemberFamily(
    BuildContext context, {
    required Map<String, dynamic> data,
    required String memberId,
  }) async {
    Response response = await apiServices.postDynamicData(
      context,
      '${AppApi.memberFamily}$memberId',
      data,
      isFormData: true,
    );

    return response;
  }
}
