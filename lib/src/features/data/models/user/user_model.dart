import 'package:order_me/src/features/domain/entities/entities.dart';
import 'package:order_me/src/features/data/models/models.dart';

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
          ? CartModel.fromList(parseJson["cart"]).reversed.toList()
          : <CartModel>[],
      order: parseJson["order"] != null
          ? OrderModel.fromList(parseJson["order"]).reversed.toList()
          : <OrderModel>[],
      history: parseJson["history"] != null
          ? HistoryModel.fromList(parseJson["history"]).reversed.toList()
          : <HistoryModel>[],
    );
  }
}
