import 'package:bloc/bloc.dart';
import 'package:flutter_food_ordering_app/src/features/domain/entities/user/user.dart';
import 'package:flutter_food_ordering_app/src/features/data/repositories/repositories.dart';

class UserInfoCubit extends Cubit<UserEntity> {
  final AppRepo appRepo;

  UserInfoCubit({required this.appRepo}) : super(UserEntity.empty);

  Future<void> userInfo() async {
    final userEither = await appRepo.userInfo();

    final UserEntity user = userEither.getOrElse(() => UserEntity.empty);

    emit(user);
  }
}
