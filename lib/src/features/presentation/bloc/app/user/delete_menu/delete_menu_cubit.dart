import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_food_ordering_app/src/features/data/repositories/repositories.dart';

part 'delete_menu_state.dart';

class DeleteMenuCubit extends Cubit<DeleteMenuState> {
  final UserRepo userRepo;

  DeleteMenuCubit({
    required this.userRepo,
  }) : super(DeleteMenuInitial());

  Future<void> deleteMenu({
    required String cartId,
    required String menuId,
  }) async {
    emit(DeleteMenuLoading());

    final deleteMenuEither = await userRepo.deleteMenu(
      cartId: cartId,
      menuId: menuId,
    );

    deleteMenuEither.fold((failure) {
      emit(DeleteMenuError(message: failure.message));
    }, (_) {
      emit(DeleteMenuSuccessful());
    });
  }
}
