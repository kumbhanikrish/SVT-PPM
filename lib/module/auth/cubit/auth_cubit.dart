import 'dart:developer';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meta/meta.dart';
import 'package:svt_ppm/utils/enum/enums.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());
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

  final ImagePicker _picker = ImagePicker();

  Future<void> pickImage() async {
    final XFile? file = await _picker.pickImage(source: ImageSource.gallery);
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
