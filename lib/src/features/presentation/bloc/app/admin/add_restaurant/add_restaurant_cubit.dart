import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:order_me/src/features/data/repositories/repositories.dart';

part 'add_restaurant_state.dart';

class AddRestaurantCubit extends Cubit<AddRestaurantState> {
  final AdminRepo adminRepo;

  AddRestaurantCubit({required this.adminRepo}) : super(AddRestaurantInitial());

  Future<void> addRestaurant({required String restaurantName}) async {
    emit(AddRestaurantLoading());

    final addResEither =
        await adminRepo.addRestaurant(restaurantName: restaurantName);

    addResEither.fold((failure) {
      emit(AddRestaurantError(message: failure.message));
    }, (_) {
      emit(AddRestaurantSuccessful());
    });
  }
}
