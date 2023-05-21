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

  static String serverStatus = "$baseUrl/server/status";
  static String createUser = "$baseUrl/user/create";
  static String userInfo = "$baseUrl/user/info";
  static String checkoutOrder = "$baseUrl/user/checkout-order";
  static String addToCart = "$baseUrl/user/add-to-cart";
  static String deleteCart = "$baseUrl/user/delete-cart";
  static String deleteMenu = "$baseUrl/user/delete-menu";
  static String adminInfo = "$baseUrl/admin/info";
  static String createAdmin = "$baseUrl/admin/create";
  static String searchRestaurant = "$baseUrl/admin/search-restaurant";
  static String restaurantList = "$baseUrl/admin/restaurant-list";
}
