import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:svt_ppm/module/app_features/model/schemes_model.dart';
import 'package:svt_ppm/module/app_features/model/village_president_model.dart';
import 'package:svt_ppm/module/app_features/repo/schemes_repo.dart';
import 'package:svt_ppm/utils/constant/app_page.dart';
import 'package:svt_ppm/utils/widgets/custom_downloader.dart';
import 'package:svt_ppm/utils/widgets/custom_success_dialog.dart';

part 'schemes_state.dart';

class SchemesCubit extends Cubit<SchemesState> {
  SchemesCubit() : super(SchemesInitial());
  SchemesRepo schemesRepo = SchemesRepo();

  List<SchemesModel> schemesModel = [];
  List<VillagePresidentModel> villagePresidentList = [];

  getSchemesData(BuildContext context) async {
    Response response = await schemesRepo.getSchemesData(context);
    if (response.data['success'] == true) {
      if (state is GetSchemesState) {
        villagePresidentList = (state as GetSchemesState).villagePresidentList;
      }
      final data = response.data['data'];
      schemesModel =
          (data as List).map((e) => SchemesModel.fromJson(e)).toList();
    }

    emit(
      GetSchemesState(
        schemesModel: schemesModel,
        villagePresidentList: villagePresidentList,
      ),
    );
  }

  villagePresident(BuildContext context) async {
    Response response = await schemesRepo.villagePresident(context);

    if (response.data['success'] == true) {
      if (state is GetSchemesState) {
        schemesModel = (state as GetSchemesState).schemesModel;
      }
      final data = response.data['data'];
      villagePresidentList =
          (data as List).map((e) => VillagePresidentModel.fromJson(e)).toList();
    }

    emit(
      GetSchemesState(
        schemesModel: schemesModel,
        villagePresidentList: villagePresidentList,
      ),
    );
  }

  schemesRegistration(
    BuildContext context, {
    required Map<String, dynamic> params,
  }) async {
    log('paramsparams ::$params');
    Response response = await schemesRepo.schemesRegistration(
      context,
      params: params,
    );

    if (response.data['success'] == true) {
      if (state is GetSchemesState) {
        schemesModel = (state as GetSchemesState).schemesModel;
        villagePresidentList = (state as GetSchemesState).villagePresidentList;
      }

      for (var i = 0; i < schemesModel.length; i++) {
        if (schemesModel[i].id == params['scheme_id']) {
          log(
            'schemesCubit.getSchemesData(context); ::${schemesModel[i].isApplied}',
          );
          schemesModel[i].isApplied = true;
        }
      }
      Navigator.popUntil(
        context,
        ModalRoute.withName(AppPage.appFeatureScreen),
      );
      showCustomDialog(
        context,
        buttonText: 'Download PDF',
        title: 'Register',
        subTitle: 'Schemes Registration Successfully',

        onTap: () {
          generateAndDownloadPdf(
            title: response.data['data']['title'],
            content: response.data['data']['pdf_template'],
          );
        },
      );
      emit(
        GetSchemesState(
          schemesModel: schemesModel,
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
