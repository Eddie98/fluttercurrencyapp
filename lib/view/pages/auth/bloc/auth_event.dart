part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<dynamic> get props => [];
}

// class InitialRequestAuthEvent extends AuthEvent {}

class IsShowAuthPageEvent extends AuthEvent {
  final bool isShowPeanutAuthPage;
  final bool isShowPartnerAuthPage;

  const IsShowAuthPageEvent({
    required this.isShowPeanutAuthPage,
    required this.isShowPartnerAuthPage,
  });

  @override
  List<dynamic> get props => [isShowPeanutAuthPage, isShowPartnerAuthPage];
}

class PeanutSignInEvent extends AuthEvent {
  final int login;
  final String password;
  final void Function(String) showSnackbar;
  final void Function()? goHome;

  const PeanutSignInEvent(
    this.login,
    this.password,
    this.showSnackbar, [
    this.goHome,
  ]);

  @override
  List<dynamic> get props => [login, password, showSnackbar, goHome];
}

class PartnerSignInEvent extends AuthEvent {
  final int login;
  final String password;
  final void Function(String) showSnackbar;
  final void Function()? goHome;

  const PartnerSignInEvent(
    this.login,
    this.password,
    this.showSnackbar, [
    this.goHome,
  ]);

  @override
  List<dynamic> get props => [login, password, showSnackbar, goHome];
}
