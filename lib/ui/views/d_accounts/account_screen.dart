import 'package:abhedya_flutter_assessment/data/models/account.dart';
import 'package:abhedya_flutter_assessment/ui/routes/go_routes.dart';
import 'package:abhedya_flutter_assessment/ui/transactions_screen.dart';
import 'package:abhedya_flutter_assessment/ui/widgets/text_widget.dart';
import 'package:flutter/material.dart';

import 'package:go_router/go_router.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

import '../../../data/repositories/graph_ql.dart';

class AccountScreen extends StatelessWidget {
  const AccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const TextW("Accounts")),
      body: Query(
          options: QueryOptions(
            fetchPolicy: FetchPolicy.networkOnly,
            document: gql(GraphQLApi
                .accounts), // this is the query string you just created
            pollInterval: const Duration(seconds: 10),
          ),
          builder: (QueryResult result,
              {VoidCallback? refetch, FetchMore? fetchMore}) {
            //  log(result.exception?.linkException?.toString())
            if (result.data != null) {
              // log(result.data.toString());
              var listAccounts = Account.getList(result.data!);
              return SingleChildScrollView(
                child: Column(
                  children: [
                    for (Account account in listAccounts)
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 5, vertical: 2),
                        child: Card(
                            child: ListTile(
                          title: TextW(account.accountHolder),
                          subtitle: TextW(account.accountNumber),
                          trailing: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              TextW(account.balance.toStringAsFixed(2),
                                  isBold: true, isHeading: true),
                              TextW(account.accountType)
                            ],
                          ),
                          onTap: () {
                            context.goNamed(Routes.transactions,extra: TransactionsScreen(account));
                          },
                        )),
                      )
                  ],
                ),
              );
            } else {
              return const TextW('Loading...');
            }
          }),
    );
  }
}
