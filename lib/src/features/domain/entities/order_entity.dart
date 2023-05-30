import 'package:equatable/equatable.dart';
import 'package:order_me/src/features/domain/entities/entities.dart';

class OrderEntity extends Equatable {
  final String orderId;
  final String restaurantId;
  final String restaurantName;
  final String customerName;
  final String status;
  final List<MenuEntity> orderList;

  const OrderEntity({
    required this.orderId,
    required this.restaurantId,
    required this.restaurantName,
    required this.customerName,
    required this.status,
    required this.orderList,
  });

  @override
  List<Object?> get props => [
        orderId,
        restaurantId,
        restaurantName,
        customerName,
        status,
        orderList,
      ];
}
