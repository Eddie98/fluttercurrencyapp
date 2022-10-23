import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:testproject/view/pages/home/home_repository.dart';

import '../../../../../../constants/constants.dart';
import '../../../../../../models/partner_analytic_signal.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final HomeRepository repository;

  HomeBloc(this.repository) : super(HomeInitialState()) {
    on<HomeLoadInitialDataEvent>(homeLoadInitialDataEventHandler);
  }

  void homeLoadInitialDataEventHandler(
    HomeLoadInitialDataEvent event,
    Emitter<HomeState> emit,
  ) async {
    final prefs = await SharedPreferences.getInstance();
    final partnerLogin = prefs.getInt(keyPartnerLogin)!;
    final partnerToken = prefs.getString(keyPartnerToken)!;

    emit(HomeLoadingState());

    try {
      Response response = await repository.partnerGetAnalyticSignals(
        login: partnerLogin,
        token: partnerToken,
        currencyPairs: event.currencyPairs,
        fromToMap: event.fromToMap,
      );

      final list = (response.data as List)
          .map((json) => PartnerAnalyticSignal.fromMap(json))
          .toList();

      log(list.toString());

      emit(HomeLoadedState(list));
    } on DioError catch (e) {
      if (e.response!.statusCode == 401 || e.response!.statusCode == 403) {
        event.goAuth(isShowPartnerAuthPage: true);
      } else {
        event.showSnackbar(someWentWrong);
      }

      log(e.toString());

      emit(HomeErrorState());
    }
  }
}
