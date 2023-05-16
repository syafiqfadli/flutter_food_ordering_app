import 'package:flutter_food_ordering_app/src/entities/entities.dart';

class MenuModel extends MenuEntity {
  const MenuModel({
    required super.menuId,
    required super.menu,
    required super.price,
    required super.quantity,
    required super.totalPrice,
  });

  factory MenuModel.fromJson(Map<String, dynamic> parseJson) {
    return MenuModel(
      menuId: parseJson["menuId"],
      menu: parseJson["menu"],
      price: parseJson["price"],
      quantity: parseJson["quantity"],
      totalPrice: parseJson["totalPrice"],
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
