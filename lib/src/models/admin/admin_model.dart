import 'package:flutter_food_ordering_app/src/entities/entities.dart';
import 'package:flutter_food_ordering_app/src/models/models.dart';

class AdminModel extends AdminEntity {
  const AdminModel({
    required super.firebaseId,
    required super.name,
    required super.email,
    required super.order,
    required super.restaurant,
  });

  factory AdminModel.fromJson(Map<String, dynamic> parseJson) {
    return AdminModel(
      firebaseId: parseJson['firebaseId'],
      name: parseJson['name'],
      email: parseJson['email'],
      order: parseJson["order"] != null
          ? OrderModel.fromList(parseJson["order"])
          : <OrderModel>[],
      restaurant: parseJson["restaurant"] != null
          ? RestaurantModel.fromList(parseJson["restaurant"])
          : <RestaurantModel>[],
    );
  }
}
