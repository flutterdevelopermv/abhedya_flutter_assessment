import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../transactions_screen.dart';
import '../views/a_login/login_screen.dart';
import '../views/b_main/main_screen.dart';
import '../views/e_services/services_screen.dart';

class Routes {
  static const initialRoute = '/';
  //
  static const login = 'login';
  static const main = 'main';
  static const statements = 'statements';
  static const contacts = 'contacts';
  static const transactions = 'transactions';
  //

  static final routesTree = [
    GoRoute(
        path: initialRoute,
        name: login,
        builder: (context, state) => LoginScreen(),
        routes: [
          GoRoute(
              path: main,
              name: main,
              builder: (context, state) => state.extra as MainScreen,
              routes: [
                GoRoute(
                    path: statements,
                    name: statements,
                    builder: (context, state) =>
                        state.extra as StatementScreen),
                GoRoute(
                    path: contacts,
                    name: contacts,
                    builder: (context, state) => state.extra as ContactsScreen),
                GoRoute(
                    path: transactions,
                    name: transactions,
                    builder: (context, state) =>
                        state.extra as TransactionsScreen),
              ]),
        ]),
  ];

  //
 static void navigateTo(BuildContext context,
      {required String routeName, required Widget screen}) {
    context.goNamed(routeName, extra: screen);
  }
}
