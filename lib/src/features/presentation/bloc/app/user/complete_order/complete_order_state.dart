part of 'complete_order_cubit.dart';

abstract class CompleteOrderState extends Equatable {
  const CompleteOrderState();

  @override
  List<Object> get props => [];
}

class CompleteOrderInitial extends CompleteOrderState {}

class CompleteOrderLoading extends CompleteOrderState {}

class CompleteOrderSuccessful extends CompleteOrderState {}

class CompleteOrderError extends CompleteOrderState {
  final String message;

  const CompleteOrderError({required this.message});

  @override
  List<Object> get props => [message];
}
