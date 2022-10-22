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
    // on<InitialRequestAuthEvent>(initalRequestAuthEventHandler);
    on<IsShowAuthPageEvent>(isShowAuthPageEventHandler);
    on<PeanutSignInEvent>(peanutSignInEventHandler);
    on<PartnerSignInEvent>(partnerSignInEventHandler);
  }

  // void initalRequestAuthEventHandler(
  //   InitialRequestAuthEvent event,
  //   Emitter<AuthInitialState> emit,
  // ) async {
  //   final prefs = await SharedPreferences.getInstance();

  //   // TODO one of auth pages or both, copyWith
  //   final peanutLogin = prefs.getInt(keyPeanutLogin);
  //   final peanutToken = prefs.getString(keyPeanutToken);

  //   final partnerLogin = prefs.getInt(keyPeanutLogin);
  //   final partnerToken = prefs.getString(keyPeanutToken);

  //   if (peanutLogin == null ||
  //       peanutToken == null ||
  //       partnerLogin == null ||
  //       partnerToken == null) {
  //     if (peanutLogin == null || peanutToken == null) {
  //       emit(state.copyWith(isShowPeanutAuthPage: true));
  //     }
  //     if (partnerLogin == null || partnerToken == null) {
  //       emit(state.copyWith(isShowPeanutAuthPage: true));
  //     }
  //     return;
  //   }

  //   try {
  //     Response response = await repository.peanutGetAuthAccountInformation(
  //       login: peanutLogin,
  //       token: peanutToken,
  //     );
  //     if (response.data != null && (response.data as String).isNotEmpty) {
  //       emit(const AuthInitialState(
  //         isShowPeanutAuthPage: false,
  //         isShowPartnerAuthPage: false,
  //       ));
  //     }
  //   } catch (e) {
  //     log(e.toString());
  //     emit(const AuthInitialState(
  //       isShowPeanutAuthPage: true,
  //       isShowPartnerAuthPage: true,
  //     ));
  //   }
  // }

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
