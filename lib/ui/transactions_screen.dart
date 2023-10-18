import 'package:abhedya_flutter_assessment/data/models/account.dart';
import 'package:abhedya_flutter_assessment/data/models/transaction.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:intl/intl.dart';

import '../data/repositories/graph_ql.dart';
import 'widgets/text_widget.dart';

class TransactionsScreen extends StatefulWidget {
  final Account account;
  const TransactionsScreen(this.account, {Key? key}) : super(key: key);

  @override
  State<TransactionsScreen> createState() => _TransactionsScreenState();
}

class _TransactionsScreenState extends State<TransactionsScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: 2);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const TextW('Transactions')),
      body: DefaultTabController(
        length: 2,
        child: Column(children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
            child: Card(
                child: ListTile(
              title: const TextW("Account number"),
              subtitle: TextW(widget.account.accountNumber, isBold: true),
              trailing: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const TextW("Balance"),
                  TextW(widget.account.balance.toStringAsFixed(2),
                      isBold: true, isHeading: true)
                ],
              ),
            )),
          ),
          const SizedBox(height: 30),
          TabBar(
              controller: _tabController,
              tabs: ["Transactions", "Details"]
                  .map((text) => TextW(
                        text,
                        padding: const EdgeInsets.only(bottom: 10),
                      ))
                  .toList()),
          Expanded(
            child: TabBarView(
                controller: _tabController,
                children: [const TransactionsView(), detailsW(widget.account)]),
          )
        ]),
      ),
    );
  }

  //
  Widget detailsW(Account account) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Table(
          border: TableBorder.all(),
          children: {
            "Account Holder": account.accountHolder,
            "Account Type": account.accountType.toUpperCase(),
            "Account Number": account.accountNumber,
            "Current Balance": account.balance.toStringAsFixed(2),
          }
              .entries
              .map((entry) => TableRow(children: [
                    TextW(entry.key,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 5, vertical: 7.5)),
                    TextW(entry.value,
                        isBold: true,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 5, vertical: 7.5)),
                  ]))
              .toList()),
    );
  }
}

//
class TransactionsView extends StatelessWidget {
  const TransactionsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Query(
        options: QueryOptions(
          fetchPolicy: FetchPolicy.networkOnly,
          document: gql(GraphQLApi
              .transactions), // this is the query string you just created
          pollInterval: const Duration(seconds: 10),
        ),
        builder: (QueryResult result,
            {VoidCallback? refetch, FetchMore? fetchMore}) {
          //  log(result.exception?.linkException?.toString())

          if (result.data != null) {
            // log(result.data.toString());
            var transactions = Transaction.getList(result.data!);
            return SingleChildScrollView(
              child: Column(
                children: [
                  for (Transaction transaction in transactions)
                    ListTile(
                        title: TextW(
                            "${transaction.fromAccount} to ${transaction.toAccount}",
                            isBold: true),
                        subtitle: TextW(transaction.description),
                        trailing: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              TextW(transaction.amount.toStringAsFixed(2),
                                  isHeading: true, isBold: true),
                              TextW(DateFormat("dd-M-yyyy")
                                  .format(transaction.date))
                            ]))
                ],
              ),
            );
          } else {
            return const TextW('Loading...');
          }
        });
  }
}
