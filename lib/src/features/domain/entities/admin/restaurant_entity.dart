import 'package:equatable/equatable.dart';
import 'package:order_me/src/features/domain/entities/entities.dart';

class RestaurantEntity extends Equatable {
  final String restaurantId;
  final String restaurantName;
  final List<MenuEntity> menuList;

  const RestaurantEntity({
    required this.restaurantId,
    required this.restaurantName,
    required this.menuList,
  });

  @override
  List<Object?> get props => [restaurantId, restaurantName, menuList];
}
