import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_food_ordering_app/src/features/data/repositories/repositories.dart';

part 'checkout_order_state.dart';

class CheckoutOrderCubit extends Cubit<CheckoutOrderState> {
  final UserRepo userRepo;

  CheckoutOrderCubit({required this.userRepo}) : super(CheckoutOrderInitial());

  Future<void> checkoutOrder({
    required String cartId,
    required String restaurantId,
  }) async {
    emit(CheckoutOrderLoading());

    final checkoutEither = await userRepo.checkoutOrder(
      cartId: cartId,
      restaurantId: restaurantId,
    );

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
