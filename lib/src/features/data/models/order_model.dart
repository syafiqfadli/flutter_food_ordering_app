import 'package:flutter_food_ordering_app/src/features/domain/entities/entities.dart';
import 'package:flutter_food_ordering_app/src/features/data/models/models.dart';

class OrderModel extends OrderEntity {
  const OrderModel({
    required super.orderId,
    required super.restaurantId,
    required super.restaurantName,
    required super.status,
    required super.orderList,
  });

  factory OrderModel.fromJson(Map<String, dynamic> parseJson) {
    return OrderModel(
      orderId: parseJson["orderId"],
      restaurantId: parseJson["restaurantId"],
      restaurantName: parseJson["restaurantName"],
      status: parseJson["status"],
      orderList: parseJson["orderList"] != null
          ? MenuModel.fromList(parseJson["orderList"])
          : <MenuModel>[],
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
