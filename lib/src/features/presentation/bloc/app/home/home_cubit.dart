import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_food_ordering_app/src/features/domain/entities/entities.dart';
import 'package:flutter_food_ordering_app/src/features/data/repositories/repositories.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final AppRepo appRepo;

  HomeCubit({required this.appRepo}) : super(HomeInitial());

  Future<void> homeDefault() async {
    emit(HomeLoading());

    final defaultEither = await appRepo.restaurantList();

    defaultEither.fold((failure) {
      emit(HomeError(message: failure.message));
    }, (restaurant) {
      emit(HomeLoaded(restaurantList: restaurant));
    });
  }

  Future<void> homeSearched({required String query}) async {
    emit(HomeLoading());

    final searchEither = await appRepo.searchRestaurant(query: query);

    searchEither.fold((failure) {
      emit(HomeError(message: failure.message));
    }, (restaurant) {
      emit(HomeSearched(searchedRestaurant: restaurant));
    });
  }
}
