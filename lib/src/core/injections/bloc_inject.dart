import 'package:flutter_food_ordering_app/src/features/presentation/bloc/bloc.dart';
import 'package:get_it/get_it.dart';

final blocInject = GetIt.instance;

void blocInit() {
  blocInject.registerLazySingleton<UserOptionCubit>(
    () => UserOptionCubit(),
  );

  blocInject.registerLazySingleton<HomeCubit>(
    () => HomeCubit(userRepo: blocInject()),
  );

  blocInject.registerLazySingleton<UserInfoCubit>(
    () => UserInfoCubit(userRepo: blocInject()),
  );

  blocInject.registerLazySingleton<AdminInfoCubit>(
    () => AdminInfoCubit(adminRepo: blocInject()),
  );

  blocInject.registerLazySingleton<CheckoutOrderCubit>(
    () => CheckoutOrderCubit(userRepo: blocInject()),
  );

  blocInject.registerLazySingleton<AddToCartCubit>(
    () => AddToCartCubit(userRepo: blocInject()),
  );

  blocInject.registerLazySingleton<DeleteCartCubit>(
    () => DeleteCartCubit(
      userRepo: blocInject(),
      userInfoCubit: blocInject(),
    ),
  );

  blocInject.registerLazySingleton<DeleteMenuCubit>(
    () => DeleteMenuCubit(
      userRepo: blocInject(),
      userInfoCubit: blocInject(),
    ),
  );

  blocInject.registerLazySingleton<LoginCubit>(
    () => LoginCubit(
      authRepo: blocInject(),
      userRepo: blocInject(),
      adminRepo: blocInject(),
      serverCubit: blocInject(),
      userOptionCubit: blocInject(),
    ),
  );

  blocInject.registerLazySingleton<LogoutCubit>(
    () => LogoutCubit(authRepo: blocInject()),
  );

  blocInject.registerLazySingleton<SignUpCubit>(
    () => SignUpCubit(
      authRepo: blocInject(),
      serverCubit: blocInject(),
      userOptionCubit: blocInject(),
    ),
  );

  blocInject.registerLazySingleton<SetPageUserCubit>(
    () => SetPageUserCubit(),
  );

  blocInject.registerLazySingleton<ServerCubit>(
    () => ServerCubit(serverRepo: blocInject()),
  );
}
