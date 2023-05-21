import 'package:bloc/bloc.dart';
import 'package:flutter_food_ordering_app/src/features/domain/entities/entities.dart';
import 'package:flutter_food_ordering_app/src/features/data/repositories/repositories.dart';
import 'package:flutter_food_ordering_app/src/features/presentation/bloc/bloc.dart';

class AdminInfoCubit extends Cubit<AdminEntity> {
  final AdminRepo adminRepo;
  final InKitchenCubit inKitchenCubit;
  final DeliveryCubit deliveryCubit;
  final CompletedCubit completedCubit;

  AdminInfoCubit({
    required this.adminRepo,
    required this.inKitchenCubit,
    required this.deliveryCubit,
    required this.completedCubit,
  }) : super(AdminEntity.empty);

  Future<void> adminInfo() async {
    final adminEither = await adminRepo.adminInfo();

    await inKitchenCubit.inKitchen();
    await deliveryCubit.outOfDelivery();
    await completedCubit.completed();

    final AdminEntity admin = adminEither.getOrElse(() => AdminEntity.empty);

    emit(admin);
  }
}
