import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:svt_ppm/main.dart';
import 'package:svt_ppm/module/auth/model/login_model.dart';
import 'package:svt_ppm/module/home/cubit/home_cubit.dart';
import 'package:svt_ppm/module/profile/repo/profile_repo.dart';
import 'package:svt_ppm/utils/constant/app_page.dart';
import 'package:svt_ppm/utils/widgets/custom_error_toast.dart';
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
    String? occupation,
    required bool edit,
    String? oldMemberId,
    String? oldMemberIdCard,
    String? idProofFront,
    String? idProofBack,
    bool? old,
  }) async {
    // ---------------------------------------------------
    // VALIDATIONS
    // ---------------------------------------------------

    // Photo required
    if (photo.isEmpty) {
      return customErrorToast(context, text: "Please upload photo");
    }
    if (firstName.isEmpty) {
      return customErrorToast(context, text: "Please enter first name");
    }
    if (middleName.isEmpty) {
      return customErrorToast(context, text: "Please enter middle name");
    }

    if (lastName.isEmpty) {
      return customErrorToast(context, text: "Please enter last name");
    }

    if (mobileNo.isNotEmpty && mobileNo.length != 10) {
      return customErrorToast(
        context,
        text: "Please enter valid 10-digit mobile number",
      );
    }
    // Email validation
    if (email.isNotEmpty &&
        !RegExp(r"^[\w\-.]+@([\w-]+\.)+[\w-]{2,4}$").hasMatch(email)) {
      return customErrorToast(context, text: "Please enter valid email");
    }
    if (gender.isEmpty) {
      return customErrorToast(context, text: "Please select gender");
    }
    if (relation == null || relation.isEmpty) {
      return customErrorToast(context, text: "Please select relation");
    }
    if (standard == null || standard.isEmpty) {
      return customErrorToast(context, text: "Please select standard");
    }
    if ((occupation ?? '').isEmpty) {
      return customErrorToast(context, text: "Please select occupation");
    }

    // Old Member Validation
    if (old == true) {
      if (oldMemberId == null || oldMemberId.isEmpty) {
        return customErrorToast(context, text: "Please enter Old Member ID");
      }

      if (oldMemberIdCard == null || oldMemberIdCard.isEmpty) {
        return customErrorToast(context, text: "Please upload Old Member Card");
      }
    }

    // New Member Validation
    if (old == false || old == null) {
      // if (villageName == null || villageName.isEmpty) {
      //   return customErrorToast(context, text: "Please enter village name");
      // }
      if (idProofFront == null || idProofFront.isEmpty) {
        return customErrorToast(context, text: "Please upload ID Proof Front");
      }

      if (idProofBack == null || idProofBack.isEmpty) {
        return customErrorToast(context, text: "Please upload ID Proof Back");
      }
    }

    // ---------------------------------------------------
    // PARAMS
    // ---------------------------------------------------
    Map<String, dynamic> params = {
      "first_name": firstName,
      "middle_name": middleName,
      "last_name": lastName,
      "mobile_no": mobileNo,
      "village_name": villageName,
      "gender": gender,
      "email": email,
      "address": address,
      "occupation": occupation,
      "relation": relation,
      "standard": standard,
      "is_new_member": (old ?? false) ? 0 : 1,
    };

    HomeCubit homeCubit = BlocProvider.of<HomeCubit>(context);

    // OLD MEMBER FILES
    if (old == true) {
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
      // NEW MEMBER FILES
      if (idProofFront != null &&
          idProofFront.isNotEmpty &&
          !idProofFront.startsWith('http')) {
        params["id_proof_front"] = await MultipartFile.fromFile(
          idProofFront,
          filename: idProofFront.split('/').last,
        );
      } else if (idProofFront != null && idProofFront.startsWith('http')) {
        params["id_proof_front"] = idProofFront;
      }

      if (idProofBack != null &&
          idProofBack.isNotEmpty &&
          !idProofBack.startsWith('http')) {
        params["id_proof_back"] = await MultipartFile.fromFile(
          idProofBack,
          filename: idProofBack.split('/').last,
        );
      } else if (idProofBack != null && idProofBack.startsWith('http')) {
        params["id_proof_back"] = idProofBack;
      }
    }

    // PHOTO
    if (photo.isNotEmpty && !photo.startsWith('http')) {
      params["photo"] = await MultipartFile.fromFile(
        photo,
        filename: photo.split('/').last,
      );
    } else if (photo.startsWith('http')) {
      params["photo"] = photo;
    }

    // ---------------------------------------------------
    // API CALL
    // ---------------------------------------------------
    final Response response = await profileRepo.addMemberFamily(
      context,
      data: params,
      memberId: edit ? '/$memberId' : '',
    );

    // SUCCESS HANDLING
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
          subTitle: 'Profile updated successfully',
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
              edit
                  ? 'Member updated successfully'
                  : 'Member added successfully',
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
