import 'package:abhedya_flutter_assessment/global_blocs/graphQL/graph_query_result_bloc.dart';
import 'package:abhedya_flutter_assessment/ui/widgets/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

/// Shortcut Widget for Query & QueryResultBloc to reduce boilerplate
class QueryBlocBuilder extends StatelessWidget {
  final QueryOptions<Object?> options;
  final Widget Function(BuildContext context, Map<String, dynamic> data)
      successW;

  final Widget? intialW;
  final Widget? loadingW;
  final Widget? networkLostW;
  final Widget? unknownErrorW;
  final Widget Function(String message)? apiFailureW;
  final Widget Function(LinkException linkException)? linkExceptionW;

  const QueryBlocBuilder(
      {required this.options,
      required this.successW,
      this.intialW,
      this.networkLostW,
      this.loadingW,
      this.apiFailureW,
      this.linkExceptionW,
      this.unknownErrorW,
      super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => QueryResultBloc(),
      child: Center(
        child: Query(
            options: options,
            builder: (QueryResult result,
                {VoidCallback? refetch, FetchMore? fetchMore}) {
              return BlocBuilder<QueryResultBloc, QueryResultState>(
                builder: (context, state) {
                  context.read<QueryResultBloc>().add(QueryResultEvent(result));
                  if (state is QueryNetworkLost) {
                    return networkLostW ?? PlaceHolderW.networkLostW;
                  } else if (state is QueryLoading) {
                    return loadingW ?? PlaceHolderW.loadingW;
                  } else if (state is QueryApiFailure) {
                    return apiFailureW != null
                        ? apiFailureW!(state.message)
                        : PlaceHolderW.apiFailureW(state.message);
                  } else if (state is QueryLinkException) {
                    return linkExceptionW != null
                        ? linkExceptionW!(state.linkException)
                        : PlaceHolderW.linkExceptionW;
                  } else if (state is QueryUnknownError) {
                    return unknownErrorW ?? PlaceHolderW.unknownErrorW;
                  } else if (state is QuerySuccess) {
                    return successW(context, state.data);
                  }

                  return intialW ?? PlaceHolderW.initialW;
                },
              );
            }),
      ),
    );
  }
}

//
class PlaceHolderW {
  static const initialW =
      TextW("Fetching details..", key: PlaceHolderKeys.initialW);
  static const unknownErrorW = TextW(
      "Unable to fetch details, Please try again later",
      key: PlaceHolderKeys.unknownErrorW);
  static const linkExceptionW = TextW(
      "Unable to fetch details 'Link Exception'",
      key: PlaceHolderKeys.linkExceptionW);
  static Widget apiFailureW(String message) =>
      TextW(message, key: PlaceHolderKeys.apiFailureW);
  static const networkLostW = TextW(
      "Network Error, Please connect to the inernet",
      key: PlaceHolderKeys.networkLostW);
  static const loadingW = SizedBox(
      height: 40,
      key: PlaceHolderKeys.loadingW,
      child: CircularProgressIndicator());
}

//
class PlaceHolderKeys {
  static const initialW = Key('initialW');
  static const unknownErrorW = Key('unknownErrorW');
  static const linkExceptionW = Key('linkExceptionW');
  static const apiFailureW = Key('apiFailureW');
  static const networkLostW = Key('networkLostW');
  static const loadingW = Key('loadingW');
}
