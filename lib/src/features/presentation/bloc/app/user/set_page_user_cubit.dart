import 'package:flutter_bloc/flutter_bloc.dart';

class SetPageUserCubit extends Cubit<int> {
  SetPageUserCubit() : super(0);

  void setIndex(int index) async {
    emit(index);
  }
}
