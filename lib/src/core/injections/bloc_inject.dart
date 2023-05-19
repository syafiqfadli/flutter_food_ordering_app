import 'package:flutter_food_ordering_app/src/features/presentation/bloc/bloc.dart';
import 'package:get_it/get_it.dart';

final blocInject = GetIt.instance;

void blocInit() {
  blocInject.registerLazySingleton<HomeCubit>(
    () => HomeCubit(appRepo: blocInject()),
  );

  blocInject.registerLazySingleton<UserInfoCubit>(
    () => UserInfoCubit(appRepo: blocInject()),
  );

  blocInject.registerLazySingleton<CheckoutOrderCubit>(
    () => CheckoutOrderCubit(appRepo: blocInject()),
  );

  blocInject.registerLazySingleton<AddToCartCubit>(
    () => AddToCartCubit(appRepo: blocInject()),
  );

  blocInject.registerLazySingleton<DeleteCartCubit>(
    () => DeleteCartCubit(
      appRepo: blocInject(),
      userInfoCubit: blocInject(),
    ),
  );

  blocInject.registerLazySingleton<DeleteMenuCubit>(
    () => DeleteMenuCubit(
      appRepo: blocInject(),
      userInfoCubit: blocInject(),
    ),
  );

  blocInject.registerLazySingleton<LoginCubit>(
    () => LoginCubit(
      authRepo: blocInject(),
      appRepo: blocInject(),
      serverCubit: blocInject(),
    ),
  );

  blocInject.registerLazySingleton<LogoutCubit>(
    () => LogoutCubit(authRepo: blocInject()),
  );

  blocInject.registerLazySingleton<SignUpCubit>(
    () => SignUpCubit(authRepo: blocInject(), serverCubit: blocInject()),
  );

  blocInject.registerLazySingleton<SetPageCubit>(
    () => SetPageCubit(),
  );

  blocInject.registerLazySingleton<ServerCubit>(
    () => ServerCubit(serverRepo: blocInject()),
  );
}
