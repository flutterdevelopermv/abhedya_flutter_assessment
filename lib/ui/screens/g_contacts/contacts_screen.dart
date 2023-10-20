import 'package:abhedya_flutter_assessment/data/models/contact.dart';
import 'package:abhedya_flutter_assessment/ui/widgets/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import '../../../data/repositories/graph_ql.dart';
import '../../widgets/query_builder.dart';
import 'bloc/contacts_bloc.dart';

class ContactsScreen extends StatelessWidget {
  const ContactsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ContactsBloc(),
      child: Scaffold(
        appBar: AppBar(title: const TextW('Contacts')),
        body: QueryBlocBuilder(
            options: QueryOptions(
              document: gql(GraphQLApi.contacts),
            ),
            successW: (context, data) {
              return BlocBuilder<ContactsBloc, ContactsState>(
                builder: (context, state) {
                  context.read<ContactsBloc>().add(ContactsFetchEvent(data));
                  if (state is ContactsSuccess) {
                    return SingleChildScrollView(
                      child: Column(
                        children: [
                          for (Contact contact in state.listContacts)
                            contactW(contact)
                        ],
                      ),
                    );
                  } else if (state is ContactsError) {
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
  Widget contactW(Contact contact) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
      child: Card(child: TextW(contact.contact)),
    );
  }
}
