import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class GraphQLApi {
  static final ValueNotifier<GraphQLClient> client = ValueNotifier(GraphQLClient(

      /// **NOTE** The default store is the InMemoryStore, which does NOT persist to disk
      cache: GraphQLCache(),
      link: HttpLink(
        // 'http://192.168.1.151:4000/'
        'http://192.168.0.102:4000/',
        // 'http://localhost:4000/',
      )));

  static const String home = r'''
query getHome {
  home {
    name
    accountNumber
    balance
    currency
    address {
      streetName
      buildingNumber
      townName
      postCode
      country
    }
    recentTransactions {
      date
      description
      amount
      fromAccount
      toAccount
    }
    upcomingBills {
      date
      description
      amount
      fromAccount
      toAccount
    }
  }
}
''';

//
  static const accounts = r'''
query getAccounts {
  accounts {
    id
    accountNumber
    accountType
    balance
    accountHolder
  }
}
''';
//
  static const transactions = r'''
query getTransactions {
  transactions {
    date
    description
    amount
    fromAccount
    toAccount
  }
}
''';

//
  static const contacts = r'''
query getContacts {
  contacts
}
''';

//
  static const statements = r'''
query getStatements {
  statements {
    date
    description
    amount
  }
}
''';

  // //
  static Future<QueryResult> get(String query) async {
    // Get the GraphQL client from the context
    GraphQLClient graphqlClient = GraphQLClient(

        /// **NOTE** The default store is the InMemoryStore, which does NOT persist to disk
        cache: GraphQLCache(),
        link: HttpLink(
          // 'http://192.168.1.151:4000/',
          'http://localhost:4000/',
        ));

    // Create a query options object with your query and variables
    QueryOptions options = QueryOptions(
      document: gql(query), // this is the query string you just created
    );

    // Execute the query and return the result
    QueryResult result = await graphqlClient.query(options);
    return result;
  }
}
