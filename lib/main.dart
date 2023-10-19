import 'package:abhedya_flutter_assessment/data/repositories/graph_ql.dart';

import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

import 'package:go_router/go_router.dart';

import 'ui/routes/go_routes.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GraphQLProvider(
      client: GraphQLApi.client,
      child: MaterialApp.router(
        title: 'Phaneendra Assessment',

        routerConfig: GoRouter(
            initialLocation: Routes.initialRoute, routes: Routes.routesTree),
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        // home: LoginScreen(),
      ),
    );
  }
}
