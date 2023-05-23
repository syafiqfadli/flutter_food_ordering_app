import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_food_ordering_app/src/core/errors/failures.dart';
import 'package:flutter_food_ordering_app/src/core/utils/utils.dart';
import 'package:flutter_food_ordering_app/src/features/data/datasources/api_datasource.dart';
import 'package:flutter_food_ordering_app/src/features/data/models/models.dart';
import 'package:flutter_food_ordering_app/src/features/domain/entities/entities.dart';

abstract class AdminRepo {
  Future<Either<Failure, AdminEntity>> adminInfo();
  Future<Either<Failure, List<OrderEntity>>> orderStatus({
    required String status,
  });
  Future<Either<Failure, void>> updateStatus({
    required String orderId,
  });
  Future<Either<Failure, void>> addRestaurant({
    required String restaurantName,
  });
  Future<Either<Failure, void>> addMenu({
    required String restaurantId,
    required String menuName,
    required String description,
    required double price,
  });
}

class AdminRepoImpl implements AdminRepo {
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  final ApiDataSource apiDataSource;

  AdminRepoImpl({required this.apiDataSource});

  @override
  Future<Either<Failure, AdminEntity>> adminInfo() async {
    try {
      final String firebaseId = firebaseAuth.currentUser!.uid;
      final Uri url = Uri.parse("${ApiUrl.adminInfo}?firebaseId=$firebaseId");

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

      final adminJson = responseEither.getOrElse(() => ResponseEntity.empty);

      final adminEntity = AdminModel.fromJson(adminJson.data);

      return Right(adminEntity);
    } catch (e) {
      return Left(SystemFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> addMenu({
    required String restaurantId,
    required String menuName,
    required String description,
    required double price,
  }) async {
    try {
      final Uri url = Uri.parse(ApiUrl.addMenu);

      final responseEither = await apiDataSource.patch(
        url,
        headers: {'Content-Type': 'application/json'},
        body: {
          "restaurantId": restaurantId,
          "menuName": menuName,
          "description": description,
          "price": price,
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
  Future<Either<Failure, void>> addRestaurant({
    required String restaurantName,
  }) async {
    try {
      final String firebaseId = firebaseAuth.currentUser!.uid;
      final Uri url = Uri.parse(ApiUrl.addRestaurant);

      final responseEither = await apiDataSource.patch(
        url,
        headers: {'Content-Type': 'application/json'},
        body: {
          "firebaseId": firebaseId,
          "restaurantName": restaurantName,
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
  Future<Either<Failure, List<OrderEntity>>> orderStatus({
    required String status,
  }) async {
    try {
      final String firebaseId = firebaseAuth.currentUser!.uid;
      final Uri url = Uri.parse(
          "${ApiUrl.orderStatus}?status=$status&firebaseId=$firebaseId");

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

      final orderJson = responseEither.getOrElse(() => ResponseEntity.empty);

      final orderList = OrderModel.fromList(orderJson.data["order"]);

      return Right(orderList);
    } catch (e) {
      return Left(SystemFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> updateStatus({required String orderId}) async {
    try {
      final Uri url = Uri.parse(ApiUrl.updateStatus);

      final responseEither = await apiDataSource.patch(
        url,
        headers: {'Content-Type': 'application/json'},
        body: {
          "orderId": orderId,
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
}
