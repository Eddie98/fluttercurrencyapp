import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:testproject/models/peanut_accout_info.dart';

import '../../../../../../constants/constants.dart';
import '../../../home_repository.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final HomeRepository repository;

  ProfileBloc(this.repository) : super(ProfileInitialState()) {
    on<ProfileLoadInitialDataEvent>(homeLoadInitialDataEventHandler);
  }

  void homeLoadInitialDataEventHandler(
    ProfileLoadInitialDataEvent event,
    Emitter<ProfileState> emit,
  ) async {
    final prefs = await SharedPreferences.getInstance();
    final peanutLogin = prefs.getInt(keyPeanutLogin)!;
    final peanutToken = prefs.getString(keyPeanutToken)!;

    emit(ProfileLoadingState());

    try {
      Response accInfoResponse = await repository.peanutGetAccountInformation(
        login: peanutLogin,
        token: peanutToken,
      );

      Response phoneNumResponse =
          await repository.peanutGetLastFourNumbersPhone(
        login: peanutLogin,
        token: peanutToken,
      );

      final accInfo = PeanutAccountInfo.fromMap(accInfoResponse.data);

      emit(ProfileLoadedState(accInfo, (phoneNumResponse.data as String)));
    } on DioError catch (e) {
      if (e.response!.statusCode == 401 || e.response!.statusCode == 403) {
        event.goAuth(isShowPeanutAuthPage: true);
      } else {
        event.showSnackbar(someWentWrong);
      }

      log(e.toString());

      emit(ProfileErrorState());
    }
  }
}
