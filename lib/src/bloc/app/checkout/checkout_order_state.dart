part of 'checkout_order_cubit.dart';

abstract class CheckoutOrderState extends Equatable {
  const CheckoutOrderState();

  @override
  List<Object> get props => [];
}

class CheckoutOrderInitial extends CheckoutOrderState {}

class CheckoutOrderSuccessful extends CheckoutOrderState {}

class CheckoutOrderError extends CheckoutOrderState {
  final String message;

  const CheckoutOrderError({required this.message});

  @override
  List<Object> get props => [message];
}
