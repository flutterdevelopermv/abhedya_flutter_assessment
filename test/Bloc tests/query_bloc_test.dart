import 'package:abhedya_flutter_assessment/data/repositories/graph_ql.dart';
import 'package:abhedya_flutter_assessment/global_blocs/graphQL/graph_query_result_bloc.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

void main() {
  group('QueryResultBloc', () {
    late QueryResultBloc queryResultBloc;

    setUp(() {
      queryResultBloc = QueryResultBloc();
    });

    test('Initial state is QueryInitial', () {
      expect(queryResultBloc.state, QueryInitial());
    });

    //
    blocTest(
      "Testing QueryResult States",
      build: () => queryResultBloc,
      act: (bloc) async {
        // 0
        var loading = QueryResult(
            options: QueryOptions(document: gql(GraphQLApi.contacts)),
            source: QueryResultSource.loading);
        bloc.add(QueryResultEvent(loading));

        // 1
        var contactsResult = await GraphQLApi.get(GraphQLApi.contacts);
        bloc.add(QueryResultEvent(contactsResult));

        // 2
        var statementsResult = await GraphQLApi.get(GraphQLApi.statements);
        bloc.add(QueryResultEvent(statementsResult));
      },
      expect: () {
        return [
          QueryLoading(),
          const QueryApiFailure("Error getting contacts."),
          QuerySuccess(statementsData)
        ];
      },
    );
  });
}

var statementsData = {
  "statements": [
    {
      "date": "2020-6-27",
      "description": "Voluptatem dolorem sit vel tempore voluptas.",
      "amount": -61472.98784926534
    },
    {
      "date": "2021-9-1",
      "description": "Dolor vel molestiae.",
      "amount": 57341.41585417092
    },
    {
      "date": "2020-7-4",
      "description":
          "Et minima quisquam quia dolores aut eaque facilis perspiciatis.",
      "amount": -92995.89800648391
    },
    {
      "date": "2020-2-18",
      "description": "Accusamus omnis quam commodi.",
      "amount": -9413.267346099019
    },
    {
      "date": "2021-5-11",
      "description": "Omnis porro sed earum sit atque eius.",
      "amount": 19672.202644869685
    },
    {
      "date": "2021-10-22",
      "description": "Ut cumque quidem molestiae.",
      "amount": -50098.965130746365
    },
    {
      "date": "2019-11-21",
      "description": "Est ad voluptatum qui magnam nam ea rerum.",
      "amount": -63577.94911600649
    },
    {
      "date": "2023-4-7",
      "description": "Esse eum quo autem velit quas.",
      "amount": -86122.95701168478
    },
    {
      "date": "2022-9-4",
      "description": "Earum veritatis eum voluptas veritatis fugiat.",
      "amount": -37827.24463380873
    },
    {
      "date": "2019-3-15",
      "description": "Error quia delectus dolor porro enim quae.",
      "amount": 17011.167434975505
    },
    {
      "date": "2022-8-21",
      "description": "Nostrum incidunt enim vitae facilis labore.",
      "amount": -81934.74509753287
    },
    {
      "date": "2020-7-27",
      "description":
          "Est perspiciatis rerum maxime explicabo consectetur nobis qui.",
      "amount": -77380.40229305625
    },
    {
      "date": "2020-7-28",
      "description": "Eligendi ipsam rem nihil minus quam quia.",
      "amount": -4146.852344274521
    },
    {
      "date": "2021-1-2",
      "description": "Est repellendus assumenda et quam ut sapiente ratione.",
      "amount": 24458.778277039528
    }
  ]
};
