import 'package:svt_ppm/module/auth/model/login_model.dart';

class SignupArgs {
  final bool old;
  final String language;

  SignupArgs({this.old = false, this.language = 'en'});
}

class AddMemberArgs {
  final bool old;
  final bool addMember;
  final bool edit;
  final LoginModel? member;

  AddMemberArgs({
    this.old = false,
    this.addMember = false,
    this.edit = false,
    this.member,
  });
}
