import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:svt_ppm/services/api_services.dart';
import 'package:svt_ppm/utils/constant/app_api.dart';

class KitsRepo {
  Future<Response> getKitsData(BuildContext context) async {
    Response response = await apiServices.getDynamicData(context, AppApi.kits);

    return response;
  }

  Future<Response> kitsRegistration(
    BuildContext context, {
    required Map<String, dynamic> params,
  }) async {
    Response response = await apiServices.postDynamicData(
      context,
      AppApi.kitsRegistration,
      params,
      isFormData: true,
      showSuccessMessage: true,
    );

    return response;
  }

  Future<Response> kitsRegistrationStatus(
    BuildContext context, {
    required Map<String, dynamic> params,
  }) async {
    Response response = await apiServices.postDynamicData(
      context,
      AppApi.kitsRegistrationStatus,
      params,

      showSuccessMessage: false,
    );

    return response;
  }
}
