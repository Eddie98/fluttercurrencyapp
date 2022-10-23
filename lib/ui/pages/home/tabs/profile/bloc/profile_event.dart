part of 'profile_bloc.dart';

abstract class ProfileEvent extends Equatable {
  const ProfileEvent();

  @override
  List<Object> get props => [];
}

class ProfileLoadInitialDataEvent extends ProfileEvent {
  final void Function({
    bool? isShowPeanutAuthPage,
    bool? isShowPartnerAuthPage,
  }) goAuth;
  final void Function(String text) showSnackbar;

  const ProfileLoadInitialDataEvent({
    required this.goAuth,
    required this.showSnackbar,
  });

  @override
  List<Object> get props => [goAuth, showSnackbar];
}
