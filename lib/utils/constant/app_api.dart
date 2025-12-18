class AppApi {
  /// Auth Flow
  static String checkMember = 'auth/check-member';
  static String sendOtp = 'auth/send-otp';
  static String verifyOtp = 'auth/verify-otp';
  static String register = 'auth/register';
  static String logout = 'auth/logout';
  static String village = 'village';

  /// Home Flow
  static String home = 'home';
  static String memberFamily = 'member-family';
  static String eventsRegistration = 'events-registration';

  /// Schema Flow
  static String schema = 'schemas';
  static String villagePresident = 'village-president';
  static String schemasRegistration = 'schemas-registration';
  static String schemasRegistrationChangeStatus = 'schemas-registration-change-status';

  /// Kit Flow
  static String kits = 'kits';
  static String kitsRegistration = 'kits-registration';

  /// Community Flow
  static String communityMembers = 'community-members';

  /// Exam Flow
  static String exam = 'user-exams';
  static String examsRegistration = 'exams-registration';
}
