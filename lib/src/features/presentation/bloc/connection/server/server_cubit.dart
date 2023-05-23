import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_food_ordering_app/src/features/data/repositories/repositories.dart';

part 'server_state.dart';

class ServerCubit extends Cubit<ServerState> {
  final ServerRepo serverRepo;

  ServerCubit({required this.serverRepo}) : super(ServerInitial());

  Future<void> isServerOnline() async {
    final serverEither = await serverRepo.isServerOnline();

    serverEither.fold((failure) {
      emit(ServerError(message: failure.message));
    }, (_) {
      emit(ServerOnline());
    });
  }
}
