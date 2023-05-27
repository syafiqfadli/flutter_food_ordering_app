import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_food_ordering_app/src/features/data/repositories/repositories.dart';

part 'delete_restaurant_state.dart';

class DeleteRestaurantCubit extends Cubit<DeleteRestaurantState> {
  final AdminRepo adminRepo;

  DeleteRestaurantCubit({required this.adminRepo})
      : super(DeleteRestaurantInitial());

  Future<void> deleteRestaurant({required String restaurantId}) async {
    emit(DeleteRestaurantLoading());

    final deleteEither = await adminRepo.deleteRestaurant(
      restaurantId: restaurantId,
    );

    deleteEither.fold((failure) {
      emit(DeleteRestaurantError(message: failure.message));
    }, (_) {
      emit(DeleteRestaurantSuccessful());
    });
  }
}
