part of 'cancel_order_cubit.dart';

abstract class CancelOrderState extends Equatable {
  const CancelOrderState();

  @override
  List<Object> get props => [];
}

class CancelOrderInitial extends CancelOrderState {}

class CancelOrderLoading extends CancelOrderState {}

class CancelOrderSuccessful extends CancelOrderState {}

class CancelOrderError extends CancelOrderState {
  final String message;

  const CancelOrderError({required this.message});

  @override
  List<Object> get props => [message];
}
