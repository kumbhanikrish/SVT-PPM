import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:svt_ppm/module/app_features/repo/community_repo.dart';

part 'community_state.dart';

class CommunityCubit extends Cubit<CommunityState> {
  CommunityCubit() : super(CommunityInitial());

  CommunityMembersRepo communityMembersRepo = CommunityMembersRepo();

  getCommunityMembers(BuildContext context) async {
    Response response = await communityMembersRepo.communityMembers(context);
    if (response.data['success'] == true) {
      final data = response.data['data'];
      emit(GetCommunityMembersState(communityMembersModel: data));
      return data;
    }
  }
}
