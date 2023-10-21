import 'package:abhedya_flutter_assessment/ui/widgets/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

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
            key: const Key("Loans"),
            title: const TextW("Loans"),
            leading: Icon(MdiIcons.handCoinOutline),
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
            key: const Key("Statements"),
            title: const TextW("Statements"),
            leading: Icon(MdiIcons.cardBulletedOutline),
            onTap: () {
              Routes.navigateTo(context,
                  routeName: Routes.statements,
                  screen: const StatementsScreen());
            },
          ),
          ListTile(
            key: const Key("Contacts"),
            title: const TextW("Contacts"),
            leading: Icon(MdiIcons.cardAccountPhoneOutline),
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
