import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';

import '../../../../../../constants/constants.dart';
import '../../../home_repository.dart';

part 'promotions_event.dart';
part 'promotions_state.dart';

class PromotionsBloc extends Bloc<PromotionsEvent, PromotionsState> {
  final HomeRepository repository;

  PromotionsBloc(this.repository) : super(PromotionsInitialState()) {
    on<PromotionsLoadInitialDataEvent>(promotionsLoadInitialDataEventHandler);
  }

  void promotionsLoadInitialDataEventHandler(
    PromotionsLoadInitialDataEvent event,
    Emitter<PromotionsState> emit,
  ) async {
    emit(PromotionsLoadingState());

    try {
      // http.Response response =
      //     await repository.promotionsGetCabinetMicroService();
      // final document = XmlDocument.parse(response.data);
      // final titles = document.findAllElements('GetCCPromo');

      // titles.map((node) => node.text).forEach(print);

      // log(document.toXmlString(pretty: true, indent: '\t'));

      // log(response.body.toString());

      // emit(PromotionsLoadedState(list));
    } on DioError catch (e) {
      event.showSnackbar(someWentWrong);

      log(e.toString());

      emit(PromotionsErrorState());
    }
  }
}
