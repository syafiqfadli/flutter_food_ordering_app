import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_food_ordering_app/src/core/errors/failures.dart';
import 'package:flutter_food_ordering_app/src/features/data/repositories/repositories.dart';
import 'package:flutter_food_ordering_app/src/features/presentation/bloc/bloc.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final AuthRepo authRepo;
  final AppRepo appRepo;
  final ServerCubit serverCubit;

  LoginCubit({
    required this.authRepo,
    required this.appRepo,
    required this.serverCubit,
  }) : super(LoginInitial());

  Future<void> login({
    required String email,
    required String password,
  }) async {
    emit(LoginLoading());

    await serverCubit.isServerOnline();

    final serverState = serverCubit.state;

    if (serverState is ServerError) {
      emit(LoginError(message: serverState.message));
      return;
    }

    final loginEither = await authRepo.login(email: email, password: password);

    loginEither.fold(
      (failure) {
        emit(LoginError(message: failure.message));
      },
      (_) async {
        final userEither = await appRepo.userInfo();
        final restaurantEither = await appRepo.restaurantList();

        if (userEither.isLeft() || restaurantEither.isLeft()) {
          final userFailure = userEither.swap().getOrElse(
                () => const SystemFailure(),
              );

          final restaurantFailure = restaurantEither.swap().getOrElse(
                () => const SystemFailure(),
              );

          await authRepo.logout();
          emit(
            LoginError(
                message:
                    "User: ${userFailure.message} \nRestaurant: ${restaurantFailure.message}"),
          );
          return;
        }

        emit(LoginSuccessful());
      },
    );
  }
}
