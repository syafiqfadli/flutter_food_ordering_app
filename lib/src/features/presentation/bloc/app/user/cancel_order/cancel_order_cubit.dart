import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:order_me/src/features/data/repositories/repositories.dart';

part 'cancel_order_state.dart';

class CancelOrderCubit extends Cubit<CancelOrderState> {
  final UserRepo userRepo;

  CancelOrderCubit({required this.userRepo}) : super(CancelOrderInitial());

  Future<void> cancelOrder({required String orderId}) async {
    emit(CancelOrderLoading());

    final cancelEither = await userRepo.cancelOrder(orderId: orderId);

    cancelEither.fold((failure) {
      emit(CancelOrderError(message: failure.message));
    }, (_) {
      emit(CancelOrderSuccessful());
    });
  }
}
