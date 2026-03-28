import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:svt_ppm/services/api_services.dart';
import 'package:svt_ppm/utils/constant/app_api.dart';

class SchemesRepo {
  Future<Response> getSchemesData(BuildContext context) async {
    Response response = await apiServices.getDynamicData(
      context,
      AppApi.scheme,
    );

    return response;
  }

  Future<Response> villagePresident(BuildContext context) async {
    Response response = await apiServices.getDynamicData(
      context,
      AppApi.villagePresident,
    );

    return response;
  }

  Future<Response> schemesRegistration(
    BuildContext context, {
    required Map<String, dynamic> params,
  }) async {
    log('paramsparamdfgds ::$params');
    Response response = await apiServices.postDynamicData(
      context,
      AppApi.schemesRegistration,
      params,
      showSuccessMessage: true,
      isFormData: true,
    );

    return response;
  }

  Future<Response> roleSchemesRegistration(BuildContext context) async {
    Response response = await apiServices.getDynamicData(
      context,
      AppApi.schemesRegistration,
    );

    return response;
  }

  Future<Response> schemesRegistrationChangeStatus(
    BuildContext context, {

    required Map<String, dynamic> params,
  }) async {
    Response response = await apiServices.postDynamicData(
      context,
      AppApi.schemesRegistrationChangeStatus,
      params,
    );

    return response;
  }
}
