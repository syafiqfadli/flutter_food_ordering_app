import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_food_ordering_app/src/features/data/repositories/repositories.dart';

part 'delete_menu_user_state.dart';

class DeleteMenuUserCubit extends Cubit<DeleteMenuUserState> {
  final UserRepo userRepo;

  DeleteMenuUserCubit({
    required this.userRepo,
  }) : super(DeleteMenuUserInitial());

  Future<void> deleteMenu({
    required String cartId,
    required String menuId,
  }) async {
    emit(DeleteMenuUserLoading());

    final deleteMenuEither = await userRepo.deleteMenu(
      cartId: cartId,
      menuId: menuId,
    );

    deleteMenuEither.fold((failure) {
      emit(DeleteMenuUserError(message: failure.message));
    }, (_) {
      emit(DeleteMenuUserSuccessful());
    });
  }
}
