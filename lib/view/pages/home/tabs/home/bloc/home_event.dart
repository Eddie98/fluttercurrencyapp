part of 'home_bloc.dart';

abstract class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object> get props => [];
}

class HomeLoadInitialDataEvent extends HomeEvent {
  final String currencyPairs;
  final Map<String, int> fromToMap;
  final void Function({
    bool? isShowPeanutAuthPage,
    bool? isShowPartnerAuthPage,
  }) goAuth;
  final void Function(String text) showSnackbar;

  const HomeLoadInitialDataEvent({
    required this.currencyPairs,
    required this.fromToMap,
    required this.goAuth,
    required this.showSnackbar,
  });

  @override
  List<Object> get props => [currencyPairs, fromToMap, goAuth, showSnackbar];
}
