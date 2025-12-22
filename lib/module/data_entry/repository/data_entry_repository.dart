import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:svt_ppm/main.dart';
import 'package:svt_ppm/services/api_services.dart';
import 'package:svt_ppm/utils/constant/app_api.dart';

class DataEntryRepository {
  Future<Response> totalGetEntry(BuildContext context) async {
    Response response = await apiServices.getDynamicData(
      context,
      AppApi.totalGateEntry,
    );

    return response;
  }

  Future<Response> getExtraEntry(BuildContext context) async {
    Response response = await apiServices.postDynamicData(
      context,
      AppApi.gateEntryExtra,
      {},
    );

    return response;
  }

  Future<Response> getEntry(
    BuildContext context, {
    required Map<String, dynamic> body,
  }) async {
    Response response = await apiServices.postDynamicData(
      context,
      AppApi.gateEntry,

      body,
    );

    return response;
  }
}
