import 'package:flutter_food_ordering_app/src/entities/user/user.dart';
import 'package:flutter_food_ordering_app/src/models/user/user.dart';

class UserModel extends UserEntity {
  const UserModel({
    required super.firebaseId,
    required super.name,
    required super.email,
    required super.cart,
    required super.order,
    required super.history,
  });

  factory UserModel.fromJson(Map<String, dynamic> parseJson) {
    return UserModel(
      firebaseId: parseJson['firebaseId'],
      name: parseJson['name'],
      email: parseJson['email'],
      cart: parseJson["cart"] != null
          ? CartModel.fromList(parseJson["cart"])
          : <CartModel>[],
      order: parseJson["order"] != null
          ? OrderModel.fromList(parseJson["order"])
          : <OrderModel>[],
      history: parseJson["order"] != null
          ? HistoryModel.fromList(parseJson["order"])
          : <HistoryModel>[],
    );
  }
}
