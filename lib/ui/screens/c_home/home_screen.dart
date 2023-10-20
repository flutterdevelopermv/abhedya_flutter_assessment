import 'package:abhedya_flutter_assessment/ui/widgets/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:intl/intl.dart';

import '../../../data/models/profile.dart';
import '../../../data/repositories/graph_ql.dart';
import '../../widgets/query_builder.dart';
import 'bloc/home_bloc.dart';

class HomeScreen extends StatelessWidget {
  final String username;
  const HomeScreen(this.username, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const TextW("Home")),
      body: QueryBlocBuilder(
          options: QueryOptions(
            document: gql(GraphQLApi.home),
          ),
          successW: (context, data) {
            return BlocBuilder<HomeBloc, HomeState>(
              builder: (context, state) {
                context.read<HomeBloc>().add(HomeProfileEvent(data));
                if (state is HomeProfileSuccess) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SingleChildScrollView(
                      child: Column(children: [
                        usernameW(),
                        accountDetailsW(state.profile),
                        recentTransactionsW(state.profile),
                        upcomingBillsW(state.profile),
                      ]),
                    ),
                  );
                } else if (state is HomeProfileError) {
                  return Center(
                    child: TextW(state.data.toString(),
                        maxLines: 3, overflow: TextOverflow.ellipsis),
                  );
                } else {
                  return const SizedBox();
                }
              },
            );
          }),
    );
  }

  //
  Widget usernameW() {
    return Align(
      alignment: Alignment.topLeft,
      child: TextW(username,
          textScaleFactor: 1.5, isBold: true, color: Colors.red),
    );
  }

  //
  Widget accountDetailsW(Profile profile) {
    return Card(
        child: Column(
      children: [
        TextW(profile.name, textScaleFactor: 1.5, isBold: true),
        Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          const TextW("Account Number : "),
          TextW(profile.accountNumber, isBold: true),
        ]),
        Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          const TextW("Balance : "),
          TextW("${profile.currency} ${profile.balance.toStringAsFixed(2)}",
              isBold: true),
        ]),
      ]
          .map((e) => Padding(padding: const EdgeInsets.all(5), child: e))
          .toList(),
    ));
  }

  //
  Widget recentTransactionsW(Profile profile) {
    return Card(
      child: ExpansionTile(
        shape: const Border(),
        title: const TextW("Recent Transactions",
            isBold: true, color: Colors.blue),
        childrenPadding: const EdgeInsets.only(left: 10),
        initiallyExpanded: true,
        children: [
          for (var recentTransaction in profile.recentTransactions)
            ListTile(
              title: TextW(
                  "${recentTransaction.fromAccount} to ${recentTransaction.toAccount}",
                  isBold: true),
              subtitle: TextW(recentTransaction.description),
              trailing: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextW(recentTransaction.amount.toStringAsFixed(2),
                        isHeading: true, isBold: true),
                    TextW(
                        DateFormat("dd-M-yyyy").format(recentTransaction.date)),
                  ]),
            ),
        ],
      ),
    );
  }

  //
  Widget upcomingBillsW(Profile profile) {
    return Card(
      child: ExpansionTile(
        shape: const Border(),
        title: const TextW("Upcoming Bills", isBold: true, color: Colors.red),
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
                    TextW(upcomingBill.amount.toStringAsFixed(2),
                        isHeading: true, isBold: true),
                    TextW(DateFormat("dd-M-yyyy").format(upcomingBill.date))
                  ]),
            ),
        ],
      ),
    );
  }
}
