import 'package:order_me/src/features/domain/entities/entities.dart';
import 'package:order_me/src/features/data/models/models.dart';

class RestaurantModel extends RestaurantEntity {
  const RestaurantModel({
    required super.restaurantId,
    required super.restaurantName,
    required super.menuList,
  });

  factory RestaurantModel.fromJson(Map<String, dynamic> parseJson) {
    return RestaurantModel(
      restaurantId: parseJson["restaurantId"],
      restaurantName: parseJson["restaurantName"],
      menuList: parseJson["menuList"] != null
          ? MenuModel.fromList(parseJson["menuList"])
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
