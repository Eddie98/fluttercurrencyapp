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
        address: CheckDynamics.myString('address'),
        balance: CheckDynamics.myInt('balance'),
        city: CheckDynamics.myString('city'),
        country: CheckDynamics.myString('country'),
        currency: CheckDynamics.myInt('currency'),
        currentTradesCount: CheckDynamics.myInt('currentTradesCount'),
        currentTradesVolume: CheckDynamics.myInt('currentTradesVolume'),
        equity: CheckDynamics.myInt('equity'),
        freeMargin: CheckDynamics.myInt('freeMargin'),
        isAnyOpenTrades: CheckDynamics.myBool('isAnyOpenTrades'),
        isSwapFree: CheckDynamics.myBool('isSwapFree'),
        leverage: CheckDynamics.myInt('leverage'),
        name: CheckDynamics.myString('name'),
        phone: CheckDynamics.myString('phone'),
        totalTradesCount: CheckDynamics.myInt('totalTradesCount'),
        totalTradesVolume: CheckDynamics.myInt('totalTradesVolume'),
        type: CheckDynamics.myInt('type'),
        verificationLevel: CheckDynamics.myInt('verificationLevel'),
        zipCode: CheckDynamics.myString('zipCode'),
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
