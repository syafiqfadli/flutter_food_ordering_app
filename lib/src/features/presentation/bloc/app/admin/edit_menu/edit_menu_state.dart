part of 'edit_menu_cubit.dart';

abstract class EditMenuState extends Equatable {
  const EditMenuState();

  @override
  List<Object> get props => [];
}

class EditMenuInitial extends EditMenuState {}

class EditMenuLoading extends EditMenuState {}

class EditMenuSuccessful extends EditMenuState {}

class EditMenuError extends EditMenuState {
  final String message;

  const EditMenuError({required this.message});

  @override
  List<Object> get props => [message];
}
