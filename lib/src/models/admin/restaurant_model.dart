import 'package:flutter_food_ordering_app/src/entities/entities.dart';
import 'package:flutter_food_ordering_app/src/models/models.dart';

class RestaurantModel extends RestaurantEntity {
  const RestaurantModel({
    required super.restaurantId,
    required super.restaurantName,
    required super.menu,
  });

  factory RestaurantModel.fromJson(Map<String, dynamic> parseJson) {
    return RestaurantModel(
      restaurantId: parseJson["restaurantId"],
      restaurantName: parseJson["restaurantName"],
      menu: parseJson["menu"] != null
          ? MenuModel.fromList(parseJson["menu"])
          : <MenuModel>[],
    );
  }

  static List<RestaurantModel> fromList(List<dynamic> parseJson) {
    List<RestaurantModel> result = [];

    for (var data in parseJson) {
      result.add(RestaurantModel.fromJson(data));
    }

    return result;
  }
}
