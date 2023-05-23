part of 'update_status_cubit.dart';

abstract class UpdateStatusState extends Equatable {
  const UpdateStatusState();

  @override
  List<Object> get props => [];
}

class UpdateStatusInitial extends UpdateStatusState {}

class UpdateStatusLoading extends UpdateStatusState {}

class UpdateStatusSuccessful extends UpdateStatusState {}

class UpdateStatusError extends UpdateStatusState {
  final String message;

  const UpdateStatusError({required this.message});

  @override
  List<Object> get props => [message];
}
