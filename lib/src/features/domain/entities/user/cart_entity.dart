import 'package:equatable/equatable.dart';
import 'package:flutter_food_ordering_app/src/features/domain/entities/entities.dart';

class CartEntity extends Equatable {
  final String cartId;
  final String restaurantId;
  final String restaurantName;
  final List<MenuEntity> menuList;

  const CartEntity({
    required this.cartId,
    required this.restaurantId,
    required this.restaurantName,
    required this.menuList,
  });

  @override
  List<Object?> get props => [cartId, restaurantId, restaurantName, menuList];

  static get empty => const CartEntity(
        cartId: '',
        restaurantId: '',
        restaurantName: '',
        menuList: [],
      );
}
