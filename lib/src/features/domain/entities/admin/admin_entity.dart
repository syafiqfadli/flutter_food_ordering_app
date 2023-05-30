import 'package:equatable/equatable.dart';
import 'package:order_me/src/features/domain/entities/entities.dart';

class AdminEntity extends Equatable {
  final String firebaseId;
  final String name;
  final String email;
  final List<OrderEntity> order;
  final List<RestaurantEntity> restaurant;

  const AdminEntity({
    required this.firebaseId,
    required this.name,
    required this.email,
    required this.order,
    required this.restaurant,
  });

  @override
  List<Object?> get props => [firebaseId, name, email, order, restaurant];

  static get empty => const AdminEntity(
        firebaseId: '',
        name: '',
        email: '',
        restaurant: [],
        order: [],
      );
}
