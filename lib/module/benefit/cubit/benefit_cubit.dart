import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:svt_ppm/module/benefit/repo/benefit_repo.dart';

part 'benefit_state.dart';

class BenefitCubit extends Cubit<BenefitState> {
  BenefitCubit() : super(BenefitInitial());

  BenefitRepo benefitRepo = BenefitRepo();

  getBenefitData(BuildContext context) async {
    emit(BenefitLoading());
    Response response = await benefitRepo.getBenefitData(context);
    if (response.data['success'] == true) {
      final Map<String, dynamic> data = response.data['data'];
      emit(GetBenefitState(benefitData: data));
      return data;
    }
  }

  init() {
    emit(BenefitInitial());
  }
}
