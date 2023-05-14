export 'bloc_inject.dart';
export 'repo_inject.dart';
export 'datasources_inject.dart';

import 'package:flutter_food_ordering_app/src/injections/injections.dart';

void injectorInit() {
  dataSourcesInit();
  blocInit();
  repoInit();
}
