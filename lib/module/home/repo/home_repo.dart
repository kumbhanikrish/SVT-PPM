import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:svt_ppm/services/api_services.dart';
import 'package:svt_ppm/utils/constant/app_api.dart';

class HomeRepo {
  Future<Response> getHomeData(BuildContext context) async {
    Response response = await apiServices.getDynamicData(context, AppApi.home);

    return response;
  }

  Future<Response> getMemberFamily(BuildContext context) async {
    Response response = await apiServices.getDynamicData(
      context,
      AppApi.memberFamily,
    );

    return response;
  }

  Future<Response> eventsRegistration(
    BuildContext context, {
    required Map<String, dynamic> params,
  }) async {
    Response response = await apiServices.postDynamicData(
      context,
      AppApi.eventsRegistration,
      params,
    );

    return response;
  }
}
