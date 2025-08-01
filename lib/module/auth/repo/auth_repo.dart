import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:svt_ppm/services/api_services.dart';
import 'package:svt_ppm/utils/constant/app_api.dart';

class AuthRepo {
  Future<Response> checkMember(
    BuildContext context, {
    required Map<String, dynamic> params,
  }) async {
    Response response = await apiServices.postDynamicData(
      context,
      AppApi.checkMember,
      params,
      showLoading: false,
    );

    return response;
  }

  Future<Response> sendOtp(
    BuildContext context, {
    required Map<String, dynamic> params,
  }) async {
    Response response = await apiServices.postDynamicData(
      context,
      AppApi.sendOtp,
      params,
      showSuccessMessage: true,
    );

    return response;
  }

  Future<Response> verifyOtp(
    BuildContext context, {
    required Map<String, dynamic> params,
  }) async {
    Response response = await apiServices.postDynamicData(
      context,
      AppApi.verifyOtp,
      params,
      showSuccessMessage: true,
    );

    return response;
  }

  Future<Response> register(
    BuildContext context, {
    required Map<String, dynamic> params,
  }) async {
    Response response = await apiServices.postDynamicData(
      context,
      AppApi.register,
      params,
      isFormData: true,
      showSuccessMessage: true,
    );

    return response;
  }

  Future<Response> logout(
    BuildContext context, {
    required Map<String, dynamic> params,
  }) async {
    Response response = await apiServices.postDynamicData(
      context,
      AppApi.logout,
      showSuccessMessage: true,

      params,
    );

    return response;
  }

  Future<Response> village(BuildContext context) async {
    Response response = await apiServices.getDynamicData(
      context,
      AppApi.village,
    );

    return response;
  }
}
