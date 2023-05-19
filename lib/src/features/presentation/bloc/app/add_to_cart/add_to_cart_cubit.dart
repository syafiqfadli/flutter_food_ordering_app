import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_food_ordering_app/src/features/data/repositories/repositories.dart';

part 'add_to_cart_state.dart';

class AddToCartCubit extends Cubit<AddToCartState> {
  final AppRepo appRepo;

  AddToCartCubit({required this.appRepo}) : super(AddToCartInitial());

  Future<void> addToCart({
    required String restaurantId,
    required String restaurantName,
    required String menuId,
    required String menuName,
    required double price,
    required int quantity,
  }) async {
    emit(AddToCartLoading());

    final addTocartEither = await appRepo.addToCart(
      restaurantId: restaurantId,
      restaurantName: restaurantName,
      menuId: menuId,
      menuName: menuName,
      price: price,
      quantity: quantity,
    );

    addTocartEither.fold((failure) {
      emit(AddToCartError(message: failure.message));
    }, (_) {
      emit(AddToCartSuccessful());
    });
  }
}
