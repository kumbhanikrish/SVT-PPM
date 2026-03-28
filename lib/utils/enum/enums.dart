enum UserType { male, female }

UserType? userTypeFromString(String? gender) {
  if (gender == null) return null;
  if (gender.toLowerCase() == 'male') return UserType.male;
  if (gender.toLowerCase() == 'female') return UserType.female;
  return null;
}

String userTypeToString(UserType type) {
  return type == UserType.male ? 'Male' : 'Female';
}

enum StatusType { pending, approved, rejected }

class UserRoles {
  static const int superadmin = 1;
  static const int admin = 2;
  static const int user = 3;
  static const int president = 4;
  static const int vicePresident = 5;
  static const int karobari = 6;
  static const int working = 7;
  static const int villagePresident = 8;
  static const int yuvaKarobari = 9;
  static const int yuvaWorking = 10;
  static const int yuvaYoddha = 11;
  static const int getEntry = 12;
  static const int kitPayment = 13;
  static const int kitDistributor = 14;
}
