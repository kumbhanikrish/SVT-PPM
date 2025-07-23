class AppApi {
  /// Auth Flow
  static String checkMember = 'auth/check-member';
  static String sendOtp = 'auth/send-otp';
  static String verifyOtp = 'auth/verify-otp';
  static String register = 'auth/register';
  static String logout = 'auth/logout';

  /// Home Flow
  static String home = 'home';
  static String memberFamily = 'member-family';
  static String eventsRegistration = 'events-registration';

  /// Schema Flow
  static String schema = 'schemas';

  /// Kit Flow
  static String kits = 'kits';
  static String kitsRegistration = 'kits-registration';

  /// Community Flow
  static String communityMembers = 'community-members';
}
