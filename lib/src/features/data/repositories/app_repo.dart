import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_food_ordering_app/src/features/data/datasources/api_datasource.dart';
import 'package:flutter_food_ordering_app/src/features/domain/entities/entities.dart';
import 'package:flutter_food_ordering_app/src/core/errors/failures.dart';
import 'package:flutter_food_ordering_app/src/features/data/models/models.dart';
import 'package:flutter_food_ordering_app/src/core/utils/utils.dart';

abstract class AppRepo {
  Future<Either<Failure, UserEntity>> userInfo();
  Future<Either<Failure, List<RestaurantEntity>>> restaurantList();
  Future<Either<Failure, void>> deleteCart({required String cartId});
  Future<Either<Failure, void>> deleteMenu({
    required String cartId,
    required String menuId,
  });
  Future<Either<Failure, void>> checkoutOrder({required String cartId});
  Future<Either<Failure, void>> addToCart({
    required String restaurantId,
    required String restaurantName,
    required String menuId,
    required String menuName,
    required double price,
    required int quantity,
  });
  Future<Either<Failure, List<RestaurantEntity>>> searchRestaurant(
      {required String query});
}

class AppRepoImpl implements AppRepo {
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  final ApiDataSource apiDataSource;

  AppRepoImpl({required this.apiDataSource});

  @override
  Future<Either<Failure, UserEntity>> userInfo() async {
    try {
      final String firebaseId = firebaseAuth.currentUser!.uid;
      final Uri url = Uri.parse("${ApiUrl.userInfo}?firebaseId=$firebaseId");

      final responseEither = await apiDataSource.get(
        url,
        headers: {'Content-Type': 'application/json'},
      );

      if (responseEither.isLeft()) {
        final failure = responseEither.swap().getOrElse(
              () => const SystemFailure(),
            );
        return Left(SystemFailure(message: failure.message));
      }

      final userJson = responseEither.getOrElse(() => ResponseEntity.empty);

      final userEntity = UserModel.fromJson(userJson.data);

      return Right(userEntity);
    } catch (e) {
      print(e.toString());

      return Left(SystemFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> checkoutOrder({required String cartId}) async {
    try {
      final String firebaseId = firebaseAuth.currentUser!.uid;
      final Uri url = Uri.parse(ApiUrl.checkoutOrder);

      final responseEither = await apiDataSource.patch(
        url,
        headers: {'Content-Type': 'application/json'},
        body: {
          "firebaseId": firebaseId,
          "cartId": cartId,
        },
      );

      if (responseEither.isLeft()) {
        final failure = responseEither.swap().getOrElse(
              () => const SystemFailure(),
            );

        return Left(SystemFailure(message: failure.message));
      }

      return const Right(null);
    } catch (e) {
      return Left(SystemFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<RestaurantEntity>>> searchRestaurant(
      {required String query}) async {
    try {
      final Uri url =
          Uri.parse("${ApiUrl.searchRestaurant}?restaurantQuery=$query");

      final responseEither = await apiDataSource.get(
        url,
        headers: {'Content-Type': 'application/json'},
      );

      if (responseEither.isLeft()) {
        final failure = responseEither.swap().getOrElse(
              () => const SystemFailure(),
            );

        return Left(SystemFailure(message: failure.message));
      }

      final restaurantJson =
          responseEither.getOrElse(() => ResponseEntity.empty);

      final restaurantEntity =
          RestaurantModel.fromList(restaurantJson.data["restaurant"]);

      return Right(restaurantEntity);
    } catch (e) {
      return Left(SystemFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<RestaurantEntity>>> restaurantList() async {
    try {
      final Uri url = Uri.parse(ApiUrl.restaurantList);

      final responseEither = await apiDataSource.get(
        url,
        headers: {'Content-Type': 'application/json'},
      );

      if (responseEither.isLeft()) {
        final failure = responseEither.swap().getOrElse(
              () => const SystemFailure(),
            );

        return Left(SystemFailure(message: failure.message));
      }

      final restaurantJson =
          responseEither.getOrElse(() => ResponseEntity.empty);

      final restaurantEntity =
          RestaurantModel.fromList(restaurantJson.data["restaurant"]);

      return Right(restaurantEntity);
    } catch (e) {
      print(e.toString());

      return Left(SystemFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> addToCart({
    required String restaurantId,
    required String restaurantName,
    required String menuId,
    required String menuName,
    required double price,
    required int quantity,
  }) async {
    try {
      final String firebaseId = firebaseAuth.currentUser!.uid;

      final Uri url = Uri.parse(ApiUrl.addToCart);

      final responseEither = await apiDataSource.patch(
        url,
        headers: {'Content-Type': 'application/json'},
        body: {
          "firebaseId": firebaseId,
          "restaurantId": restaurantId,
          "restaurantName": restaurantName,
          "menuId": menuId,
          "menuName": menuName,
          "price": price,
          "quantity": quantity,
        },
      );

      if (responseEither.isLeft()) {
        final failure = responseEither.swap().getOrElse(
              () => const SystemFailure(),
            );

        return Left(SystemFailure(message: failure.message));
      }

      return const Right(null);
    } catch (e) {
      print(e.toString());

      return Left(SystemFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> deleteCart({required String cartId}) async {
    try {
      final Uri url = Uri.parse(ApiUrl.deleteCart);

      final responseEither = await apiDataSource.delete(
        url,
        headers: {'Content-Type': 'application/json'},
        body: {
          "cartId": cartId,
        },
      );

      if (responseEither.isLeft()) {
        final failure = responseEither.swap().getOrElse(
              () => const SystemFailure(),
            );

        return Left(SystemFailure(message: failure.message));
      }

      return const Right(null);
    } catch (e) {
      print(e.toString());

      return Left(SystemFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> deleteMenu({
    required String cartId,
    required String menuId,
  }) async {
    try {
      final Uri url = Uri.parse(ApiUrl.deleteMenu);

      final responseEither = await apiDataSource.delete(
        url,
        headers: {'Content-Type': 'application/json'},
        body: {
          "cartId": cartId,
          "menuId": menuId,
        },
      );

      if (responseEither.isLeft()) {
        final failure = responseEither.swap().getOrElse(
              () => const SystemFailure(),
            );

        return Left(SystemFailure(message: failure.message));
      }

      return const Right(null);
    } catch (e) {
      print(e.toString());

      return Left(SystemFailure(message: e.toString()));
    }
  }
}
