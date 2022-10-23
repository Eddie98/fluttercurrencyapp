part of 'promotions_bloc.dart';

abstract class PromotionsState extends Equatable {
  const PromotionsState();

  @override
  List<Object> get props => [];
}

class PromotionsInitialState extends PromotionsState {}

class PromotionsLoadingState extends PromotionsState {}

class PromotionsErrorState extends PromotionsState {}

class PromotionsLoadedState extends PromotionsState {
  // final List<PartnerAnalyticSignal> partnerAnalyticSignals;

  // const PromotionsLoadedState(this.partnerAnalyticSignals);

  // @override
  // List<Object> get props => [partnerAnalyticSignals];
}
