import 'package:bloc/bloc.dart';
import 'package:order_me/src/features/data/repositories/repositories.dart';

class CompletedCubit extends Cubit<int> {
  final AdminRepo adminRepo;

  CompletedCubit({required this.adminRepo}) : super(0);

  Future<void> completed() async {
    String status = "Completed";

    final statusEither = await adminRepo.orderStatus(status: status);

    final order = statusEither.getOrElse(() => []);

    emit(order.length);
  }
}
