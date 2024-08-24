part of 'login_cubit.dart';

@immutable
sealed class LoginState {}

final class LoginInitial extends LoginState {}
final class LoginLoading extends LoginState {}
final class LoginFailure extends LoginState 
{
  final String error;
  LoginFailure(this.error);
}
final class LoginSuccess extends LoginState 
{
  final String userType;
  final Map<String, dynamic> userData;

  LoginSuccess({required this.userType, required this.userData});
}

final class AuthLoggedOut extends LoginState {}