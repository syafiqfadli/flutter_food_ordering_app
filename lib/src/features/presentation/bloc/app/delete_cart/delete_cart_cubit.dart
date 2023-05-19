import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_food_ordering_app/src/features/data/repositories/repositories.dart';
import 'package:flutter_food_ordering_app/src/features/presentation/bloc/bloc.dart';

part 'delete_cart_state.dart';

class DeleteCartCubit extends Cubit<DeleteCartState> {
  final AppRepo appRepo;
  final UserInfoCubit userInfoCubit;

  DeleteCartCubit({
    required this.appRepo,
    required this.userInfoCubit,
  }) : super(DeleteCartInitial());

  Future<void> deleteCart({required String cartId}) async {
    emit(DeleteCartLoading());

    final deleteCartEither = await appRepo.deleteCart(cartId: cartId);

    deleteCartEither.fold((failure) {
      emit(DeleteCartError(message: failure.message));
    }, (_) async {
      await userInfoCubit.userInfo();
      emit(DeleteCartSuccessful());
    });
  }
}
