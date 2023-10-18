import 'package:abhedya_flutter_assessment/data/models/contact.dart';
import 'package:abhedya_flutter_assessment/data/models/statement.dart';
import 'package:abhedya_flutter_assessment/ui/widgets/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:intl/intl.dart';

import '../data/repositories/graph_ql.dart';

class ServicesScreen extends StatelessWidget {
  const ServicesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const TextW("Services")),
      body: Column(
        children: [
          ListTile(
            title: const TextW("Loans"),
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: const Align(
                      alignment: Alignment.topCenter,
                      child: TextW(
                          "You don't have any active loans on this account")),
                  action: SnackBarAction(
                      label: "Okay",
                      onPressed: () {
                        ScaffoldMessenger.of(context).removeCurrentSnackBar();
                      })));
            },
          ),
          ListTile(
            title: const TextW("Statements"),
            onTap: () {
              Get.to(() => const StatementScreen());
            },
          ),
          ListTile(
            title: const TextW("Contacts"),
            onTap: () {
              Get.to(() => const ContactsScreen());
            },
          ),
        ],
      ),
    );
  }
}

class StatementScreen extends StatelessWidget {
  const StatementScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const TextW('Statements')),
      body: Query(
          options: QueryOptions(
            fetchPolicy: FetchPolicy.networkOnly,
            document: gql(GraphQLApi
                .statements), // this is the query string you just created
            pollInterval: const Duration(seconds: 10),
          ),
          builder: (QueryResult result,
              {VoidCallback? refetch, FetchMore? fetchMore}) {
            //  log(result.exception?.linkException?.toString())
            if (result.data != null) {
              // log(result.data.toString());
              var listStatements = Statement.getList(result.data!);
              var sortedSatements = Statement.sortedMapList(listStatements);
              return SingleChildScrollView(
                child: Column(
                  children: [
                    for (var year in sortedSatements.keys)
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Card(
                          child: ExpansionTile(
                              title: TextW("Year $year",
                                  isBold: true, textScaleFactor: 1.2),
                              shape: const Border(),
                              children: [
                                for (var statemet in sortedSatements[year]!)
                                  Padding(
                                    padding: const EdgeInsets.all(3),
                                    child: ListTile(
                                        tileColor:
                                            Colors.black.withOpacity(0.05),
                                        title: TextW(statemet.description),
                                        trailing: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            TextW(
                                                statemet.amount
                                                    .toStringAsFixed(2),
                                                color:
                                                    statemet.amount.isNegative
                                                        ? Colors.red
                                                        : Colors.green,
                                                isBold: true,
                                                textScaleFactor: 1.3),
                                            TextW(DateFormat("dd-M-yyyy")
                                                .format(statemet.date)),
                                          ],
                                        ),
                                        subtitle: TextW(statemet.description)),
                                  )
                              ]),
                        ),
                      ),
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

//

class ContactsScreen extends StatelessWidget {
  const ContactsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const TextW('Contacts')),
      body: Center(
        child: Query(
            options: QueryOptions(
              fetchPolicy: FetchPolicy.networkOnly,
              document: gql(GraphQLApi
                  .contacts), // this is the query string you just created
              pollInterval: const Duration(seconds: 10),
            ),
            builder: (QueryResult result,
                {VoidCallback? refetch, FetchMore? fetchMore}) {
              //  log(result.exception?.linkException?.toString())
              if (result.data != null) {
                // log(result.data.toString());
                var listContacts = Contact.getList(result.data!);
                return SingleChildScrollView(
                  child: Column(
                    children: [
                      for (Contact contact in listContacts)
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 5, vertical: 2),
                          child: Card(child: TextW(contact.contact)),
                        )
                    ],
                  ),
                );
              } else if (result.hasException) {
                if (result.exception!.graphqlErrors.isNotEmpty) {
                  return TextW(result.exception!.graphqlErrors.first.message);
                } else {
                  return const TextW(
                      "Error in fetching details, Please try again later");
                }
              } else {
                return const TextW('Loading...');
              }
            }),
      ),
    );
  }
}
