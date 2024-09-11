part of 'sign_up_cubit.dart';

@immutable
sealed class SignUpState {}

class SignUpInitial extends SignUpState {}

class SignUpLoading extends SignUpState {}

class SignUpFailure extends SignUpState 
{
  final String error;
  SignUpFailure(this.error);
}

class SignUpSuccess extends SignUpState {}
