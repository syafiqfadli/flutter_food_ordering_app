import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_food_ordering_app/src/repositories/repositories.dart';

part 'logout_state.dart';

class LogoutCubit extends Cubit<LogoutState> {
  final AuthRepo authRepo;

  LogoutCubit({required this.authRepo}) : super(LogoutInitial());

  Future<void> logout() async {
    final logoutEither = await authRepo.logout();

    logoutEither.fold(
      (_) => emit(LogoutFailed()),
      (_) => emit(LogoutSuccessful()),
    );
  }
}
