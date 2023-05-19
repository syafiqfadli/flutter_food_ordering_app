import 'package:flutter_food_ordering_app/src/features/data/datasources/api_datasource.dart';
import 'package:get_it/get_it.dart';

final datasourcesInject = GetIt.instance;

void dataSourcesInit() {
  datasourcesInject.registerLazySingleton<ApiDataSource>(
    () => ApiDataSourceImpl(),
  );
}
