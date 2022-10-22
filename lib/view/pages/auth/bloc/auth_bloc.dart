import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:testproject/view/pages/auth/auth_repository.dart';

import '../../../../../constants/constants.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthInitialState> {
  final AuthRepository repository;

  AuthBloc(this.repository)
      : super(const AuthInitialState(
          isShowPeanutAuthPage: false,
          isShowPartnerAuthPage: false,
        )) {
    on<InitialRequestAuthEvent>(initalRequestAuthEventHandler);
    on<SignInEvent>(signInEventHandler);
  }

  void initalRequestAuthEventHandler(
    InitialRequestAuthEvent event,
    Emitter<AuthInitialState> emit,
  ) async {
    final prefs = await SharedPreferences.getInstance();

    final login = prefs.getInt(keyLogin);
    final token = prefs.getString(keyToken);

    if (login == null || token == null) {
      emit(const AuthInitialState(
        isShowPeanutAuthPage: true,
        isShowPartnerAuthPage: true,
      ));
      return;
    }

    try {
      Response response = await repository.peanutGetAuthAccountInformation(
        login: login,
        token: token,
      );
      if (response.data != null && response.data.isNotEmpty) {
        emit(const AuthInitialState(
          isShowPeanutAuthPage: false,
          isShowPartnerAuthPage: false,
        ));
      }
    } catch (e) {
      log(e.toString());
      emit(const AuthInitialState(
        isShowPeanutAuthPage: true,
        isShowPartnerAuthPage: true,
      ));
    }
  }

  void signInEventHandler(
    SignInEvent event,
    Emitter<AuthInitialState> emit,
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

        emit(const AuthInitialState(
          isShowPeanutAuthPage: false,
          isShowPartnerAuthPage: false,
        ));
        event.goHome();
      }
    } on DioError catch (e) {
      log(e.toString());
      event.showSnackbar(invalidLogPass);
    }
  }
}
