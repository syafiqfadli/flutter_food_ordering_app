import 'package:equatable/equatable.dart';

class MenuEntity extends Equatable {
  final String menuId;
  final String menuName;
  final String description;
  final double price;
  final int quantity;
  final double totalPrice;

  const MenuEntity({
    required this.menuId,
    required this.menuName,
    required this.description,
    required this.price,
    required this.quantity,
    required this.totalPrice,
  });

  @override
  List<Object?> get props => [
        menuId,
        menuName,
        description,
        price,
        quantity,
        totalPrice,
      ];
}
