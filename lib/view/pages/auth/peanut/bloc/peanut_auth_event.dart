part of 'peanut_auth_bloc.dart';

abstract class PeanutAuthEvent extends Equatable {
  const PeanutAuthEvent();

  @override
  List<Object> get props => [];
}

class PeanutInitialRequestAuthEvent extends PeanutAuthEvent {}

class PeanutSignInEvent extends PeanutAuthEvent {
  final int login;
  final String password;
  final void Function(String) showSnackbar;
  final void Function() goHome;

  const PeanutSignInEvent(
    this.login,
    this.password,
    this.showSnackbar,
    this.goHome,
  );

  @override
  List<Object> get props => [login, password, showSnackbar, goHome];
}
