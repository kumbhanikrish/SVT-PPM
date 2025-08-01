import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:svt_ppm/main.dart';
import 'package:svt_ppm/module/auth/model/login_model.dart';
import 'package:svt_ppm/module/home/cubit/home_cubit.dart';
import 'package:svt_ppm/module/profile/repo/profile_repo.dart';
import 'package:svt_ppm/utils/constant/app_page.dart';
import 'package:svt_ppm/utils/widgets/custom_success_dialog.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit() : super(ProfileInitial());

  ProfileRepo profileRepo = ProfileRepo();

  Future<Response> addMemberFamily(
    BuildContext context, {
    required String photo,
    required String firstName,
    bool? editProfile,
    required String middleName,
    required String lastName,
    required String mobileNo,

    required String address,
    required String gender,
    required String email,
    String? relation,
    String? standard,
    String? villageName,
    required int memberId,
    required bool edit,
    String? oldMemberId,
    String? oldMemberIdCard,
    String? idProofFront,
    String? idProofBack,

    bool? old,
  }) async {

    
    Map<String, dynamic> params = {
      "first_name": firstName,
      "middle_name": middleName,
      "last_name": lastName,
      "mobile_no": mobileNo,
      'village_name': villageName,
      "gender": gender,
      "email": email,
      "address": address,
      "relation": relation,
      "standard": standard,
      "is_new_member": (old ?? false) ? 0 : 1,
    };
    HomeCubit homeCubit = BlocProvider.of<HomeCubit>(context);
    if (old == true) {
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
      } else if (idProofFront != null &&
          idProofFront.isNotEmpty &&
          idProofFront.startsWith('http')) {
        params["id_proof_front"] = idProofFront;
      }

      if (idProofBack != null &&
          idProofBack.isNotEmpty &&
          !idProofBack.startsWith('http')) {
        params["id_proof_back"] = await MultipartFile.fromFile(
          idProofBack,
          filename: idProofBack.split('/').last,
        );
      } else if (idProofBack != null &&
          idProofBack.isNotEmpty &&
          idProofBack.startsWith('http')) {
        params["id_proof_back"] = idProofBack;
      }
    }

    if (photo.isNotEmpty && !photo.startsWith('http')) {
      params["photo"] = await MultipartFile.fromFile(
        photo,
        filename: photo.split('/').last,
      );
    } else if (photo.isNotEmpty && photo.startsWith('http')) {
      params["photo"] = photo;
    }

    final Response response = await profileRepo.addMemberFamily(
      context,
      data: params,
      memberId: edit ? '/$memberId' : '',
    );

    if (response.data['success'] == true) {
      if (editProfile == true) {
        LoginModel loginModel = LoginModel.fromJson(response.data['data']);
        await localDataSaver.setLoginData(loginModel);

        Navigator.pushNamedAndRemoveUntil(
          context,
          AppPage.profileScreen,
          (route) => false,
        );

        showCustomDialog(
          context,
          title: 'Success',
          subTitle: 'Profile Edit successfully',
          buttonText: 'OK',
        );
      } else {
        homeCubit.memberFamily(context, pageName: 'profile');

        if (edit) {
          Navigator.pop(context);
        } else {
          Navigator.pop(context);
          Navigator.pop(context);
        }
        showCustomDialog(
          context,
          title: 'Success',
          subTitle:
              edit ? 'Edit Member Successfully' : 'Member added successfully',
          buttonText: 'OK',
        );
      }
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
