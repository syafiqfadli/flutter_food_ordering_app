part of 'add_menu_cubit.dart';

abstract class AddMenuState extends Equatable {
  const AddMenuState();

  @override
  List<Object> get props => [];
}

class AddMenuInitial extends AddMenuState {}

class AddMenuLoading extends AddMenuState {}

class AddMenuSuccessful extends AddMenuState {}

class AddMenuError extends AddMenuState {
  final String message;

  const AddMenuError({required this.message});

  @override
  List<Object> get props => [message];
}
