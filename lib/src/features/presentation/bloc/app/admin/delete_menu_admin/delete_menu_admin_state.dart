part of 'delete_menu_admin_cubit.dart';

abstract class DeleteMenuAdminState extends Equatable {
  const DeleteMenuAdminState();

  @override
  List<Object> get props => [];
}

class DeleteMenuAdminInitial extends DeleteMenuAdminState {}

class DeleteMenuAdminLoading extends DeleteMenuAdminState {}

class DeleteMenuAdminSuccessful extends DeleteMenuAdminState {}

class DeleteMenuAdminError extends DeleteMenuAdminState {
  final String message;

  const DeleteMenuAdminError({required this.message});

  @override
  List<Object> get props => [message];
}
