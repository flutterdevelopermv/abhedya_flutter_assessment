// import 'dart:math';
import 'package:equatable/equatable.dart';

import 'transaction.dart';

class Profile extends Equatable {
  final String name;
  final String accountNumber;
  final double balance;
  final String currency;
  final Address? address;
  final List<Transaction> recentTransactions;
  final List<Transaction> upcomingBills;

  @override
  List<Object?> get props => [
        name,
        accountNumber,
        balance,
        currency,
        address,
        recentTransactions,
        upcomingBills,
      ];

  const Profile({
    required this.name,
    required this.accountNumber,
    required this.balance,
    required this.currency,
    required this.address,
    required this.recentTransactions,
    required this.upcomingBills,
  });

  factory Profile.fromMap(Map json) {
    return Profile(
      name: json["name"],
      accountNumber: json["accountNumber"],
      balance: json["balance"]?.toDouble(),
      currency: json["currency"],
      address:
          json["address"] == null ? null : Address.fromMap(json["address"]),
      recentTransactions: List<Transaction>.from(
          (json["recentTransactions"] ?? []).map((x) => Transaction.fromMap(x)))
        ..sort((a, b) => b.date.compareTo(a.date)),
      upcomingBills: List<Transaction>.from(
          (json["upcomingBills"] ?? []).map((x) => Transaction.fromMap(x)))
        ..sort((a, b) => a.date.compareTo(b.date)),
    );
  }

  //
}

class Address {
  String streetName;
  String buildingNumber;
  String townName;
  String postCode;
  String country;

  Address({
    required this.streetName,
    required this.buildingNumber,
    required this.townName,
    required this.postCode,
    required this.country,
  });

  factory Address.fromMap(Map<String, dynamic> json) => Address(
        streetName: json["streetName"],
        buildingNumber: json["buildingNumber"],
        townName: json["townName"],
        postCode: json["postCode"],
        country: json["country"],
      );

  Map<String, dynamic> toMap() => {
        "streetName": streetName,
        "buildingNumber": buildingNumber,
        "townName": townName,
        "postCode": postCode,
        "country": country,
      };
}
