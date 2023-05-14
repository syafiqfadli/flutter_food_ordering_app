import 'package:firebase_auth/firebase_auth.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_food_ordering_app/src/datasources/api_datasource.dart';
import 'package:flutter_food_ordering_app/src/errors/failures.dart';
import 'package:flutter_food_ordering_app/src/utils/utils.dart';

abstract class AuthRepo {
  Future<Either<Failure, void>> signUp({
    required String name,
    required String email,
    required String password,
  });
  Future<Either<Failure, void>> login({
    required String email,
    required String password,
  });
  Future<Either<Failure, void>> logout();
}

class AuthRepoImpl implements AuthRepo {
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  final ApiDataSource apiDataSource;

  AuthRepoImpl({required this.apiDataSource});

  @override
  Future<Either<Failure, void>> signUp({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      final Uri url = Uri.parse(ApiUrl.createUser);

      await firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      final String firebaseId = firebaseAuth.currentUser!.uid;

      final responseEither = await apiDataSource.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: {
          "firebaseId": firebaseId,
          "name": name,
          "email": email,
        },
      );

      if (responseEither.isLeft()) {
        final failure = responseEither.foldLeft<Failure>(
          const ServerFailure(),
          (previous, r) => previous,
        );
        firebaseAuth.currentUser!.delete();
        return Left(ServerFailure(message: failure.message));
      }

      return const Right(null);
    } on FirebaseAuthException catch (error) {
      return Left(ServerFailure(message: error.message!));
    } catch (error) {
      return Left(ServerFailure(message: error.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> login({
    required String email,
    required String password,
  }) async {
    try {
      await firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      return const Right(null);
    } on FirebaseAuthException catch (error) {
      return Left(ServerFailure(message: error.message!));
    }
  }

  @override
  Future<Either<Failure, void>> logout() async {
    try {
      await firebaseAuth.signOut();

      return const Right(null);
    } on FirebaseAuthException catch (error) {
      return Left(ServerFailure(message: error.message!));
    }
  }
}
