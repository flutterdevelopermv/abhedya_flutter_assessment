import 'package:abhedya_flutter_assessment/data/models/account.dart';
import 'package:abhedya_flutter_assessment/ui/routes/go_routes.dart';
import 'package:abhedya_flutter_assessment/ui/transactions_screen.dart';
import 'package:abhedya_flutter_assessment/ui/widgets/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import '../../../data/repositories/graph_ql.dart';
import '../../widgets/query_builder.dart';
import 'bloc/accounts_bloc.dart';

class AccountScreen extends StatelessWidget {
  const AccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const TextW("Accounts")),
      body: QueryBlocBuilder(
          options: QueryOptions(
            document: gql(GraphQLApi.accounts),
          ),
          successW: (context, data) {
            return BlocBuilder<AccountsBloc, AccountsState>(
              builder: (context, state) {
                context.read<AccountsBloc>().add(AccountsListEvent(data));
                if (state is AccountsListSuccess) {
                  return SingleChildScrollView(
                    child: Column(
                      children: [
                        for (Account account in state.listAccounts)
                          accountW(context, account)
                      ],
                    ),
                  );
                } else if (state is AccountsListError) {
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
  Widget accountW(BuildContext context, Account account) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
      child: Card(
          child: ListTile(
        title: TextW(account.accountHolder ?? ''),
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
          Routes.navigateTo(context,
              routeName: Routes.transactions,
              screen: TransactionsScreen(account));
        },
      )),
    );
  }
}
