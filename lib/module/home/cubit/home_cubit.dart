import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:svt_ppm/module/auth/model/login_model.dart';
import 'package:svt_ppm/module/home/model/home_model.dart';
import 'package:svt_ppm/module/home/repo/home_repo.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());
  HomeModel homeModel = HomeModel(broadcasts: [], events: []);

  List<LoginModel> noOfMemberList = [];

  HomeRepo homeRepo = HomeRepo();

  getHomeData(BuildContext context) async {
    Response response = await homeRepo.getHomeData(context);

    if (state is GetHomeState) {
      noOfMemberList = (state as GetHomeState).noOfMemberList;
    }

    if (response.data['success'] == true) {
      final data = response.data['data'];

      homeModel = HomeModel.fromJson(data);
    }

    emit(GetHomeState(homeModel: homeModel, noOfMemberList: noOfMemberList));
  }

  memberFamily(BuildContext context) async {
    Response response = await homeRepo.getMemberFamily(context);
    if (state is GetHomeState) {
      homeModel = (state as GetHomeState).homeModel;
    }
    if (response.data['success'] == true) {
      final data = response.data['data'];

      noOfMemberList =
          (data as List).map((e) => LoginModel.fromJson(e)).toList();
    }

    emit(GetHomeState(homeModel: homeModel, noOfMemberList: noOfMemberList));
  }

  eventsRegistration(
    BuildContext context, {
    required int eventId,
    required List<int> memberIds,
    required int extraMember,
  }) async {
    Map<String, dynamic> params = {
      "event_id": eventId,
      "member_ids": memberIds,
      "extra_member": extraMember,
    };
    Response response = await homeRepo.eventsRegistration(
      context,
      params: params,
    );

    if (response.data['success'] == true) {
      Navigator.pop(context);
      return response;
    }
  }
}
