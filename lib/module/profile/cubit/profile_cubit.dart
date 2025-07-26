import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:svt_ppm/module/home/cubit/home_cubit.dart';
import 'package:svt_ppm/module/profile/repo/profile_repo.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit() : super(ProfileInitial());

  ProfileRepo profileRepo = ProfileRepo();

  Future<Response> addMemberFamily(
    BuildContext context, {
    required String photo,
    required String firstName,
    required String middleName,
    required String lastName,
    required String mobileNo,

    required String address,
    required String gender,
    required String email,
    required String relation,
    required String standard,
    String? oldMemberId,
    String? oldMemberIdCard,
    String? idProofFront,
    String? idProofBack,

    required bool old,
  }) async {
    Map<String, dynamic> params = {
      "first_name": firstName,
      "middle_name": middleName,
      "last_name": lastName,
      "mobile_no": mobileNo,

      "gender": gender,
      "email": email,
      "address": address,
      "relation": relation,
      "standard": standard,
      "is_new_member": old ? 0 : 1,
    };
    HomeCubit homeCubit = BlocProvider.of<HomeCubit>(context);
    if (old) {
      // ✅ Only include if valid
      if (oldMemberId != null && oldMemberId.isNotEmpty) {
        params["old_member_id"] = oldMemberId;
      }

      if (oldMemberIdCard != null &&
          oldMemberIdCard.isNotEmpty &&
          !oldMemberIdCard.startsWith('http')) {
        params["old_member_id_card"] = await MultipartFile.fromFile(
          oldMemberIdCard,
          filename: oldMemberIdCard.split('/').last,
        );
      }
    } else {
      // New Member Files
      if (idProofFront != null &&
          idProofFront.isNotEmpty &&
          !idProofFront.startsWith('http')) {
        params["id_proof_front"] = await MultipartFile.fromFile(
          idProofFront,
          filename: idProofFront.split('/').last,
        );
      }

      if (idProofBack != null &&
          idProofBack.isNotEmpty &&
          !idProofBack.startsWith('http')) {
        params["id_proof_back"] = await MultipartFile.fromFile(
          idProofBack,
          filename: idProofBack.split('/').last,
        );
      }
    }

    if (photo.isNotEmpty && !photo.startsWith('http')) {
      params["photo"] = await MultipartFile.fromFile(
        photo,
        filename: photo.split('/').last,
      );
    }

    final Response response = await profileRepo.addMemberFamily(
      context,
      data: params,
    );

    if (response.data['success'] == true) {
      homeCubit.memberFamily(context, pageName: 'profile');
      Navigator.pop(context);
      Navigator.pop(context);
    }

    return response;
  }
}

class SelectRelationCubit extends Cubit<String> {
  SelectRelationCubit() : super('daughter');

  updateValue({required String relationValue}) {
    emit(relationValue);
  }

  init() {
    emit('daughter');
  }
}

class SelectStandardCubit extends Cubit<String> {
  SelectStandardCubit() : super('playgroup');

  updateValue({required String standardValue}) {
    emit(standardValue);
  }

  init() {
    emit('playgroup');
  }
}
