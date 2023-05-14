import 'package:equatable/equatable.dart';

class CartEntity extends Equatable {
  final String cartId;
  final String menu;
  final double price;
  final int quantity;

  const CartEntity({
    required this.cartId,
    required this.menu,
    required this.price,
    required this.quantity,
  });

  @override
  List<Object?> get props => [cartId, menu, price, quantity];
}
