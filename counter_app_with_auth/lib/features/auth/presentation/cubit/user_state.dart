part of 'user_cubit.dart';

@immutable
sealed class UserState {}

final class UserInitial extends UserState {}

class UserLoading extends UserState{}

class UserLoaded extends UserState{
  final UserEntity user;

  UserLoaded({required this.user});
}

class UserError extends UserState{
  final String error;

  UserError({required this.error});
}