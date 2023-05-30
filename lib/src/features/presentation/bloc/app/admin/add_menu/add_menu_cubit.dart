import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:order_me/src/features/data/repositories/repositories.dart';

part 'add_menu_state.dart';

class AddMenuCubit extends Cubit<AddMenuState> {
  final AdminRepo adminRepo;

  AddMenuCubit({required this.adminRepo}) : super(AddMenuInitial());

  Future<void> addMenu({
    required String restaurantId,
    required String menuName,
    required String description,
    required double price,
  }) async {
    emit(AddMenuLoading());

    final addMenuEither = await adminRepo.addMenu(
      restaurantId: restaurantId,
      menuName: menuName,
      description: description,
      price: price,
    );

    addMenuEither.fold((failure) {
      emit(AddMenuError(message: failure.message));
    }, (_) {
      emit(AddMenuSuccessful());
    });
  }
}
