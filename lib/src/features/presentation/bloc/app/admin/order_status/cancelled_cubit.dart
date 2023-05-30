import 'package:bloc/bloc.dart';
import 'package:order_me/src/features/data/repositories/repositories.dart';

class CancelledCubit extends Cubit<int> {
  final AdminRepo adminRepo;

  CancelledCubit({required this.adminRepo}) : super(0);

  Future<void> cancelled() async {
    String status = "Cancelled";

    final statusEither = await adminRepo.orderStatus(status: status);

    final order = statusEither.getOrElse(() => []);

    emit(order.length);
  }
}
