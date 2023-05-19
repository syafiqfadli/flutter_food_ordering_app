import 'package:flutter_food_ordering_app/src/features/domain/entities/entities.dart';
import 'package:flutter_food_ordering_app/src/features/data/models/models.dart';

class CartModel extends CartEntity {
  const CartModel({
    required super.cartId,
    required super.restaurantId,
    required super.restaurantName,
    required super.menuList,
  });

  factory CartModel.fromJson(Map<String, dynamic> parseJson) {
    return CartModel(
      cartId: parseJson["cartId"],
      restaurantId: parseJson["restaurantId"],
      restaurantName: parseJson["restaurantName"],
      menuList: parseJson["menuList"] != null
          ? MenuModel.fromList(parseJson["menuList"])
          : <MenuModel>[],
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
