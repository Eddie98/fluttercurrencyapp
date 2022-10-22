part of 'home_bloc.dart';

abstract class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object> get props => [];
}

class HomeLoadInitialDataEvent extends HomeEvent {
  final String currencyPairs;
  final Map<String, int> fromToMap;

  const HomeLoadInitialDataEvent({
    required this.currencyPairs,
    required this.fromToMap,
  });

  @override
  List<Object> get props => [currencyPairs, fromToMap];
}
