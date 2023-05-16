import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_food_ordering_app/src/repositories/repositories.dart';

part 'checkout_order_state.dart';

class CheckoutOrderCubit extends Cubit<CheckoutOrderState> {
  final AppRepo appRepo;

  CheckoutOrderCubit({required this.appRepo}) : super(CheckoutOrderInitial());

  Future<void> checkoutOrder({required String cartId}) async {
    emit(CheckoutOrderLoading());

    final checkoutEither = await appRepo.checkoutOrder(cartId: cartId);

    checkoutEither.fold(
      (failure) {
        emit(CheckoutOrderError(message: failure.message));
      },
      (_) {
        emit(CheckoutOrderSuccessful());
      },
    );
  }
}
