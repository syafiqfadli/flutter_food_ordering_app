import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:order_me/src/features/domain/entities/entities.dart';
import 'package:order_me/src/features/data/repositories/repositories.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final UserRepo userRepo;

  HomeCubit({required this.userRepo}) : super(HomeInitial());

  Future<void> homeDefault() async {
    emit(HomeLoading());

    final defaultEither = await userRepo.restaurantList();

    defaultEither.fold((failure) {
      emit(HomeError(message: failure.message));
    }, (restaurant) {
      emit(HomeLoaded(restaurantList: restaurant));
    });
  }

  Future<void> homeSearched({required String query}) async {
    emit(HomeLoading());

    final searchEither = await userRepo.searchRestaurant(query: query);

    searchEither.fold((failure) {
      emit(HomeError(message: failure.message));
    }, (restaurant) {
      emit(HomeSearched(searchedRestaurant: restaurant));
    });
  }
}
