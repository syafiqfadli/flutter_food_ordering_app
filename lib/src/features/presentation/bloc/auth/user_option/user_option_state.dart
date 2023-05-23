part of 'user_option_cubit.dart';

abstract class UserOptionState extends Equatable {
  const UserOptionState();

  @override
  List<Object> get props => [];
}

class UserOptionLoading extends UserOptionState {}

class UserOptionInitial extends UserOptionState {}

class UserOptionIsUser extends UserOptionState {}

class UserOptionIsAdmin extends UserOptionState {}
