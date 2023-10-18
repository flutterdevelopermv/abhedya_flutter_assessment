// import 'dart:math';
import 'transaction.dart';

class Profile {
  String name;
  String accountNumber;
  double balance;
  String currency;
  Address address;
  List<Transaction> recentTransactions;
  List<Transaction> upcomingBills;

  Profile({
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
      address: Address.fromMap(json["address"]),
      recentTransactions: List<Transaction>.from(
          (json["recentTransactions"] ?? []).map((x) => Transaction.fromMap(x)))
        ..sort((a, b) => b.date.compareTo(a.date)),
      upcomingBills: List<Transaction>.from(
          (json["upcomingBills"] ?? []).map((x) => Transaction.fromMap(x)))
        ..sort((a, b) => a.date.compareTo(b.date)),
    );
  }

  Map<String, dynamic> toMap() => {
        "name": name,
        "accountNumber": accountNumber,
        "balance": balance,
        "currency": currency,
        "address": address.toMap(),
      };

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
