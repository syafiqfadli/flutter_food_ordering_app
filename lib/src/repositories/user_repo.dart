import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_food_ordering_app/src/datasources/api_datasource.dart';
import 'package:flutter_food_ordering_app/src/entities/entities.dart';
import 'package:flutter_food_ordering_app/src/errors/failures.dart';
import 'package:flutter_food_ordering_app/src/models/models.dart';
import 'package:flutter_food_ordering_app/src/utils/utils.dart';

abstract class UserRepo {
  Future<Either<Failure, UserEntity>> userInfo();
}

class UserRepoImpl implements UserRepo {
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  final ApiDataSource apiDataSource;

  UserRepoImpl({required this.apiDataSource});

  @override
  Future<Either<Failure, UserEntity>> userInfo() async {
    try {
      final String firebaseId = firebaseAuth.currentUser!.uid;
      final Uri url = Uri.parse("${ApiUrl.userInfo}?firebaseId=$firebaseId");

      final responseEither = await apiDataSource.get(url);

      if (responseEither.isLeft()) {
        final failure = responseEither.foldLeft<Failure>(
          const ServerFailure(),
          (previous, r) => previous,
        );

        return Left(failure);
      }

      final userJson = responseEither.getOrElse(() => ResponseEntity.empty);

      final userEntity = UserModel.fromJson(userJson.data);

      return Right(userEntity);
    } catch (e) {
      return Left(SystemFailure(message: e.toString()));
    }
  }
}
