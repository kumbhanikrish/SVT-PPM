import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:svt_ppm/services/api_services.dart';
import 'package:svt_ppm/utils/constant/app_api.dart';

class BenefitRepo {
  Future<Response> getBenefitData(BuildContext context) async {
    Response response = await apiServices.getDynamicData(
      context,
      AppApi.memberBenefits,
    );
    return response;
  }
}
