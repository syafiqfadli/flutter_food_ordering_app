import 'package:equatable/equatable.dart';
import 'package:flutter_food_ordering_app/src/entities/entities.dart';

class RestaurantEntity extends Equatable {
  final String restaurantId;
  final String restaurantName;
  final List<MenuEntity> menu;

  const RestaurantEntity({
    required this.restaurantId,
    required this.restaurantName,
    required this.menu,
  });

  @override
  List<Object?> get props => [restaurantId, restaurantName, menu];
}
