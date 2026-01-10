import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:svt_ppm/module/app_features/repo/kits_repo.dart';
import 'package:svt_ppm/utils/widgets/custom_success_dialog.dart';

part 'kits_state.dart';

class KitsCubit extends Cubit<KitsState> {
  KitsCubit() : super(KitsInitial());

  KitsRepo kitsRepo = KitsRepo();

  getKitsData(BuildContext context) async {
    Response response = await kitsRepo.getKitsData(context);
    if (response.data['success'] == true) {
      final data = response.data['data'];

      emit(GetKitsState(kitData: data));
      return data;
    }
  }

  Future<Response> kitsRegistration(
    BuildContext context, {
    required int memberId,
    String? photo,
  }) async {
    Map<String, dynamic> params = {'member_id': memberId.toString()};

    if (photo != null && photo.isNotEmpty && !photo.startsWith('http')) {
      params["photo"] = await MultipartFile.fromFile(
        photo,
        filename: photo.split('/').last,
      );
    }
    Response response = await kitsRepo.kitsRegistration(
      context,
      params: params,
    );

    if (response.data['success'] == true) {
      Navigator.pop(context);
      getKitsData(context);

      showCustomDialog(
        context,
        title: 'Success',
        subTitle: 'Kits Registered Successfully',
        buttonText: 'OK',
      );
    }
    return response;
  }

  Future<Response> kitsRegistrationStatus(
    BuildContext context, {
    required String sNumber,
    required String type,
    required MobileScannerController scannerController,
    String? photo,
  }) async {
    Map<String, dynamic> params = {'s_number': sNumber, 'type': type};
    await scannerController.start();
    Response response = await kitsRepo.kitsRegistrationStatus(
      context,
      params: params,
    );

    if (response.data['success'] == true) {
      showCustomDialog(
        context,
        title: 'Success',
        subTitle: response.data['message'] ?? 'Data added successfully',
        buttonText: 'OK',
        cancelOnTap: () async {
          await scannerController.start();
          Navigator.of(context).pop();
        },
        onTap: () async {
          await scannerController.start();
          Navigator.of(context).pop();
        },
      );
    }
    return response;
  }

  init() {
    emit(GetKitsState(kitData: {}));
  }
}
