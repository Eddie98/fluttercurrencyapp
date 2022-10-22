part of 'peanut_auth_bloc.dart';

abstract class PeanutAuthState extends Equatable {
  const PeanutAuthState();

  @override
  List<Object> get props => [];
}

class PeanutAuthInitialState extends PeanutAuthState {
  final bool isShowAuthPage;

  const PeanutAuthInitialState(this.isShowAuthPage);

  @override
  List<Object> get props => [isShowAuthPage];
}
