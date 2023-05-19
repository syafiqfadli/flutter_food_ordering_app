import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_food_ordering_app/src/features/data/repositories/repositories.dart';
import 'package:flutter_food_ordering_app/src/features/presentation/bloc/bloc.dart';

part 'signup_state.dart';

class SignUpCubit extends Cubit<SignUpState> {
  final AuthRepo authRepo;
  final ServerCubit serverCubit;

  SignUpCubit({
    required this.authRepo,
    required this.serverCubit,
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

    final signUpEither = await authRepo.signUp(
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
