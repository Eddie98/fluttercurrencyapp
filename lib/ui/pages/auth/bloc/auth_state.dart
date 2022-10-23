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

  AuthInitialState copyWith({
    bool? isShowPeanutAuthPage,
    bool? isShowPartnerAuthPage,
  }) =>
      AuthInitialState(
        isShowPeanutAuthPage: isShowPeanutAuthPage ?? this.isShowPeanutAuthPage,
        isShowPartnerAuthPage:
            isShowPartnerAuthPage ?? this.isShowPartnerAuthPage,
      );

  @override
  List<Object> get props => [isShowPeanutAuthPage, isShowPartnerAuthPage];
}
