import 'package:order_me/src/features/data/repositories/repositories.dart';
import 'package:get_it/get_it.dart';

final repoInject = GetIt.instance;

void repoInit() {
  repoInject.registerLazySingleton<AuthRepo>(
    () => AuthRepoImpl(
      apiDataSource: repoInject(),
    ),
  );

  repoInject.registerLazySingleton<UserRepo>(
    () => UserRepoImpl(
      apiDataSource: repoInject(),
    ),
  );

  repoInject.registerLazySingleton<AdminRepo>(
    () => AdminRepoImpl(
      apiDataSource: repoInject(),
    ),
  );

  repoInject.registerLazySingleton<ServerRepo>(
    () => ServerRepoImpl(
      apiDataSource: repoInject(),
    ),
  );
}
