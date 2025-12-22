import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:svt_ppm/module/data_entry/repository/data_entry_repository.dart';
import 'package:svt_ppm/utils/widgets/custom_error_toast.dart';
import 'package:svt_ppm/utils/widgets/custom_success_dialog.dart';

part 'data_entry_state.dart';

class DataEntryCubit extends Cubit<DataEntryState> {
  DataEntryCubit() : super(DataEntryInitial());

  DataEntryRepository dataEntryRepository = DataEntryRepository();
  int extraEntry = 0;
  int totalMember = 0;

  Future<Response> totalGetEntry(BuildContext context) async {
    Response response = await dataEntryRepository.totalGetEntry(context);

    if (response.data['success'] == true) {
      totalMember = response.data['data'];

      emit(DataEntryLoaded(totalMember: totalMember));
    }

    return response;
  }

  Future<Response> getExtraEntry(BuildContext context) async {
    Response response = await dataEntryRepository.getExtraEntry(context);

    if (response.data['success'] == true) {
      extraEntry = response.data['data'];

      emit(DataEntryLoaded(totalMember: extraEntry));
      showCustomDialog(
        context,
        title: 'Success',
        subTitle: 'Data added successfully',
        buttonText: 'OK',
      );
    }

    return response;
  }

  Future<Response> getEntry(
    BuildContext context, {
    required String sNumber,
    required MobileScannerController scannerController,
  }) async {
    Map<String, dynamic> body = {"s_number": sNumber};
    Response response = await dataEntryRepository.getEntry(context, body: body);

    if (response.data['success'] == true) {
      extraEntry = response.data['data'] == [] ? 0 : response.data['data'];

      emit(DataEntryLoaded(totalMember: extraEntry));
      showCustomDialog(
        context,
        title: 'Success',
        subTitle: response.data['message'] ?? 'Data added successfully',
        buttonText: 'OK',
        onTap: () async {
          await scannerController.start();
          Navigator.of(context).pop();
        },
      );
    }

    return response;
  }
}

class ChangeBorder2Cubit extends Cubit<ChangeBorder2State> {
  ChangeBorder2Cubit() : super(ChangeBorder2Initial());

  changeBorderValue({required String changeLetters}) {
    emit(ChangeBorder2Loaded(changeLetters: changeLetters));
  }

  init() {
    emit(ChangeBorder2Loaded(changeLetters: ''));
  }
}
