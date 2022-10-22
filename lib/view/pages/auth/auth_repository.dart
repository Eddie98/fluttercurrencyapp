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

  Future<Response> partnerAuth({
    required int login,
    required String token,
  }) async {
    final data = {'login': login, 'token': token};
    return await dio.post(
      partnerAuthUrl,
      data: data,
      options: partnerOptions,
    );
  }
}
