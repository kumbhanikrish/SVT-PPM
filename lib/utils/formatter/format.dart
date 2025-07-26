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
