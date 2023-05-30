import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:order_me/src/features/data/repositories/repositories.dart';

part 'complete_order_state.dart';

class CompleteOrderCubit extends Cubit<CompleteOrderState> {
  final UserRepo userRepo;

  CompleteOrderCubit({required this.userRepo}) : super(CompleteOrderInitial());

  Future<void> completeOrder({required String orderId}) async {
    emit(CompleteOrderLoading());

    final completeEither = await userRepo.completeOrder(orderId: orderId);

    completeEither.fold((failure) {
      emit(CompleteOrderError(message: failure.message));
    }, (_) {
      emit(CompleteOrderSuccessful());
    });
  }
}
