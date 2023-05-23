import 'package:bloc/bloc.dart';
import 'package:flutter_food_ordering_app/src/features/domain/entities/entities.dart';
import 'package:flutter_food_ordering_app/src/features/data/repositories/repositories.dart';

class AdminInfoCubit extends Cubit<AdminEntity> {
  final AdminRepo adminRepo;

  AdminInfoCubit({
    required this.adminRepo,
  }) : super(AdminEntity.empty);

  Future<void> adminInfo() async {
    final adminEither = await adminRepo.adminInfo();

    final AdminEntity admin = adminEither.getOrElse(() => AdminEntity.empty);

    emit(admin);
  }
}
