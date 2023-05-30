import 'package:firebase_auth/firebase_auth.dart';
import 'package:dartz/dartz.dart';
import 'package:order_me/src/features/data/datasources/api_datasource.dart';
import 'package:order_me/src/core/errors/failures.dart';
import 'package:order_me/src/core/utils/utils.dart';

abstract class AuthRepo {
  Future<Either<Failure, void>> signUp({
    required bool isUser,
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
    required bool isUser,
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      final Uri url =
          isUser ? Uri.parse(ApiUrl.createUser) : Uri.parse(ApiUrl.createAdmin);

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
        final failure = responseEither.swap().getOrElse(
              () => const SystemFailure(),
            );

        firebaseAuth.currentUser!.delete();
        return Left(SystemFailure(message: failure.message));
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
      await logout();

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
