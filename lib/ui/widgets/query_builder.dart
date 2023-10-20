import 'package:abhedya_flutter_assessment/global_blocs/graphQL/graph_query_result_bloc.dart';
import 'package:abhedya_flutter_assessment/ui/widgets/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

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
                  if (state is QuerySuccess) {
                    return successW(context, state.data);
                  } else if (state is QueryLoading) {
                    return loadingW ??
                        const SizedBox(
                            height: 40, child: CircularProgressIndicator());
                  } else if (state is QueryNetworkLost) {
                    return networkLostW ??
                        const TextW(
                            "Network Error, Please connect to the inernet");
                  } else if (state is QueryApiFailure) {
                    return apiFailureW != null
                        ? apiFailureW!(state.message)
                        : TextW(state.message);
                  } else if (state is QueryLinkException) {
                    return linkExceptionW != null
                        ? linkExceptionW!(state.linkException)
                        : const TextW(
                            "Unable to fetch details 'Link Exception'");
                  } else if (state is QueryUnknownError) {
                    return unknownErrorW ??
                        const TextW(
                            "Unable to fetch details, Please try again later");
                  }

                  return intialW ?? const TextW("Fetching details..");
                },
              );
            }),
      ),
    );
  }
}
