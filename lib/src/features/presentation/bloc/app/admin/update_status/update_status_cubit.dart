import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_food_ordering_app/src/features/data/repositories/repositories.dart';

part 'update_status_state.dart';

class UpdateStatusCubit extends Cubit<UpdateStatusState> {
  final AdminRepo adminRepo;

  UpdateStatusCubit({required this.adminRepo}) : super(UpdateStatusInitial());

  Future<void> updateStatus({required String orderId}) async {
    emit(UpdateStatusLoading());

    final adminEither = await adminRepo.updateStatus(orderId: orderId);

    adminEither.fold((failure) {
      emit(UpdateStatusError(message: failure.message));
    }, (_) {
      emit(UpdateStatusSuccessful());
    });
  }
}
