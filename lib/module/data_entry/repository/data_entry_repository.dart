import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:svt_ppm/main.dart';
import 'package:svt_ppm/services/api_services.dart';

class DataEntryRepository {
  Future<Response> totalGetEntry(BuildContext context) async {
    Response response = await api.getDynamicData(
      context,
      '$baseUrl/total-gate-entry',
    );

    return response;
  }

  Future<Response> getExtraEntry(BuildContext context) async {
    Response response = await api.postDynamicData(
      context,
      '$baseUrl/gate-entry-extra',
      {},
    );

    return response;
  }

  Future<Response> getEntry(
    BuildContext context, {
    required String sNumber,
  }) async {
    Response response = await api.postDynamicData(
      context,
      '$baseUrl/gate-entry',
      {"s_number": sNumber},
    );

    return response;
  }
}
