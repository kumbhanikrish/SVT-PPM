import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:svt_ppm/module/app_features/model/schemas_registration_model.dart';
import 'package:svt_ppm/module/app_features/repo/schemas_repo.dart';

part 'role_schemas_registration_state.dart';

class RoleSchemasRegistrationCubit extends Cubit<RoleSchemasRegistrationState> {
  RoleSchemasRegistrationCubit() : super(RoleSchemasRegistrationInitial());
  SchemasRepo schemasRepo = SchemasRepo();
  List<SchemasRegistrationModel> schemasRegistrationList = [];
  roleSchemasRegistration(BuildContext context) async {
    Response response = await schemasRepo.roleSchemasRegistration(context);
    if (response.data['success'] == true) {
      final data = response.data['data'];
      schemasRegistrationList =
          (data as List)
              .map((e) => SchemasRegistrationModel.fromJson(e))
              .toList();
    }

    emit(
      SchemasRegistrationState(
        schemasRegistrationList: schemasRegistrationList,
      ),
    );
  }

  schemasRegistrationChangeStatus(
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
    Response response = await schemasRepo.schemasRegistrationChangeStatus(
      context,
      params: params,
    );
    if (response.data['success'] == true) {
      if (state is SchemasRegistrationState) {
        schemasRegistrationList =
            (state as SchemasRegistrationState).schemasRegistrationList;
      }

      for (final registration in schemasRegistrationList) {
        for (final schema in registration.schemas) {
          for (final item in schema.items) {
            if (item.id.toString() == registrationId) {
              item.villagePresidentStatus = status;
              item.remarks = remarks;
            }
          }
        }
      }
      emit(SchemasRegistrationChangeStatusSuccessState());
      emit(
        SchemasRegistrationState(
          schemasRegistrationList: schemasRegistrationList,
        ),
      );
    } else {
      emit(SchemasRegistrationChangeStatusSuccessFiledState());
    }
  }
}
