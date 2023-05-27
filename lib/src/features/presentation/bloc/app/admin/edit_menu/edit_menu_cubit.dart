import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_food_ordering_app/src/features/data/repositories/repositories.dart';

part 'edit_menu_state.dart';

class EditMenuCubit extends Cubit<EditMenuState> {
  final AdminRepo adminRepo;

  EditMenuCubit({required this.adminRepo}) : super(EditMenuInitial());

  Future<void> editMenu({
    required String restaurantId,
    required String menuId,
    required String menuName,
    required String description,
    required double price,
  }) async {
    emit(EditMenuLoading());

    final editEither = await adminRepo.editMenu(
      restaurantId: restaurantId,
      menuId: menuId,
      menuName: menuName,
      description: description,
      price: price,
    );

    editEither.fold((failure) {
      emit(EditMenuError(message: failure.message));
    }, (_) {
      emit(EditMenuSuccessful());
    });
  }
}
