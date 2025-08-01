import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:svt_ppm/main.dart';
import 'package:svt_ppm/module/auth/model/login_model.dart';
import 'package:svt_ppm/module/auth/model/village_model.dart';
import 'package:svt_ppm/module/auth/repo/auth_repo.dart';
import 'package:svt_ppm/services/api_services.dart';
import 'package:svt_ppm/utils/constant/app_page.dart';
import 'package:svt_ppm/utils/enum/enums.dart';
import 'package:svt_ppm/utils/widgets/custom_error_toast.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());

  AuthRepo authRepo = AuthRepo();

  Future<Response> checkMember(
    BuildContext context, {
    required String number,
  }) async {
    // await messaging.requestPermission();

    Map<String, dynamic> loginParams = {"mobile_no": number};

    final Response response = await authRepo.checkMember(
      context,
      params: loginParams,
    );

    if (response.data['success'] == true) {
      if (response.data['data']['is_member'] == true) {
        sendOtp(context, number: number, login: true);
      } else {
        customErrorToast(context, text: response.data['message']);
      }
    }

    return response;
  }

  Future<Response> sendOtp(
    BuildContext context, {
    required String number,
    required bool login,
  }) async {
    // await messaging.requestPermission();
    StepperCubit stepperCubit = BlocProvider.of<StepperCubit>(context);

    Map<String, dynamic> loginParams = {"mobile_no": number};

    final Response response = await authRepo.sendOtp(
      context,
      params: loginParams,
    );

    if (response.data['success'] == true) {
      await localDataSaver.setVerificationId(
        response.data['data'].isNotEmpty ? response.data['data'] : '',
      );

      if (login) {
        stepperCubit.nextStep(step: 1);
      }
    }
    return response;
  }

  Future<Response> verifyOtp(
    BuildContext context, {
    required String number,
    required String otp,
  }) async {
    // await messaging.requestPermission();

    String verificationId = await dataSaver.getVerificationId();

    Map<String, dynamic> loginParams = {
      "mobile_no": number,
      "otp": otp,
      "data_requested": true,
      'verificationId': verificationId,
    };

    final Response response = await authRepo.verifyOtp(
      context,
      params: loginParams,
    );

    if (response.data['success'] == true) {
      LoginModel loginModel = LoginModel.fromJson(response.data['data']);
      await localDataSaver.setLoginData(loginModel);
      await localDataSaver.setAuthToken(loginModel.token);

      Navigator.pushNamedAndRemoveUntil(
        context,
        AppPage.homeScreen,
        (route) => false,
      );
    }
    return response;
  }

  Future<Response> register(
    BuildContext context, {
    required String photo,
    required String firstName,
    required String middleName,
    required String lastName,
    required String mobileNo,
    required String villageName,
    required String address,
    required String gender,
    required String email,
    String? oldMemberId,
    String? oldMemberIdCard,
    String? idProofFront,
    String? idProofBack,
    required bool old,
  }) async {
    Map<String, dynamic> loginParams = {
      "first_name": firstName,
      "middle_name": middleName,
      "last_name": lastName,
      "mobile_no": mobileNo,
      "village_name": villageName,
      "gender": gender,
      "email": email,
      "address": address,
      "is_new_member": old ? 0 : 1,
    };

    if (old) {
      // ✅ Only include if valid
      if (oldMemberId != null && oldMemberId.isNotEmpty) {
        loginParams["old_member_id"] = oldMemberId;
      }

      if (oldMemberIdCard != null &&
          oldMemberIdCard.isNotEmpty &&
          !oldMemberIdCard.startsWith('http')) {
        loginParams["old_member_id_card"] = await MultipartFile.fromFile(
          oldMemberIdCard,
          filename: oldMemberIdCard.split('/').last,
        );
      }
    } else {
      // New Member Files
      if (idProofFront != null &&
          idProofFront.isNotEmpty &&
          !idProofFront.startsWith('http')) {
        loginParams["id_proof_front"] = await MultipartFile.fromFile(
          idProofFront,
          filename: idProofFront.split('/').last,
        );
      }

      if (idProofBack != null &&
          idProofBack.isNotEmpty &&
          !idProofBack.startsWith('http')) {
        loginParams["id_proof_back"] = await MultipartFile.fromFile(
          idProofBack,
          filename: idProofBack.split('/').last,
        );
      }
    }

    if (photo.isNotEmpty && !photo.startsWith('http')) {
      loginParams["photo"] = await MultipartFile.fromFile(
        photo,
        filename: photo.split('/').last,
      );
    }

    final Response response = await authRepo.register(
      context,
      params: loginParams,
    );

    if (response.data['success'] == true) {
      Navigator.pushNamedAndRemoveUntil(
        context,
        AppPage.authScreen,
        (route) => false,
      );
    }

    return response;
  }

  Future<Response> logout(BuildContext context) async {
    Response response = await authRepo.logout(context, params: {});

    if (response.data['success'] == true) {
      Navigator.pushNamedAndRemoveUntil(
        context,
        AppPage.authScreen,
        (route) => false,
      );
      await localDataSaver.setAuthToken('');
    }

    return response;
  }
}

class StepperCubit extends Cubit<int> {
  StepperCubit() : super(0);

  void nextStep({required int step}) {
    log('step ::$step');
    emit(step);
  }

  void previousStep({required int step}) {
    emit(step);
  }

  void init() {
    emit(0);
  }
}

class ImageUploadCubit extends Cubit<File?> {
  ImageUploadCubit() : super(null);

  final ImagePicker picker = ImagePicker();

  Future<void> pickImage() async {
    final XFile? file = await picker.pickImage(source: ImageSource.gallery);
    if (file != null) {
      emit(File(file.path));
    }
  }

  void removeImage() {
    emit(null);
  }
}

class FrontImageCubit extends Cubit<File?> {
  FrontImageCubit() : super(null);

  final ImagePicker picker = ImagePicker();

  Future<void> pickImage() async {
    final XFile? file = await picker.pickImage(source: ImageSource.gallery);
    if (file != null) {
      emit(File(file.path));
    }
  }

  void removeImage() {
    emit(null);
  }
}

class BackImageCubit extends Cubit<File?> {
  BackImageCubit() : super(null);

  final ImagePicker picker = ImagePicker();

  Future<void> pickImage() async {
    final XFile? file = await picker.pickImage(source: ImageSource.gallery);
    if (file != null) {
      emit(File(file.path));
    }
  }

  void removeImage() {
    emit(null);
  }
}

class ProfileImageCubit extends Cubit<File?> {
  ProfileImageCubit() : super(null);

  final ImagePicker picker = ImagePicker();

  Future<void> pickImage({required ImageSource source}) async {
    final XFile? file = await picker.pickImage(source: source);
    if (file != null) {
      emit(File(file.path));
    }
  }

  void removeImage() {
    emit(null);
  }
}

class RadioCubit extends Cubit<UserType> {
  RadioCubit() : super(UserType.male);

  void selectUserType(UserType type) {
    log('typetype ::$type');
    emit(type);
  }

  init() {
    emit(UserType.male);
  }
}

class VillageCubit extends Cubit<VillageState> {
  VillageCubit() : super(VillageInitial());
  AuthRepo authRepo = AuthRepo();

  Future<void> fetchVillage(BuildContext context) async {
    List<VillageModel> villageList = [];
    String villageName = '';
    final Response response = await authRepo.village(context);
    if (response.data['success'] == true) {
      if (state is VillageLoaded) {
        villageName = (state as VillageLoaded).villageName;
      }

      final data = response.data['data'];

      villageList =
          (data as List).map((e) => VillageModel.fromJson(e)).toList();
    }

    emit(VillageLoaded(villageList: villageList, villageName: villageName));
  }

  void setVillageName({required String name}) {
    if (state is VillageLoaded) {
      final currentState = state as VillageLoaded;
      emit(
        VillageLoaded(villageList: currentState.villageList, villageName: name),
      );
    }
  }
}
