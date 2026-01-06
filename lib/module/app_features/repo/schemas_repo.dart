import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:svt_ppm/services/api_services.dart';
import 'package:svt_ppm/utils/constant/app_api.dart';

class SchemasRepo {
  Future<Response> getSchemasData(BuildContext context) async {
    Response response = await apiServices.getDynamicData(
      context,
      AppApi.schema,
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

  Future<Response> schemasRegistration(
    BuildContext context, {
    required Map<String, dynamic> params,
  }) async {
    log('paramsparamdfgds ::$params');
    Response response = await apiServices.postDynamicData(
      context,
      AppApi.schemasRegistration,
      params,
      showSuccessMessage: true,
      isFormData: true,
    );

    return response;
  }

  Future<Response> roleSchemasRegistration(BuildContext context) async {
    Response response = await apiServices.getDynamicData(
      context,
      AppApi.schemasRegistration,
    );

    return response;
  }

  Future<Response> schemasRegistrationChangeStatus(
    BuildContext context, {

    required Map<String, dynamic> params,
  }) async {
    Response response = await apiServices.postDynamicData(
      context,
      AppApi.schemasRegistrationChangeStatus,
      params,
    );

    return response;
  }
}
