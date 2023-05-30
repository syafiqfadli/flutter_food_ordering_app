import 'package:equatable/equatable.dart';
import 'package:order_me/src/features/domain/entities/entities.dart';

class UserEntity extends Equatable {
  final String firebaseId;
  final String name;
  final String email;
  final List<CartEntity> cart;
  final List<OrderEntity> order;
  final List<HistoryEntity> history;

  const UserEntity({
    required this.firebaseId,
    required this.name,
    required this.email,
    required this.cart,
    required this.order,
    required this.history,
  });

  @override
  List<Object?> get props => [firebaseId, name, email, cart, order, history];

  static get empty => const UserEntity(
        firebaseId: '',
        name: '',
        email: '',
        cart: [],
        order: [],
        history: [],
      );
}
