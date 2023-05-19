part of 'delete_menu_cubit.dart';

abstract class DeleteMenuState extends Equatable {
  const DeleteMenuState();

  @override
  List<Object> get props => [];
}

class DeleteMenuInitial extends DeleteMenuState {}

class DeleteMenuLoading extends DeleteMenuState {}

class DeleteMenuSuccessful extends DeleteMenuState {}

class DeleteMenuError extends DeleteMenuState {
  final String message;

  const DeleteMenuError({required this.message});

  @override
  List<Object> get props => [message];
}
