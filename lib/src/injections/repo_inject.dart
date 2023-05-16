import 'package:flutter_food_ordering_app/src/repositories/repositories.dart';
import 'package:get_it/get_it.dart';

final repoInject = GetIt.instance;

void repoInit() {
  repoInject.registerLazySingleton<AuthRepo>(
    () => AuthRepoImpl(
      apiDataSource: repoInject(),
    ),
  );

  repoInject.registerLazySingleton<AppRepo>(
    () => AppRepoImpl(
      apiDataSource: repoInject(),
    ),
  );

  repoInject.registerLazySingleton<ServerRepo>(
    () => ServerRepoImpl(
      apiDataSource: repoInject(),
    ),
  );
}
