import 'package:equatable/equatable.dart';
import 'package:flutter_food_ordering_app/src/entities/entities.dart';

class OrderEntity extends Equatable {
  final String orderId;
  final String restaurantId;
  final String restaurantName;
  final String status;
  final List<MenuEntity> orderList;

  const OrderEntity({
    required this.orderId,
    required this.restaurantId,
    required this.restaurantName,
    required this.status,
    required this.orderList,
  });

  @override
  List<Object?> get props => [
        orderId,
        restaurantId,
        restaurantName,
        status,
        orderList,
      ];
}
