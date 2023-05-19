part of 'delete_cart_cubit.dart';

abstract class DeleteCartState extends Equatable {
  const DeleteCartState();

  @override
  List<Object> get props => [];
}

class DeleteCartInitial extends DeleteCartState {}

class DeleteCartLoading extends DeleteCartState {}

class DeleteCartSuccessful extends DeleteCartState {}

class DeleteCartError extends DeleteCartState {
  final String message;

  const DeleteCartError({required this.message});

  @override
  List<Object> get props => [message];
}
