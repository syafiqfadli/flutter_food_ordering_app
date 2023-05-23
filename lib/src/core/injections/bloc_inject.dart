import 'package:flutter_food_ordering_app/src/features/presentation/bloc/bloc.dart';
import 'package:get_it/get_it.dart';

final blocInject = GetIt.instance;

void blocInit() {
  blocInject.registerLazySingleton<UserOptionCubit>(
    () => UserOptionCubit(
      authRepo: blocInject(),
      userRepo: blocInject(),
      adminRepo: blocInject(),
      serverCubit: blocInject(),
    ),
  );

  blocInject.registerLazySingleton<HomeCubit>(
    () => HomeCubit(userRepo: blocInject()),
  );

  blocInject.registerLazySingleton<UserInfoCubit>(
    () => UserInfoCubit(userRepo: blocInject()),
  );

  blocInject.registerLazySingleton<CompleteOrderCubit>(
    () => CompleteOrderCubit(userRepo: blocInject()),
  );

  blocInject.registerLazySingleton<AdminInfoCubit>(
    () => AdminInfoCubit(adminRepo: blocInject()),
  );

  blocInject.registerLazySingleton<InKitchenCubit>(
    () => InKitchenCubit(adminRepo: blocInject()),
  );

  blocInject.registerLazySingleton<DeliveryCubit>(
    () => DeliveryCubit(adminRepo: blocInject()),
  );

  blocInject.registerLazySingleton<CompletedCubit>(
    () => CompletedCubit(adminRepo: blocInject()),
  );

  blocInject.registerLazySingleton<AddMenuCubit>(
    () => AddMenuCubit(adminRepo: blocInject()),
  );

  blocInject.registerLazySingleton<AddRestaurantCubit>(
    () => AddRestaurantCubit(adminRepo: blocInject()),
  );

  blocInject.registerLazySingleton<UpdateStatusCubit>(
    () => UpdateStatusCubit(adminRepo: blocInject()),
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
    () => DeleteMenuCubit(userRepo: blocInject()),
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

  blocInject.registerLazySingleton<SetPageAdminCubit>(
    () => SetPageAdminCubit(),
  );

  blocInject.registerLazySingleton<ServerCubit>(
    () => ServerCubit(serverRepo: blocInject()),
  );
}
