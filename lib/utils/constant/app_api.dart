import 'package:flutter_dotenv/flutter_dotenv.dart';

String baseUrl = dotenv.env['BASE_URL'] ?? 'demo';

class AppApi {
  static String login = '$baseUrl/login';
  static String games = '$baseUrl/games';
  static String logout = '$baseUrl/logout';
  static String register = '$baseUrl/register';
  static String qrCode = '$baseUrl/qr-code';
  static String manageWallet = '$baseUrl/manage-wallet';
  static String wallet = '$baseUrl/wallet';
  static String forgotPassword = '$baseUrl/forgot-password';
  static String profile = '$baseUrl/profile';
  static String result = '$baseUrl/game-result?page=';
  static String changePassword = '$baseUrl/change-password';
  static String sendMessage = '$baseUrl/support/send?message=';
  static String chat = '$baseUrl/support/chat';
  static String userBid = '$baseUrl/user-bid';
  static String sendEmailCode = '$baseUrl/send-email-verification-code';
  static String verifyEmailCode = '$baseUrl/verify-email-code';
  static String homeBanners = '$baseUrl/home-banners';
}
