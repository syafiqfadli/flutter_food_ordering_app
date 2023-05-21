import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_food_ordering_app/src/core/errors/failures.dart';
import 'package:flutter_food_ordering_app/src/core/utils/utils.dart';
import 'package:flutter_food_ordering_app/src/features/data/datasources/api_datasource.dart';
import 'package:flutter_food_ordering_app/src/features/data/models/models.dart';
import 'package:flutter_food_ordering_app/src/features/domain/entities/entities.dart';

abstract class AdminRepo {
  Future<Either<Failure, AdminEntity>> adminInfo();
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
}
