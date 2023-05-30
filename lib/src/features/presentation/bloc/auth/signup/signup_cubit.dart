import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:order_me/src/features/data/repositories/repositories.dart';
import 'package:order_me/src/features/presentation/bloc/bloc.dart';

part 'signup_state.dart';

class SignUpCubit extends Cubit<SignUpState> {
  final AuthRepo authRepo;
  final ServerCubit serverCubit;
  final UserOptionCubit userOptionCubit;

  SignUpCubit({
    required this.authRepo,
    required this.serverCubit,
    required this.userOptionCubit,
  }) : super(SignUpInitial());

  Future<void> signUp({
    required String name,
    required String email,
    required String password,
  }) async {
    emit(SignUpLoading());

    await serverCubit.isServerOnline();

    final serverState = serverCubit.state;

    if (serverState is ServerError) {
      emit(SignUpError(message: serverState.message));
      return;
    }

    final option = userOptionCubit.state;
    bool isUser = true;

    if (option is UserOptionIsUser) {
      isUser = true;
    }

    if (option is UserOptionIsAdmin) {
      isUser = false;
    }

    final signUpEither = await authRepo.signUp(
      isUser: isUser,
      name: name,
      email: email,
      password: password,
    );

    signUpEither.fold((failure) {
      emit(SignUpError(message: failure.message));
    }, (_) {
      emit(SignUpSuccessful());
    });
  }
}
