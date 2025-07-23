import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:svt_ppm/module/app_features/model/schemas_model.dart';
import 'package:svt_ppm/module/app_features/repo/schemas_repo.dart';

part 'schemas_state.dart';

class SchemasCubit extends Cubit<SchemasState> {
  SchemasCubit() : super(SchemasInitial());

  SchemasRepo schemasRepo = SchemasRepo();

  List<SchemasModel> schemasModel = [];

  getSchemasData(BuildContext context) async {
    Response response = await schemasRepo.getSchemasData(context);
    if (response.data['success'] == true) {
      final data = response.data['data'];
      schemasModel =
          (data as List).map((e) => SchemasModel.fromJson(e)).toList();
    }

    emit(GetSchemasState(schemasModel: schemasModel));
  }
}
