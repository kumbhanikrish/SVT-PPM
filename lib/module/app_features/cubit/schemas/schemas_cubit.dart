import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:svt_ppm/module/app_features/model/schemas_model.dart';
import 'package:svt_ppm/module/app_features/model/village_president_model.dart';
import 'package:svt_ppm/module/app_features/repo/schemas_repo.dart';
import 'package:svt_ppm/utils/widgets/custom_downloader.dart';
import 'package:svt_ppm/utils/widgets/custom_success_dialog.dart';

part 'schemas_state.dart';

class SchemasCubit extends Cubit<SchemasState> {
  SchemasCubit() : super(SchemasInitial());
  SchemasRepo schemasRepo = SchemasRepo();

  List<SchemasModel> schemasModel = [];
  List<VillagePresidentModel> villagePresidentList = [];

  getSchemasData(BuildContext context) async {
    Response response = await schemasRepo.getSchemasData(context);
    if (response.data['success'] == true) {
      if (state is GetSchemasState) {
        villagePresidentList = (state as GetSchemasState).villagePresidentList;
      }
      final data = response.data['data'];
      schemasModel =
          (data as List).map((e) => SchemasModel.fromJson(e)).toList();
    }

    emit(
      GetSchemasState(
        schemasModel: schemasModel,
        villagePresidentList: villagePresidentList,
      ),
    );
  }

  villagePresident(BuildContext context) async {
    Response response = await schemasRepo.villagePresident(context);

    if (response.data['success'] == true) {
      if (state is GetSchemasState) {
        schemasModel = (state as GetSchemasState).schemasModel;
      }
      final data = response.data['data'];
      villagePresidentList =
          (data as List).map((e) => VillagePresidentModel.fromJson(e)).toList();
    }

    emit(
      GetSchemasState(
        schemasModel: schemasModel,
        villagePresidentList: villagePresidentList,
      ),
    );
  }

  schemasRegistration(
    BuildContext context, {
    required Map<String, dynamic> params,
  }) async {
    log('paramsparams ::$params');
    Response response = await schemasRepo.schemasRegistration(
      context,
      params: params,
    );

    if (response.data['success'] == true) {
      if (state is GetSchemasState) {
        schemasModel = (state as GetSchemasState).schemasModel;
        villagePresidentList = (state as GetSchemasState).villagePresidentList;
      }

      for (var i = 0; i < schemasModel.length; i++) {
        if (schemasModel[i].id == params['schema_id']) {
          schemasModel[i].isApplied = true;
        }
      }
      Navigator.pop(context);
      Navigator.pop(context);
      Navigator.pop(context);
      showCustomDialog(
        context,
        buttonText: 'Download PDF',
        title: 'Register',
        subTitle: 'Schemas Registration Successfully',
        onTap: () {
          generateAndDownloadPdf(
            title: response.data['data']['title'],
            content: response.data['data']['template'],
          );
        },
      );
      emit(
        GetSchemasState(
          schemasModel: schemasModel,
          villagePresidentList: villagePresidentList,
        ),
      );
    }
  }
}

class SelectMemberCubit extends Cubit<MemberSelectState> {
  SelectMemberCubit() : super(MemberSelectInitial());

  Set<int> selectedMemberIds = {};

  void toggleMemberSelection(
    int memberId, {
    bool single = false,
    bool value = false,
  }) {
    if (single) {
      selectedMemberIds = {memberId};
    } else {
      if (selectedMemberIds.contains(memberId)) {
        selectedMemberIds.remove(memberId);
      } else {
        selectedMemberIds.add(memberId);
      }
    }
    emit(MemberSelectionChanged(selectedMemberIds));
  }

  void init() {
    emit(MemberSelectionChanged({}));
  }
}
