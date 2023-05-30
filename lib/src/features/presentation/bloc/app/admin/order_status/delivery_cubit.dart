import 'package:bloc/bloc.dart';
import 'package:order_me/src/features/data/repositories/repositories.dart';

class DeliveryCubit extends Cubit<int> {
  final AdminRepo adminRepo;

  DeliveryCubit({required this.adminRepo}) : super(0);

  Future<void> outOfDelivery() async {
    String status = "Out of delivery";

    final statusEither = await adminRepo.orderStatus(status: status);

    final order = statusEither.getOrElse(() => []);

    emit(order.length);
  }
}
