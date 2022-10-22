import 'package:dio/dio.dart';

import 'dart:developer';

import '../../../constants/constants.dart';

// TODO: remove repository
class ProfileInfoRepository {
  Dio dio = Dio();

  final peanutOptions = Options(
    headers: {'Content-Type': 'application/json-patch+json'},
  );
  final partnerOptions = Options(
    headers: {'Content-Type': 'application/json'},
  );

  Future<void> getAccountInformation() async {
    try {
      Response response = await dio.post(
        peanutGetAccountInfoUrl,
        data: authData.toMap(),
        options: peanutOptions,
      );

      log(response.toString());
    } catch (e) {}
  }

  Future<void> peanutAuth() async {
    try {
      Response response = await dio.post(
        peanutAuthUrl,
        data: authData.toMap(),
        options: peanutOptions,
      );

      log(response.toString());
    } catch (e) {}
  }

  Future<void> partnerAuth() async {
    try {
      Response response = await dio.post(
        partnerAuthUrl,
        data: authData.toMap(),
        options: partnerOptions,
      );

      log(response.toString());
    } catch (e) {}
  }
}
