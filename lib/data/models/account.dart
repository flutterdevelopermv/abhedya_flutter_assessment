class Account {
  String id;
  String accountNumber;
  String accountType;
  double balance;
  String accountHolder;

  Account({
    required this.id,
    required this.accountNumber,
    required this.accountType,
    required this.balance,
    required this.accountHolder,
  });

  factory Account.fromMap(Map json) => Account(
        id: json["id"],
        accountNumber: json["accountNumber"],
        accountType: json["accountType"],
        balance: json["balance"]?.toDouble(),
        accountHolder: json["accountHolder"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "accountNumber": accountNumber,
        "accountType": accountType,
        "balance": balance,
        "accountHolder": accountHolder,
      };

  //
  static List<Account> getList(Map json) {
    var list = json['accounts'] as List?;
    if (list != null) {
      return list.map((e) => Account.fromMap(e as Map)).toList();
    }
    return [];
  }
}
