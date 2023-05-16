import 'package:flutter_food_ordering_app/src/entities/entities.dart';

class OrderModel extends OrderEntity {
  const OrderModel({required super.orderId});

  factory OrderModel.fromJson(Map<String, dynamic> parseJson) {
    return OrderModel(
      orderId: parseJson["orderId"],
    );
  }

  static List<OrderModel> fromList(List<dynamic> parseJson) {
    List<OrderModel> result = [];

    for (var data in parseJson) {
      result.add(OrderModel.fromJson(data));
    }

    return result;
  }
}
