part of 'login_cubit.dart';

@immutable
abstract class LoginState {}

class LoginInitial extends LoginState {}

class LoginLoading extends LoginState {}

class LoginSuccess extends LoginState {
  final String msg;
  final User user;

  LoginSuccess(this.msg, this.user);
}

class LoginFailure extends LoginState {
  final String msg;

  LoginFailure(this.msg);
}
