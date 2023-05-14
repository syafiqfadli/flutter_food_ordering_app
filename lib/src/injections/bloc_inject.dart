import 'package:flutter_food_ordering_app/src/bloc/bloc.dart';
import 'package:get_it/get_it.dart';

final blocInject = GetIt.instance;

void blocInit() {
  blocInject.registerLazySingleton<LoginCubit>(
    () => LoginCubit(authRepo: blocInject()),
  );

  blocInject.registerLazySingleton<LogoutCubit>(
    () => LogoutCubit(authRepo: blocInject()),
  );

  blocInject.registerLazySingleton<SignUpCubit>(
    () => SignUpCubit(authRepo: blocInject()),
  );

  blocInject.registerLazySingleton<SetPageCubit>(
    () => SetPageCubit(),
  );
}
