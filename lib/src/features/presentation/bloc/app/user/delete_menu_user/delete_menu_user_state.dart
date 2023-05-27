part of 'delete_menu_user_cubit.dart';

abstract class DeleteMenuUserState extends Equatable {
  const DeleteMenuUserState();

  @override
  List<Object> get props => [];
}

class DeleteMenuUserInitial extends DeleteMenuUserState {}

class DeleteMenuUserLoading extends DeleteMenuUserState {}

class DeleteMenuUserSuccessful extends DeleteMenuUserState {}

class DeleteMenuUserError extends DeleteMenuUserState {
  final String message;

  const DeleteMenuUserError({required this.message});

  @override
  List<Object> get props => [message];
}
