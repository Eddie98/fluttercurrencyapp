part of 'profile_bloc.dart';

abstract class ProfileState extends Equatable {
  const ProfileState();

  @override
  List<Object> get props => [];
}

class ProfileInitialState extends ProfileState {}

class ProfileLoadingState extends ProfileState {}

class ProfileErrorState extends ProfileState {}

class ProfileLoadedState extends ProfileState {
  final PeanutAccountInfo peanutAccountInfo;
  final String peanutLastFourNumbersPhone;

  const ProfileLoadedState(
    this.peanutAccountInfo,
    this.peanutLastFourNumbersPhone,
  );

  @override
  List<Object> get props => [peanutAccountInfo, peanutLastFourNumbersPhone];
}
