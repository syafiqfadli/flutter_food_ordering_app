import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_food_ordering_app/src/repositories/repositories.dart';

part 'signup_state.dart';

class SignUpCubit extends Cubit<SignUpState> {
  final AuthRepo authRepo;

  SignUpCubit({required this.authRepo}) : super(SignUpInitial());

  Future<void> signUp({
    required String name,
    required String email,
    required String password,
  }) async {
    emit(SignUpLoading());

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

  void signUpLoading() {
    emit(SignUpLoading());
  }

  void signUpInitial() {
    emit(SignUpInitial());
  }
}
