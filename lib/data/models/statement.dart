import 'package:intl/intl.dart';

class Statement {
  DateTime date;
  String description;
  double amount;

  Statement({
    required this.date,
    required this.description,
    required this.amount,
  });

  factory Statement.fromMap(Map json) => Statement(
        date: DateFormat("yyyy-MM-dd").parse(json["date"]),
        description: json["description"],
        amount: json["amount"]?.toDouble(),
      );

  // Map<String, dynamic> toMap() => {
  //       "date": date,
  //       "description": description,
  //       "amount": amount,
  //     };

  static List<Statement> getList(Map json) {
    var list = json['statements'] as List?;
    if (list != null) {
      return list.map((e) => Statement.fromMap(e as Map)).toList()
        ..sort((a, b) => a.date.compareTo(b.date));
    }
    return [];
  }

  //
  static Map<int, List<Statement>> sortedMapList(List<Statement> list) {
    list.sort((a, b) => b.date.compareTo(a.date));
    Map<int, List<Statement>> yearwiseSortedStatements = {};
    for (var statement in list) {
      int year = statement.date.year;
      if (yearwiseSortedStatements.keys.contains(year)) {
        yearwiseSortedStatements[year]!.add(statement);
      } else {
        yearwiseSortedStatements[year] = [statement];
      }
    }
    return yearwiseSortedStatements;
  }
}
