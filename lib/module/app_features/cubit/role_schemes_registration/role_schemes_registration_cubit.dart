import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:svt_ppm/module/app_features/model/schemes_registration_model.dart';
import 'package:svt_ppm/module/app_features/repo/schemes_repo.dart';

part 'role_schemes_registration_state.dart';

class RoleSchemesRegistrationCubit extends Cubit<RoleSchemesRegistrationState> {
  RoleSchemesRegistrationCubit() : super(RoleSchemesRegistrationInitial());
  SchemesRepo schemesRepo = SchemesRepo();
  List<SchemesRegistrationModel> schemesRegistrationList = [];
  roleSchemesRegistration(BuildContext context) async {
    Response response = await schemesRepo.roleSchemesRegistration(context);
    if (response.data['success'] == true) {
      final data = response.data['data'];
      schemesRegistrationList =
          (data as List)
              .map((e) => SchemesRegistrationModel.fromJson(e))
              .toList();
    }

    emit(
      SchemesRegistrationState(
        schemesRegistrationList: schemesRegistrationList,
      ),
    );
  }

  schemesRegistrationChangeStatus(
    BuildContext context, {
    required String registrationId,
    required String status,
    String remarks = '',
  }) async {
    Map<String, dynamic> params = {
      "registration_id": registrationId,
      "status": status,
      "remarks": remarks,
    };
    Response response = await schemesRepo.schemesRegistrationChangeStatus(
      context,
      params: params,
    );
    if (response.data['success'] == true) {
      if (state is SchemesRegistrationState) {
        schemesRegistrationList =
            (state as SchemesRegistrationState).schemesRegistrationList;
      }

      for (final registration in schemesRegistrationList) {
        for (final scheme in registration.schemes) {
          for (final item in scheme.items) {
            if (item.id.toString() == registrationId) {
              item.villagePresidentStatus = status;
              item.remarks = remarks;
            }
          }
        }
      }
      emit(SchemesRegistrationChangeStatusSuccessState());
      emit(
        SchemesRegistrationState(
          schemesRegistrationList: schemesRegistrationList,
        ),
      );
    } else {
      emit(SchemesRegistrationChangeStatusSuccessFiledState());
    }
  }
}
