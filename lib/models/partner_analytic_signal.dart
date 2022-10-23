import 'package:testproject/utils/check_dynamics.dart';

class PartnerAnalyticSignal {
  PartnerAnalyticSignal({
    required this.id,
    required this.actualTime,
    required this.comment,
    required this.pair,
    required this.cmd,
    required this.tradingSystem,
    required this.period,
    required this.price,
    required this.sl,
    required this.tp,
  });

  final int id;
  final int actualTime;
  final String comment;
  final String pair;
  final int cmd;
  final int tradingSystem;
  final String period;
  final double price;
  final double sl;
  final double tp;

  factory PartnerAnalyticSignal.fromMap(Map<String, dynamic> json) =>
      PartnerAnalyticSignal(
        id: CheckDynamics.myInt(json['Id']),
        actualTime: CheckDynamics.myInt(json['ActualTime']),
        comment: CheckDynamics.myString(json['Comment']),
        pair: CheckDynamics.myString(json['Pair']),
        cmd: CheckDynamics.myInt(json['Cmd']),
        tradingSystem: CheckDynamics.myInt(json['TradingSystem']),
        period: CheckDynamics.myString(json['Period']),
        price: CheckDynamics.myDouble(json['Price']),
        sl: CheckDynamics.myDouble(json['Sl']),
        tp: CheckDynamics.myDouble(json['Tp']),
      );

  Map<String, dynamic> toMap() => {
        'Id': id,
        'ActualTime': actualTime,
        'Comment': comment,
        'Pair': pair,
        'Cmd': cmd,
        'TradingSystem': tradingSystem,
        'Period': period,
        'Price': price,
        'Sl': sl,
        'Tp': tp,
      };
}
