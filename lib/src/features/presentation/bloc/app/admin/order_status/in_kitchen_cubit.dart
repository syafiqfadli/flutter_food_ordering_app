import 'package:bloc/bloc.dart';
import 'package:order_me/src/features/data/repositories/repositories.dart';

class InKitchenCubit extends Cubit<int> {
  final AdminRepo adminRepo;

  InKitchenCubit({required this.adminRepo}) : super(0);

  Future<void> inKitchen() async {
    String status = "In the kitchen";

    final statusEither = await adminRepo.orderStatus(status: status);

    final order = statusEither.getOrElse(() => []);

    emit(order.length);
  }
}
