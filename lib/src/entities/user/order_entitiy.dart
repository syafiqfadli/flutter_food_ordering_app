import 'package:equatable/equatable.dart';

class OrderEntity extends Equatable {
  final String orderId;

  const OrderEntity({required this.orderId});

  @override
  List<Object?> get props => [orderId];
}
