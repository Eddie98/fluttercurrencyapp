part of 'home_bloc.dart';

abstract class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object> get props => [];
}

class HomeInitialState extends HomeState {}

class HomeLoadingState extends HomeState {}

class HomeErrorState extends HomeState {}

class HomeLoadedState extends HomeState {
  final List<PartnerAnalyticSignal> partnerAnalyticSignals;

  const HomeLoadedState(this.partnerAnalyticSignals);

  @override
  List<Object> get props => [];
}
