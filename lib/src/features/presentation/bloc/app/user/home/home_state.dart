part of 'home_cubit.dart';

abstract class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object> get props => [];
}

class HomeInitial extends HomeState {}

class HomeLoading extends HomeState {}

class HomeLoaded extends HomeState {
  final List<RestaurantEntity> restaurantList;

  const HomeLoaded({required this.restaurantList});

  @override
  List<Object> get props => [restaurantList];
}

class HomeSearched extends HomeState {
  final List<RestaurantEntity> searchedRestaurant;

  const HomeSearched({required this.searchedRestaurant});

  @override
  List<Object> get props => [searchedRestaurant];
}

class HomeError extends HomeState {
  final String message;

  const HomeError({required this.message});

  @override
  List<Object> get props => [message];
}
