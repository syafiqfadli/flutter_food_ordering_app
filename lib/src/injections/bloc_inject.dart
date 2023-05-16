import 'package:flutter_food_ordering_app/src/bloc/bloc.dart';
import 'package:get_it/get_it.dart';

final blocInject = GetIt.instance;

void blocInit() {
  blocInject.registerLazySingleton<UserInfoCubit>(
    () => UserInfoCubit(appRepo: blocInject()),
  );

  blocInject.registerLazySingleton<CheckoutOrderCubit>(
    () => CheckoutOrderCubit(appRepo: blocInject()),
  );

  blocInject.registerLazySingleton<LoginCubit>(
    () => LoginCubit(authRepo: blocInject(), appRepo: blocInject()),
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

  blocInject.registerLazySingleton<ServerCubit>(
    () => ServerCubit(
      serverRepo: blocInject(),
      loginCubit: blocInject(),
      signUpCubit: blocInject(),
    ),
  );
}
