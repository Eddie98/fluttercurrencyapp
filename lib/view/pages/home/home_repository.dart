import 'package:dio/dio.dart';

import '../../../constants/constants.dart';

class HomeRepository {
  Dio dio = Dio();

  final peanutOptions = Options(
    contentType: 'application/json-patch+json',
  );

  Future<Response> peanutGetAccountInformation({
    required int login,
    required String token,
  }) async =>
      await dio.post(
        peanutGetAccountInfoUrl,
        data: {'login': login, 'token': token},
        options: peanutOptions,
      );

  Future<Response> peanutGetLastFourNumbersPhone({
    required int login,
    required String token,
  }) async =>
      await dio.post(
        peanutGetLastFourNumbersPhoneUrl,
        data: {'login': login, 'token': token},
        options: peanutOptions,
      );

  Future<Response> partnerGetAnalyticSignals({
    required int login,
    required String token,
    required String currencyPairs,
    required Map<String, int> fromToMap,
  }) async =>
      await dio.get(
        '$partnerGetAnalyticSignalsUrl/$login',
        queryParameters: {
          'tradingsystem': 3,
          'pairs': currencyPairs,
          'from': fromToMap['from'],
          'to': fromToMap['to'],
        },
        options: Options(
          contentType: 'application/json',
          headers: {'passkey': token},
        ),
      );
}
