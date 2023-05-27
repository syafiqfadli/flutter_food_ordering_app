part of 'delete_restaurant_cubit.dart';

abstract class DeleteRestaurantState extends Equatable {
  const DeleteRestaurantState();

  @override
  List<Object> get props => [];
}

class DeleteRestaurantInitial extends DeleteRestaurantState {}

class DeleteRestaurantLoading extends DeleteRestaurantState {}

class DeleteRestaurantSuccessful extends DeleteRestaurantState {}

class DeleteRestaurantError extends DeleteRestaurantState {
  final String message;

  const DeleteRestaurantError({required this.message});

  @override
  List<Object> get props => [message];
}
