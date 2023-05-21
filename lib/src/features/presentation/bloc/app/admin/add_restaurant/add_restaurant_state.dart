part of 'add_restaurant_cubit.dart';

abstract class AddRestaurantState extends Equatable {
  const AddRestaurantState();

  @override
  List<Object> get props => [];
}

class AddRestaurantInitial extends AddRestaurantState {}

class AddRestaurantLoading extends AddRestaurantState {}

class AddRestaurantSuccessful extends AddRestaurantState {}

class AddRestaurantError extends AddRestaurantState {
  final String message;

  const AddRestaurantError({required this.message});

  @override
  List<Object> get props => [message];
}
