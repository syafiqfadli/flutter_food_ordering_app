import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:order_me/src/features/data/repositories/repositories.dart';
import 'package:order_me/src/features/presentation/bloc/bloc.dart';

part 'delete_cart_state.dart';

class DeleteCartCubit extends Cubit<DeleteCartState> {
  final UserRepo userRepo;
  final UserInfoCubit userInfoCubit;

  DeleteCartCubit({
    required this.userRepo,
    required this.userInfoCubit,
  }) : super(DeleteCartInitial());

  Future<void> deleteCart({required String cartId}) async {
    emit(DeleteCartLoading());

    final deleteCartEither = await userRepo.deleteCart(cartId: cartId);

    deleteCartEither.fold((failure) {
      emit(DeleteCartError(message: failure.message));
    }, (_) async {
      emit(DeleteCartSuccessful());
      await userInfoCubit.userInfo();
    });
  }
}
