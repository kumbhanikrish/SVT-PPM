import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:svt_ppm/local_data/local_data_sever.dart';
import 'package:svt_ppm/utils/constant/app_api.dart';
import 'package:svt_ppm/utils/constant/app_page.dart';
import 'package:svt_ppm/utils/widgets/custom_error_toast.dart';

// Local data storage
LocalDataSaver dataSaver = LocalDataSaver();
ApiServices apiServices = ApiServices();

String baseUrl = dotenv.env['BASE_URL'] ?? 'demo';

class ApiServices {
  final Dio dio = Dio();

  /// Build headers for all API requests
  Future<Map<String, String>> _buildHeaders() async {
    final token = await dataSaver.getAuthToken();
    final language = await dataSaver.getLanguage();
    log("Auth Token: $token");
    return {
      "Content-device": "application/json",
      "Authorization": "Bearer $token",
      "Accept": "application/json",
      "Accept-Language": language.isNotEmpty ? language : 'en',
    };
  }

  /// GET Request
  Future getDynamicData(BuildContext context, String url) async {
    log("GET URL: ${'$baseUrl$url'}");
    try {
      await EasyLoading.show();

      final response = await dio.get(
        '$baseUrl$url',
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
  Future postDynamicData(
    BuildContext context,
    String url,
    Map<String, dynamic> params, {
    bool showSuccessMessage = false,
    bool isFormData = false,
    bool showLoading = true,
  }) async {
    log("POST URL: ${'$baseUrl$url'}");
    log("Parameters: $params");

    try {
      if (showLoading) {
        await EasyLoading.show();
      }
      log(
        'FormData.fromMap(params)FormData.fromMap(params) ::${FormData.fromMap(params).fields}',
      );
      final response = await dio.post(
        '$baseUrl$url',

        data: isFormData ? FormData.fromMap(params) : params,
        options: Options(headers: await _buildHeaders()),
      );

      log("Status Code: ${response.statusCode}");
      log("Response Data: ${response.data}");

      if (response.data['success'] == true && response.data != null) {
        await EasyLoading.dismiss();

        if (showSuccessMessage) {
          // Show success message

          customSuccessToast(
            context,
            text: response.data['message'] ?? 'Success',
          );
        }
        return response;
      } else {
        // If status code is not 200/201, still return response (or handle error)
        return response;
      }
    } on DioException catch (e) {
      _handleDioError(context, e, loginEndPoint: url);
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
        '$baseUrl$url',
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

  /// Handles Dio errors uniformly across all methods
  void _handleDioError(
    BuildContext context,
    DioException e, {
    String loginEndPoint = '',
  }) async {
    log('loginEndPoint ::$loginEndPoint');
    await EasyLoading.dismiss();
    final statusCode = e.response?.statusCode;
    final responseData = e.response?.data;

    log("DioException: $responseData, Status Code: $statusCode");

    // Handle 401 Unauthorized
    if (statusCode == 401 &&
        loginEndPoint != AppApi.checkMember &&
        loginEndPoint != AppApi.verifyOtp) {
      await dataSaver.setAuthToken('');
      Navigator.pushNamedAndRemoveUntil(
        context,
        AppPage.authScreen,
        (route) => false,
      );
      return;
    }

    // Extract Validation Errors
    String errorMessage = 'Something went wrong';

    if (responseData != null) {
      if (responseData['data'] != null && responseData['data'] is Map) {
        final dataErrors = responseData['data'] as Map<String, dynamic>;
        List<String> errorMessages = [];

        dataErrors.forEach((key, value) {
          if (value is List) {
            errorMessages.addAll(value.map((e) => e.toString()));
          }
        });

        if (errorMessages.isNotEmpty) {
          errorMessage = errorMessages.join('\n');
        } else if (responseData['message'] != null) {
          errorMessage = responseData['message'];
        }
      } else if (responseData['message'] != null) {
        errorMessage = responseData['message'];
      }
    }

    // Show Toast or SnackBar

    customErrorToast(context, text: errorMessage);
  }
}
