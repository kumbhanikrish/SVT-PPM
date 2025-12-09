import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:svt_ppm/module/data_entry/repository/data_entry_repository.dart';
import 'package:svt_ppm/utils/widgets/custom_error_toast.dart';

part 'data_entry_state.dart';

class DataEntryCubit extends Cubit<DataEntryState> {
  DataEntryCubit() : super(DataEntryInitial());

  DataEntryRepository dataEntryRepository = DataEntryRepository();

  Future<Response> totalGetEntry(BuildContext context) async {
    int totalMember = 0;  
    Response response = await dataEntryRepository.totalGetEntry(context);

    if (response.statusCode == 200) {
      totalMember = response.data['data'];
    }
    emit(DataEntryLoaded(totalMember: totalMember));

    return response;
  }

  Future<Response> getExtraEntry(BuildContext context) async {
    int extraEntry = 0;
    Response response = await dataEntryRepository.getExtraEntry(context);

    if (response.statusCode == 200) {
      extraEntry = response.data['data'];
      customSuccessToast(context, text: response.data['message']);
      emit(DataEntryLoaded(totalMember: extraEntry));
    }

    return response;
  }

  Future<Response> getEntry(
    BuildContext context, {
    required String sNumber,
  }) async {
    int extraEntry = 0;
    Response response = await dataEntryRepository.getEntry(
      context,
      sNumber: sNumber,
    );

    if (response.statusCode == 200) {
      extraEntry = response.data['data'];
      customSuccessToast(context, text: response.data['message']);

      emit(DataEntryLoaded(totalMember: extraEntry));
    } else {
      customErrorToast(context, text: response.data['message']['s_number'][0]);
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
