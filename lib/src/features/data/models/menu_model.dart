import 'package:flutter_food_ordering_app/src/features/domain/entities/entities.dart';

class MenuModel extends MenuEntity {
  const MenuModel({
    required super.menuId,
    required super.menuName,
    required super.price,
    required super.quantity,
    required super.totalPrice,
  });

  factory MenuModel.fromJson(Map<String, dynamic> parseJson) {
    return MenuModel(
      menuId: parseJson["menuId"],
      menuName: parseJson["menuName"],
      price: parseJson["price"],
      quantity: parseJson["quantity"] ?? 0,
      totalPrice: double.parse(parseJson["totalPrice"] ?? "0.0"),
    );
  }

  static List<MenuModel> fromList(List<dynamic> parseJson) {
    List<MenuModel> result = [];

    for (var data in parseJson) {
      result.add(MenuModel.fromJson(data));
    }

    return result;
  }
}
