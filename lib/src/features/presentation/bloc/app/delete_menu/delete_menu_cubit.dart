import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_food_ordering_app/src/features/data/repositories/repositories.dart';
import 'package:flutter_food_ordering_app/src/features/presentation/bloc/bloc.dart';

part 'delete_menu_state.dart';

class DeleteMenuCubit extends Cubit<DeleteMenuState> {
  final AppRepo appRepo;
  final UserInfoCubit userInfoCubit;

  DeleteMenuCubit({
    required this.appRepo,
    required this.userInfoCubit,
  }) : super(DeleteMenuInitial());

  Future<void> deleteMenu({
    required String cartId,
    required String menuId,
  }) async {
    emit(DeleteMenuLoading());

    final deleteMenuEither = await appRepo.deleteMenu(
      cartId: cartId,
      menuId: menuId,
    );

    deleteMenuEither.fold((failure) {
      emit(DeleteMenuError(message: failure.message));
    }, (_) async {
      emit(DeleteMenuSuccessful());
      await userInfoCubit.userInfo();
    });
  }
}
