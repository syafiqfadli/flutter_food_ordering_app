import 'package:bloc/bloc.dart';
import 'package:order_me/src/features/data/repositories/repositories.dart';
import 'package:order_me/src/features/domain/entities/entities.dart';

class UserInfoCubit extends Cubit<UserEntity> {
  final UserRepo userRepo;

  UserInfoCubit({required this.userRepo}) : super(UserEntity.empty);

  Future<void> userInfo() async {
    final userEither = await userRepo.userInfo();

    final UserEntity user = userEither.getOrElse(() => UserEntity.empty);

    emit(user);
  }
}
