import 'dart:developer';
import 'dart:ui';

import 'package:abhedya_flutter_assessment/data/repositories/graph_ql.dart';
import 'package:abhedya_flutter_assessment/global_blocs/graphQL/graph_query_result_bloc.dart';
import 'package:abhedya_flutter_assessment/ui/screens/b_main/bloc/main_bloc.dart';
import 'package:abhedya_flutter_assessment/ui/screens/c_home/bloc/home_bloc.dart';
import 'package:abhedya_flutter_assessment/ui/screens/c_home/home_screen.dart';
import 'package:abhedya_flutter_assessment/ui/widgets/query_builder.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:nock/nock.dart';

void main() {
  // setUpAll(() {
  //   nock.init();
  // });

  // setUp(() {
  //   nock.cleanAll();
  // });
  testWidgets('Home Screen UI testing', (tester) async {
    log("message");
    WidgetsFlutterBinding.ensureInitialized();
    await tester.pumpWidget(MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => MainBloc(),
        ),
        BlocProvider(
          create: (context) => HomeBloc(),
        ),
        BlocProvider(
          create: (context) => QueryResultBloc(),
        ),
      ],
      child: const TestHomeApp(HomeScreen("Phaneendra")),
    ));
    expect(find.byKey(PlaceHolderKeys.initialW), findsOneWidget);
    final result = await GraphQLApi.get(GraphQLApi.home);
    TestHomeApp.homeContext
        .read<QueryResultBloc>()
        .add(QueryResultEvent(result));
    QueryResultState queryResultState =
        BlocProvider.of<QueryResultBloc>(TestHomeApp.homeContext).state;
    log("message");
    if (queryResultState is QuerySuccess) {
      HomeState homeState =
          BlocProvider.of<HomeBloc>(TestHomeApp.homeContext).state;
      if (homeState is HomeProfileSuccess) {
        expect(find.byType(SingleChildScrollView), findsOneWidget);
      } else {
        expect(find.byType(SingleChildScrollView), findsNothing);
        expect(find.byType(Center), findsOneWidget);
      }
    } else if (queryResultState is QueryApiFailure) {
      expect(find.byKey(PlaceHolderKeys.apiFailureW), findsOneWidget);
    } else {
      expect(find.byType(SingleChildScrollView), findsNothing);
    }
    // }
  });
}

class TestHomeApp extends StatelessWidget {
  final Widget child;
  const TestHomeApp(this.child, {super.key});
  static late BuildContext homeContext;
  @override
  Widget build(BuildContext context) {
    homeContext = context;
    return GraphQLProvider(
      client: GraphQLApi.client,
      child: MaterialApp(
        home: child,
      ),
    );
  }
}
