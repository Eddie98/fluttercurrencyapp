import 'package:testproject/utils/check_dynamics.dart';

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
  final int balance;
  final String city;
  final String country;
  final int currency;
  final int currentTradesCount;
  final int currentTradesVolume;
  final int equity;
  final int freeMargin;
  final bool isAnyOpenTrades;
  final bool isSwapFree;
  final int leverage;
  final String name;
  final String phone;
  final int totalTradesCount;
  final int totalTradesVolume;
  final int type;
  final int verificationLevel;
  final String zipCode;

  factory PeanutAccountInfo.fromMap(Map<String, dynamic> json) =>
      PeanutAccountInfo(
        address: CheckDynamics.myString(json['address']),
        balance: CheckDynamics.myInt(json['balance']),
        city: CheckDynamics.myString(json['city']),
        country: CheckDynamics.myString(json['country']),
        currency: CheckDynamics.myInt(json['currency']),
        currentTradesCount: CheckDynamics.myInt(json['currentTradesCount']),
        currentTradesVolume: CheckDynamics.myInt(json['currentTradesVolume']),
        equity: CheckDynamics.myInt(json['equity']),
        freeMargin: CheckDynamics.myInt(json['freeMargin']),
        isAnyOpenTrades: CheckDynamics.myBool(json['isAnyOpenTrades']),
        isSwapFree: CheckDynamics.myBool(json['isSwapFree']),
        leverage: CheckDynamics.myInt(json['leverage']),
        name: CheckDynamics.myString(json['name']),
        phone: CheckDynamics.myString(json['phone']),
        totalTradesCount: CheckDynamics.myInt(json['totalTradesCount']),
        totalTradesVolume: CheckDynamics.myInt(json['totalTradesVolume']),
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
