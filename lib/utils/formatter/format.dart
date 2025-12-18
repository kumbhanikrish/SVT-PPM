import 'dart:developer';

import 'package:intl/intl.dart';
import 'package:svt_ppm/main.dart';
import 'package:svt_ppm/module/auth/model/login_model.dart';
import 'package:svt_ppm/utils/enum/enums.dart';

String capitalize(String? value) {
  if (value == null || value.isEmpty) return '';
  return value[0].toUpperCase() + value.substring(1);
}

UserType? userTypeFromString(String? gender) {
  switch (gender?.toLowerCase()) {
    case 'male':
      return UserType.male;
    case 'female':
      return UserType.female;
    default:
      return null;
  }
}

String formatTitle(String key) {
  return key
      .replaceAll('_', ' ') // snake_case to words
      .replaceAllMapped(
        RegExp(r'(^\w|\s\w)'),
        (match) => match.group(0)!.toUpperCase(),
      ); // Capitalize first letter of each word
}

String getCurrentTimeIn12HourFormat() {
  final now = DateTime.now();
  final format = DateFormat('h:mma'); // e.g., 2:35PM
  return format.format(now).toLowerCase(); // optional toLowerCase
}

String getCurrentDateFormat() {
  final now = DateTime.now();
  final format = DateFormat('yyyy-MM-dd');
  return format.format(now).toLowerCase();
}

String formatTo12Hour({String? time24h}) {
  final inputFormat = DateFormat("HH:mm:ss");
  final outputFormat = DateFormat("HH:mm a");

  // Use current time if input is null
  final dateTime =
      time24h != null ? inputFormat.parse(time24h) : DateTime.now();

  return outputFormat.format(dateTime).toUpperCase();
}

class UserSession {
  static LoginModel? loginModel;

  static Future<void> load() async {
    loginModel = await localDataSaver.getLoginModel();

    log('loginModel ::${loginModel?.roles.map((e) => e.name).toList()}');
  }

  static bool hasRole(int roleId) {
    return loginModel?.roles.any((r) => r.id == roleId) ?? false;
  }

  static bool hasAnyRole(List<int> roleIds) {
    return loginModel?.roles.any((r) => roleIds.contains(r.id)) ?? false;
  }
}
