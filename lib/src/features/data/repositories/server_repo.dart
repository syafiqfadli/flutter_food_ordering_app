import 'package:dartz/dartz.dart';
import 'package:order_me/src/features/data/datasources/api_datasource.dart';
import 'package:order_me/src/core/errors/failures.dart';
import 'package:order_me/src/core/utils/utils.dart';

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
        final failure = responseEither.swap().getOrElse(
              () => const SystemFailure(),
            );

        return Left(SystemFailure(message: failure.message));
      }

      return const Right(null);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }
}
