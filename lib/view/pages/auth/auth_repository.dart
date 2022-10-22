import 'package:dio/dio.dart';

import '../../../constants/constants.dart';

class AuthRepository {
  Dio dio = Dio();

  final peanutOptions = Options(
    contentType: 'application/json-patch+json',
  );
  final partnerOptions = Options(
    contentType: 'application/json',
  );

  Future<Response> peanutAuth({
    required int login,
    required String password,
  }) async =>
      await dio.post(
        peanutAuthUrl,
        data: {'login': login, 'password': password},
        options: peanutOptions,
      );

  Future<Response> partnerAuth({
    required int login,
    required String password,
  }) async =>
      await dio.post(
        partnerAuthUrl,
        data: {'login': login, 'password': password},
        options: partnerOptions,
      );
}
