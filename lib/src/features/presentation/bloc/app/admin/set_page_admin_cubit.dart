import 'package:flutter_bloc/flutter_bloc.dart';

class SetPageAdminCubit extends Cubit<int> {
  SetPageAdminCubit() : super(0);

  void setIndex(int index) async {
    emit(index);
  }
}
