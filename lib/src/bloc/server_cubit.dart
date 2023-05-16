import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_food_ordering_app/src/bloc/bloc.dart';
import 'package:flutter_food_ordering_app/src/repositories/repositories.dart';

part 'server_state.dart';

class ServerCubit extends Cubit<ServerState> {
  final ServerRepo serverRepo;
  final LoginCubit loginCubit;
  final SignUpCubit signUpCubit;

  ServerCubit({
    required this.serverRepo,
    required this.loginCubit,
    required this.signUpCubit,
  }) : super(ServerInitial());

  Future<void> isServerOnline({required bool isLoginPage}) async {
    //TODO: Loading button issue

    if (isLoginPage) {
      loginCubit.loginLoading();
    } else {
      signUpCubit.signUpLoading();
    }

    final serverEither = await serverRepo.isServerOnline();

    if (isLoginPage) {
      loginCubit.loginInitial();
    } else {
      signUpCubit.signUpInitial();
    }

    serverEither.fold((failure) {
      emit(ServerError(message: failure.message));
    }, (_) {
      emit(ServerOnline());
    });
  }
}
