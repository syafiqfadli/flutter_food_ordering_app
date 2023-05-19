import 'package:flutter_bloc/flutter_bloc.dart';

class SetPageCubit extends Cubit<int> {
  SetPageCubit() : super(0);

  void setIndex(int index) async {
    emit(index);
  }
}
