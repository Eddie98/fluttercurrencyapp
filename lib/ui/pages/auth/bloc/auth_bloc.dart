import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:testproject/ui/pages/auth/auth_repository.dart';

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
    on<IsShowAuthPageEvent>(isShowAuthPageEventHandler);
    on<PeanutSignInEvent>(peanutSignInEventHandler);
    on<PartnerSignInEvent>(partnerSignInEventHandler);
  }

  void isShowAuthPageEventHandler(
    IsShowAuthPageEvent event,
    Emitter<AuthInitialState> emit,
  ) {
    emit(state.copyWith(
      isShowPeanutAuthPage: event.isShowPeanutAuthPage,
      isShowPartnerAuthPage: event.isShowPartnerAuthPage,
    ));
  }

  void peanutSignInEventHandler(
    PeanutSignInEvent event,
    Emitter<AuthInitialState> emit,
  ) async {
    final prefs = await SharedPreferences.getInstance();

    try {
      Response response = await repository.peanutAuth(
        login: event.login,
        password: event.password,
      );

      if (response.data != null && response.data['result']) {
        prefs.setInt(keyPeanutLogin, event.login);
        prefs.setString(keyPeanutToken, response.data['token']);

        emit(state.copyWith(isShowPeanutAuthPage: false));

        if (event.goHome != null) event.goHome!();
      }
    } on DioError catch (e) {
      log(e.toString());
      event.showSnackbar(invalidLogPass);
    }
  }

  void partnerSignInEventHandler(
    PartnerSignInEvent event,
    Emitter<AuthInitialState> emit,
  ) async {
    final prefs = await SharedPreferences.getInstance();

    try {
      Response response = await repository.partnerAuth(
        login: event.login,
        password: event.password,
      );

      if (response.data != null && (response.data as String).isNotEmpty) {
        prefs.setInt(keyPartnerLogin, event.login);
        prefs.setString(keyPartnerToken, response.data);

        emit(state.copyWith(isShowPartnerAuthPage: false));

        if (event.goHome != null) event.goHome!();
      }
    } on DioError catch (e) {
      log(e.toString());
      event.showSnackbar(invalidLogPass);
    }
  }
}
