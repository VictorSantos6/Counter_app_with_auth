part of 'auth_cubit.dart';

@immutable
sealed class AuthState {}

final class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class AuthLoaded extends AuthState{
  final String email;
  final String password;
  AuthLoaded({required this.email,required this.password});
}

class AuthError extends AuthState{
  final String error;
  AuthError({required this.error});
}

