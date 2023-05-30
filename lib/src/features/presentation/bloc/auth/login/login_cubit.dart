import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:order_me/src/core/errors/failures.dart';
import 'package:order_me/src/features/data/repositories/repositories.dart';
import 'package:order_me/src/features/presentation/bloc/bloc.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final AuthRepo authRepo;
  final UserRepo userRepo;
  final AdminRepo adminRepo;
  final ServerCubit serverCubit;
  final UserOptionCubit userOptionCubit;

  LoginCubit({
    required this.authRepo,
    required this.userRepo,
    required this.adminRepo,
    required this.serverCubit,
    required this.userOptionCubit,
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
        if (userOptionCubit.state is UserOptionIsUser) {
          final userEither = await userRepo.userInfo();

          if (userEither.isLeft()) {
            final userFailure = userEither.swap().getOrElse(
                  () => const SystemFailure(),
                );

            await authRepo.logout();

            emit(LoginError(message: userFailure.message));

            return;
          }
        }

        if (userOptionCubit.state is UserOptionIsAdmin) {
          final adminEither = await adminRepo.adminInfo();

          if (adminEither.isLeft()) {
            final adminFailure = adminEither.swap().getOrElse(
                  () => const SystemFailure(),
                );

            await authRepo.logout();

            emit(LoginError(message: adminFailure.message));

            return;
          }
        }

        emit(LoginSuccessful());
      },
    );
  }
}
