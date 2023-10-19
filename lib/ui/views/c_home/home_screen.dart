import 'package:abhedya_flutter_assessment/ui/widgets/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:intl/intl.dart';

import '../../../data/models/profile.dart';
import '../../../data/repositories/graph_ql.dart';

class HomeScreen extends StatelessWidget {
  final String username;
  const HomeScreen(this.username, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const TextW("Home")),
      body: Query(
          options: QueryOptions(
            fetchPolicy: FetchPolicy.networkOnly,
            document: gql(
                GraphQLApi.home), // this is the query string you just created
            pollInterval: const Duration(seconds: 10),
          ),
          builder: (QueryResult result,
              {VoidCallback? refetch, FetchMore? fetchMore}) {
            //  log(result.exception?.linkException?.toString())
            if (result.data != null) {
              // log(result.data.toString());
              var profile = Profile.fromMap(result.data!['home']);
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: SingleChildScrollView(
                  child: Column(children: [
                    Align(
                      alignment: Alignment.topLeft,
                      child: TextW(username,
                          textScaleFactor: 1.5,
                          isBold: true,
                          color: Colors.red),
                    ),
                    Card(
                        child: Column(
                      children: [
                        TextW(profile.name, textScaleFactor: 1.5, isBold: true),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const TextW("Account Number : "),
                            TextW(profile.accountNumber, isBold: true),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const TextW("Balance : "),
                            TextW(
                                "${profile.currency} ${profile.balance.toStringAsFixed(2)}",
                                isBold: true),
                          ],
                        ),
                      ]
                          .map((e) => Padding(
                              padding: const EdgeInsets.all(5), child: e))
                          .toList(),
                    )),
                    Card(
                      child: ExpansionTile(
                        shape: const Border(),
                        title: const TextW("Recent Transactions",
                            isBold: true, color: Colors.blue),
                        childrenPadding: const EdgeInsets.only(left: 10),
                        initiallyExpanded: true,
                        children: [
                          for (var recentTransaction
                              in profile.recentTransactions)
                            ListTile(
                              title: TextW(
                                  "${recentTransaction.fromAccount} to ${recentTransaction.toAccount}",
                                  isBold: true),
                              subtitle: TextW(recentTransaction.description),
                              trailing: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    TextW(
                                        recentTransaction.amount
                                            .toStringAsFixed(2),
                                        isHeading: true,
                                        isBold: true),
                                    TextW(DateFormat("dd-M-yyyy")
                                        .format(recentTransaction.date))
                                  ]),
                            ),
                        ],
                      ),
                    ),
                    Card(
                      child: ExpansionTile(
                        shape: const Border(),
                        title: const TextW("Upcoming Bills",
                            isBold: true, color: Colors.red),
                        childrenPadding: const EdgeInsets.only(left: 10),
                        initiallyExpanded: true,
                        children: [
                          for (var upcomingBill in profile.upcomingBills)
                            ListTile(
                              title: TextW(
                                  "${upcomingBill.fromAccount} to ${upcomingBill.toAccount}",
                                  isBold: true),
                              subtitle: TextW(upcomingBill.description),
                              trailing: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    TextW(
                                        upcomingBill.amount.toStringAsFixed(2),
                                        isHeading: true,
                                        isBold: true),
                                    TextW(DateFormat("dd-M-yyyy")
                                        .format(upcomingBill.date))
                                  ]),
                            ),
                        ],
                      ),
                    ),
                  ]),
                ),
              );
            } else {
              return const TextW('Loading...');
            }
          }),
    );
  }
}
