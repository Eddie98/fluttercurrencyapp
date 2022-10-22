import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:testproject/data/repositories/peanut_repository.dart';

import '../../../../../constants/constants.dart';

part 'peanut_auth_event.dart';
part 'peanut_auth_state.dart';

class PeanutAuthBloc extends Bloc<PeanutAuthEvent, PeanutAuthInitialState> {
  final PeanutRepository repository;

  PeanutAuthBloc(this.repository) : super(const PeanutAuthInitialState(false)) {
    on<PeanutInitialRequestAuthEvent>(peanutInitalRequestAuthEventHandler);
    on<PeanutSignInEvent>(peanutSignInEventHandler);
  }

  void peanutInitalRequestAuthEventHandler(
    PeanutInitialRequestAuthEvent event,
    Emitter<PeanutAuthInitialState> emit,
  ) async {
    final prefs = await SharedPreferences.getInstance();

    final login = prefs.getInt(keyLogin);
    final token = prefs.getString(keyToken);

    if (login == null || token == null) {
      emit(const PeanutAuthInitialState(true));
      return;
    }

    try {
      Response response = await repository.getAccountInformation(
        login: login,
        token: token,
      );
      if (response.data != null && response.data.isNotEmpty) {
        emit(const PeanutAuthInitialState(false));
      }
    } catch (e) {
      log(e.toString());
      emit(const PeanutAuthInitialState(true));
    }
  }

  void peanutSignInEventHandler(
    PeanutSignInEvent event,
    Emitter<PeanutAuthInitialState> emit,
  ) async {
    final prefs = await SharedPreferences.getInstance();

    try {
      Response response = await repository.peanutAuth(
        login: event.login,
        password: event.password,
      );

      if (response.data['result']) {
        prefs.setInt(keyLogin, event.login);
        prefs.setString(keyToken, response.data['token']);

        emit(const PeanutAuthInitialState(false));
        event.goHome();
      }
    } on DioError catch (e) {
      log(e.toString());
      event.showSnackbar(invalidLogPass);
    }
  }
}
