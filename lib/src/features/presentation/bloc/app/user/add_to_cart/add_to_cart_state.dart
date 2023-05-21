part of 'add_to_cart_cubit.dart';

abstract class AddToCartState extends Equatable {
  const AddToCartState();

  @override
  List<Object> get props => [];
}

class AddToCartInitial extends AddToCartState {}

class AddToCartLoading extends AddToCartState {}

class AddToCartSuccessful extends AddToCartState {}

class AddToCartError extends AddToCartState {
  final String message;

  const AddToCartError({required this.message});

  @override
  List<Object> get props => [message];
}
