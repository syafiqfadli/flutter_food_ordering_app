import 'package:equatable/equatable.dart';

class MenuEntity extends Equatable {
  final String menuId;
  final String menu;
  final double price;
  final int quantity;
  final double totalPrice;

  const MenuEntity({
    required this.menuId,
    required this.menu,
    required this.price,
    required this.quantity,
    required this.totalPrice,
  });

  @override
  List<Object?> get props => [menuId, menu, price, quantity, totalPrice];
}
