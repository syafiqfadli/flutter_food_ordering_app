import 'package:dartz/dartz.dart';
import 'package:flutter_food_ordering_app/src/datasources/api_datasource.dart';
import 'package:flutter_food_ordering_app/src/errors/failures.dart';
import 'package:flutter_food_ordering_app/src/utils/utils.dart';

abstract class ServerRepo {
  Future<Either<Failure, void>> isServerOnline();
}

class ServerRepoImpl implements ServerRepo {
  final ApiDataSource apiDataSource;

  ServerRepoImpl({required this.apiDataSource});

  @override
  Future<Either<Failure, void>> isServerOnline() async {
    try {
      final Uri url = Uri.parse(ApiUrl.serverStatus);

      final responseEither = await apiDataSource.get(
        url,
        headers: {'Content-Type': 'application/json'},
      );

      if (responseEither.isLeft()) {
        return const Left(ServerFailure(message: "Server Offline"));
      }

      return const Right(null);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }
}
