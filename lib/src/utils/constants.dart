import 'package:flutter/animation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

abstract class AppColor {
  static const Color primaryColor = Color(0xff4F6367);
  static const Color secondaryColor = Color(0xffB8D8D8);
  static const Color backgroundColor = Color(0xffFFFFFF);
  static const Color textColor = Color(0xff424242);
}

abstract class ApiUrl {
  static String baseUrl = dotenv.get(
    'BASE_URL',
    fallback: '',
  );

  static String createUser = "$baseUrl/user/create";
  static String userInfo = "$baseUrl/user/info";
  // static String getAllUser = "$baseUrl/user/get-all-user";
  // static String addRedemption = "$baseUrl/user/add-redemption-user";
  // static String updateRewards = "$baseUrl/admin/update-reward-admin";
  // static String getAllRewards = "$baseUrl/admin/get-all-rewards";
  // static String deleteUserActivity = "$baseUrl/user/delete-activity-user";
  // static String deleteUserRedemption = "$baseUrl/user/delete-redemption-user";
  // static String sendOtp = "$baseUrl/email/send-email";
}
