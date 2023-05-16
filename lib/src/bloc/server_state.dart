part of 'server_cubit.dart';

abstract class ServerState extends Equatable {
  const ServerState();

  @override
  List<Object> get props => [];
}

class ServerInitial extends ServerState {}

class ServerLoading extends ServerState {}

class ServerOnline extends ServerState {}

class ServerError extends ServerState {
  final String message;

  const ServerError({required this.message});

  @override
  List<Object> get props => [message];
}
