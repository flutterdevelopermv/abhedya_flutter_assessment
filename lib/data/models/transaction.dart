class Transaction {
  DateTime date;
  String description;
  double amount;
  String fromAccount;
  String toAccount;

  Transaction({
    required this.date,
    required this.description,
    required this.amount,
    required this.fromAccount,
    required this.toAccount,
  });

  factory Transaction.fromMap(Map json) => Transaction(
        date: DateTime.parse(json["date"]),
        description: json["description"],
        amount: json["amount"]?.toDouble(),
        fromAccount: json["fromAccount"],
        toAccount: json["toAccount"],
      );

  Map<String, dynamic> toMap() => {
        "date":
            "${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}",
        "description": description,
        "amount": amount,
        "fromAccount": fromAccount,
        "toAccount": toAccount,
      };

  static List<Transaction> getList(Map json) {
    var list = json['transactions'] as List?;
    if (list != null) {
      return list.map((e) => Transaction.fromMap(e as Map)).toList()
        ..sort((a, b) => b.date.compareTo(a.date));
    }
    return [];
  }
}
