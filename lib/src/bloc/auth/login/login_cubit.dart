import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_food_ordering_app/src/repositories/repositories.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final AuthRepo authRepo;
  final AppRepo appRepo;

  LoginCubit({
    required this.authRepo,
    required this.appRepo,
  }) : super(LoginInitial());

  Future<void> login({
    required String email,
    required String password,
  }) async {
    emit(LoginLoading());

    final loginEither = await authRepo.login(email: email, password: password);

    loginEither.fold(
      (failure) {
        emit(LoginError(message: failure.message));
      },
      (_) async {
        final userEither = await appRepo.userInfo();

        if (userEither.isLeft()) {
          emit(const LoginError(message: "System failure."));
          return;
        }

        emit(LoginSuccessful());
      },
    );
  }

  void loginLoading() {
    emit(LoginLoading());
  }

  void loginInitial() {
    emit(LoginInitial());
  }
}
