part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class InitialRequestAuthEvent extends AuthEvent {}

class SignInEvent extends AuthEvent {
  final int login;
  final String password;
  final void Function(String) showSnackbar;
  final void Function() goHome;

  const SignInEvent(
    this.login,
    this.password,
    this.showSnackbar,
    this.goHome,
  );

  @override
  List<Object> get props => [login, password, showSnackbar, goHome];
}
