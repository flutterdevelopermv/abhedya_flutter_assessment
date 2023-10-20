import 'package:abhedya_flutter_assessment/ui/widgets/text_widget.dart';
import 'package:flutter/material.dart';

import '../../routes/go_routes.dart';
import '../f_statements/statements_screen.dart';
import '../g_contacts/contacts_screen.dart';

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
              Routes.navigateTo(context,
                  routeName: Routes.statements,
                  screen: const StatementsScreen());
            },
          ),
          ListTile(
            title: const TextW("Contacts"),
            onTap: () {
              Routes.navigateTo(context,
                  routeName: Routes.contacts, screen: const ContactsScreen());
            },
          ),
        ],
      ),
    );
  }
}

//
