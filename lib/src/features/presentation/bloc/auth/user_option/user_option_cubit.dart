import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'user_option_state.dart';

class UserOptionCubit extends Cubit<UserOptionState> {
  UserOptionCubit() : super(UserOptionInitial());

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
}
