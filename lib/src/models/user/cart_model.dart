import 'package:flutter_food_ordering_app/src/entities/user/user.dart';

class CartModel extends CartEntity {
  const CartModel({
    required super.cartId,
    required super.menu,
    required super.price,
    required super.quantity,
  });

  factory CartModel.fromJson(Map<String, dynamic> parseJson) {
    return CartModel(
      cartId: parseJson["cartId"],
      menu: parseJson["activimenutyId"],
      price: parseJson["price"],
      quantity: parseJson["quantity"],
    );
  }

  static List<CartModel> fromList(List<dynamic> parseJson) {
    List<CartModel> result = [];

    for (var data in parseJson) {
      result.add(CartModel.fromJson(data));
    }

    return result;
  }
}
