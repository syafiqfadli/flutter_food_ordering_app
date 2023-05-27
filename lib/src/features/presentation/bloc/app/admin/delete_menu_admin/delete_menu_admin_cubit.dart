import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_food_ordering_app/src/features/data/repositories/repositories.dart';

part 'delete_menu_admin_state.dart';

class DeleteMenuAdminCubit extends Cubit<DeleteMenuAdminState> {
  final AdminRepo adminRepo;

  DeleteMenuAdminCubit({required this.adminRepo})
      : super(DeleteMenuAdminInitial());

  Future<void> deleteMenu({
    required String restaurantId,
    required String menuId,
  }) async {
    emit(DeleteMenuAdminLoading());

    final deleteEither = await adminRepo.deleteMenu(
      restaurantId: restaurantId,
      menuId: menuId,
    );

    deleteEither.fold((failure) {
      emit(DeleteMenuAdminError(message: failure.message));
    }, (_) {
      emit(DeleteMenuAdminSuccessful());
    });
  }
}
