import 'package:abhedya_flutter_assessment/data/models/statement.dart';
import 'package:abhedya_flutter_assessment/ui/widgets/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:intl/intl.dart';

import '../../../data/repositories/graph_ql.dart';
import '../../widgets/query_builder.dart';
import 'bloc/statement_bloc.dart';

class StatementsScreen extends StatelessWidget {
  const StatementsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => StatementsBloc(),
      child: Scaffold(
        appBar: AppBar(title: const TextW('Statements')),
        body: QueryBlocBuilder(
            options: QueryOptions(
              document: gql(GraphQLApi.statements),
            ),
            successW: (context, data) {
              return BlocBuilder<StatementsBloc, StatementsState>(
                builder: (context, state) {
                  context
                      .read<StatementsBloc>()
                      .add(StatemenntsListEvent(data));
                  if (state is StatementsListSuccess) {
                    return yearWiseStatementsW(state.sortedSatements);
                  } else if (state is StatementsListError) {
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
      ),
    );
  }

  //
  Widget yearWiseStatementsW(Map<int, List<Statement>> sortedSatements) {
    return SingleChildScrollView(
      child: Column(
        children: [
          for (var year in sortedSatements.keys)
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                child: ExpansionTile(
                    title:
                        TextW("Year $year", isBold: true, textScaleFactor: 1.2),
                    shape: const Border(),
                    children: [
                      for (var statemet in sortedSatements[year]!)
                        statementW(statemet)
                    ]),
              ),
            )
        ],
      ),
    );
  }

  Widget statementW(Statement statemet) {
    return Padding(
      padding: const EdgeInsets.all(3),
      child: ListTile(
          tileColor: Colors.black.withOpacity(0.05),
          title: TextW(statemet.description ?? ''),
          trailing: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              TextW(statemet.amount.toStringAsFixed(2),
                  color: statemet.amount.isNegative ? Colors.red : Colors.green,
                  isBold: true,
                  textScaleFactor: 1.3),
              TextW(DateFormat("dd-M-yyyy").format(statemet.date)),
            ],
          ),
          subtitle: TextW(statemet.description ?? '')),
    );
  }
}
