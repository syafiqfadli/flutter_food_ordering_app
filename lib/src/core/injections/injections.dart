export 'bloc_inject.dart';
export 'repo_inject.dart';
export 'datasources_inject.dart';

import 'package:order_me/src/core/injections/injections.dart';

void injectorInit() {
  dataSourcesInit();
  blocInit();
  repoInit();
}
