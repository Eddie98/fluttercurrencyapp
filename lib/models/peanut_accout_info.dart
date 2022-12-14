import '../utils/check_dynamics.dart';

class PeanutAccountInfo {
  PeanutAccountInfo({
    required this.address,
    required this.balance,
    required this.city,
    required this.country,
    required this.currency,
    required this.currentTradesCount,
    required this.currentTradesVolume,
    required this.equity,
    required this.freeMargin,
    required this.isAnyOpenTrades,
    required this.isSwapFree,
    required this.leverage,
    required this.name,
    required this.phone,
    required this.totalTradesCount,
    required this.totalTradesVolume,
    required this.type,
    required this.verificationLevel,
    required this.zipCode,
  });

  final String address;
  final double balance;
  final String city;
  final String country;
  final int currency;
  final double currentTradesCount;
  final double currentTradesVolume;
  final double equity;
  final double freeMargin;
  final bool isAnyOpenTrades;
  final bool isSwapFree;
  final int leverage;
  final String name;
  final String phone;
  final int totalTradesCount;
  final double totalTradesVolume;
  final int type;
  final int verificationLevel;
  final String zipCode;

  factory PeanutAccountInfo.fromMap(Map<String, dynamic> json) =>
      PeanutAccountInfo(
        address: CheckDynamics.myString(json['address']),
        balance: CheckDynamics.myDouble(json['balance']),
        city: CheckDynamics.myString(json['city']),
        country: CheckDynamics.myString(json['country']),
        currency: CheckDynamics.myInt(json['currency']),
        currentTradesCount: CheckDynamics.myDouble(json['currentTradesCount']),
        currentTradesVolume:
            CheckDynamics.myDouble(json['currentTradesVolume']),
        equity: CheckDynamics.myDouble(json['equity']),
        freeMargin: CheckDynamics.myDouble(json['freeMargin']),
        isAnyOpenTrades: CheckDynamics.myBool(json['isAnyOpenTrades']),
        isSwapFree: CheckDynamics.myBool(json['isSwapFree']),
        leverage: CheckDynamics.myInt(json['leverage']),
        name: CheckDynamics.myString(json['name']),
        phone: CheckDynamics.myString(json['phone']),
        totalTradesCount: CheckDynamics.myInt(json['totalTradesCount']),
        totalTradesVolume: CheckDynamics.myDouble(json['totalTradesVolume']),
        type: CheckDynamics.myInt(json['type']),
        verificationLevel: CheckDynamics.myInt(json['verificationLevel']),
        zipCode: CheckDynamics.myString(json['zipCode']),
      );

  Map<String, dynamic> toMap() => {
        'address': address,
        'balance': balance,
        'city': city,
        'country': country,
        'currency': currency,
        'currentTradesCount': currentTradesCount,
        'currentTradesVolume': currentTradesVolume,
        'equity': equity,
        'freeMargin': freeMargin,
        'isAnyOpenTrades': isAnyOpenTrades,
        'isSwapFree': isSwapFree,
        'leverage': leverage,
        'name': name,
        'phone': phone,
        'totalTradesCount': totalTradesCount,
        'totalTradesVolume': totalTradesVolume,
        'type': type,
        'verificationLevel': verificationLevel,
        'zipCode': zipCode,
      };
}
