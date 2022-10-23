part of 'promotions_bloc.dart';

abstract class PromotionsEvent extends Equatable {
  const PromotionsEvent();

  @override
  List<Object> get props => [];
}

class PromotionsLoadInitialDataEvent extends PromotionsEvent {
  final void Function(String text) showSnackbar;

  const PromotionsLoadInitialDataEvent({
    required this.showSnackbar,
  });

  @override
  List<Object> get props => [showSnackbar];
}
