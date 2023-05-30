import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:order_me/src/features/data/repositories/repositories.dart';
import 'package:order_me/src/features/presentation/bloc/bloc.dart';

part 'user_option_state.dart';

class UserOptionCubit extends Cubit<UserOptionState> {
  final AuthRepo authRepo;
  final UserRepo userRepo;
  final AdminRepo adminRepo;
  final ServerCubit serverCubit;

  UserOptionCubit({
    required this.authRepo,
    required this.userRepo,
    required this.adminRepo,
    required this.serverCubit,
  }) : super(UserOptionInitial());

  void optionSelected(int option) {
    if (option == 0) {
      emit(UserOptionIsUser());
      return;
    }

    if (option == 1) {
      emit(UserOptionIsAdmin());
      return;
    }
  }

  void resetOption() {
    emit(UserOptionInitial());
  }

  Future<void> appRefreshed() async {
    emit(UserOptionLoading());

    final userStatus = FirebaseAuth.instance.currentUser;

    if (userStatus == null) {
      emit(UserOptionInitial());
      return;
    }

    await serverCubit.isServerOnline();

    final serverState = serverCubit.state;

    if (serverState is ServerError) {
      await authRepo.logout();
      emit(UserOptionInitial());
      return;
    }

    final userEither = await userRepo.userInfo();
    final adminEither = await adminRepo.adminInfo();

    if (userEither.isLeft() || adminEither.isRight()) {
      emit(UserOptionIsAdmin());
      return;
    }

    if (userEither.isRight() || adminEither.isLeft()) {
      emit(UserOptionIsUser());
      return;
    }
  }
}
