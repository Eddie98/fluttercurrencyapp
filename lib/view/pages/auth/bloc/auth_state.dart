part of 'auth_bloc.dart';

abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

class AuthInitialState extends AuthState {
  final bool isShowPeanutAuthPage;
  final bool isShowPartnerAuthPage;

  const AuthInitialState({
    required this.isShowPeanutAuthPage,
    required this.isShowPartnerAuthPage,
  });

  @override
  List<Object> get props => [isShowPeanutAuthPage, isShowPartnerAuthPage];
}
