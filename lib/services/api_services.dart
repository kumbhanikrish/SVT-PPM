import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:svt_ppm/local_data/local_data_sever.dart';
import 'package:svt_ppm/utils/constant/app_page.dart';
import 'package:svt_ppm/utils/widgets/custom_error_toast.dart';

// Local data storage
LocalDataSaver dataSaver = LocalDataSaver();

class ApiServices {
  final Dio dio = Dio();

  /// Build headers for all API requests
  Future<Map<String, String>> _buildHeaders() async {
    final token = await dataSaver.getAuthToken();
    return {
      "Content-device": "application/json",
      "Authorization": "Bearer $token",
      "Accept": "application/json",
    };
  }

  /// GET Request
  Future<Response?> getDynamicData(BuildContext context, String url) async {
    log("GET URL: $url");
    try {
      await EasyLoading.show();

      final response = await dio.get(
        url,
        options: Options(headers: await _buildHeaders()),
      );

      log("Status Code: ${response.statusCode}");
      log("Response Data: ${response.data}");

      await EasyLoading.dismiss();
      if (response.statusCode == 200) return response;
    } on DioException catch (e) {
      _handleDioError(context, e);
    } catch (e) {
      await EasyLoading.dismiss();
      log("Unhandled Error: $e");
    }
    return null;
  }

  /// POST Request
  Future<Response?> postDynamicData(
    BuildContext context,
    String url,
    Map<String, dynamic> params,
  ) async {
    log("POST URL: $url");
    log("Parameters: $params");

    try {
      await EasyLoading.show();

      final response = await dio.post(
        url,
        data: params,
        options: Options(headers: await _buildHeaders()),
      );

      log("Status Code: ${response.statusCode}");
      log("Response Data: ${response.data}");

      await EasyLoading.dismiss();
      if (response.statusCode == 200) return response;
    } on DioException catch (e) {
      _handleDioError(context, e);
    } catch (e) {
      await EasyLoading.dismiss();
      log("Unhandled Error: $e");
    }
    return null;
  }

  /// DELETE Request
  Future<Response?> deleteDynamicData(
    BuildContext context,
    String url,
    Map<String, dynamic> params,
  ) async {
    log("DELETE URL: $url");
    log("Parameters: $params");

    try {
      await EasyLoading.show();

      final response = await dio.delete(
        url,
        data: params,
        options: Options(headers: await _buildHeaders()),
      );

      log("Status Code: ${response.statusCode}");
      log("Response Data: ${response.data}");

      await EasyLoading.dismiss();
      if (response.statusCode == 200) return response;
    } on DioException catch (e) {
      _handleDioError(context, e);
    } catch (e) {
      await EasyLoading.dismiss();
      log("Unhandled Error: $e");
    }
    return null;
  }

  /// POST FormData Request (e.g. file upload)
  Future<Response?> postDynamicFormData(
    BuildContext context,
    String url,
    Map<String, dynamic> body,
  ) async {
    log("POST FormData URL: $url");
    log("Form Body: $body");

    FormData formData = FormData.fromMap(body);

    try {
      await EasyLoading.show();

      final response = await dio.post(
        url,
        data: formData,
        options: Options(headers: await _buildHeaders()),
      );

      log("Status Code: ${response.statusCode}");
      log("Response Data: ${response.data}");

      await EasyLoading.dismiss();
      if (response.statusCode == 200) return response;
    } on DioException catch (e) {
      _handleDioError(context, e);
    } catch (e) {
      await EasyLoading.dismiss();
      log("Unhandled Error: $e");
    }
    return null;
  }

  /// Handles Dio errors uniformly across all methods
  void _handleDioError(BuildContext context, DioException e) async {
    await EasyLoading.dismiss();
    final statusCode = e.response?.statusCode;
    final errorMessage = e.response?.data['message'];

    log("DioException: $errorMessage, Status Code: $statusCode");

    if (statusCode == 401) {
      await dataSaver.setAuthToken('');
      Navigator.pushNamedAndRemoveUntil(
        context,
        AppPage.authScreen,
        (route) => false,
      );
    }

    customToast(
      context,
      text: errorMessage ?? 'Something went wrong',
      animatedSnackBarType: AnimatedSnackBarType.error,
    );
  }
}
