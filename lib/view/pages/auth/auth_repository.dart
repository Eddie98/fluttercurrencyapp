import 'dart:developer';

import 'package:dio/dio.dart';

import '../../../constants/constants.dart';

class AuthRepository {
  Dio dio = Dio();

  final peanutOptions = Options(
    contentType: 'application/json-patch+json',
  );
  final partnerOptions = Options(
    headers: {'Content-Type': 'application/json'},
  );

  Future<Response> peanutAuth({
    required int login,
    required String password,
  }) async {
    final data = {'login': login, 'password': password};
    return await dio.post(
      peanutAuthUrl,
      data: data,
      options: peanutOptions,
    );
  }

  Future<Response> peanutGetAuthAccountInformation({
    required int login,
    required String token,
  }) async {
    final data = {'login': login, 'token': token};
    return await dio.post(
      peanutGetAccountInfoUrl,
      data: data,
      options: peanutOptions,
    );
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
