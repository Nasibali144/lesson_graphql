import "package:flutter/material.dart";
import "package:graphql_flutter/graphql_flutter.dart";

class GraphQLConfiguration {
  static HttpLink httpLink = HttpLink(
    'https://flutter-b17.hasura.app/v1/graphql',
    defaultHeaders: {
      "x-hasura-admin-secret" : "WHvUwDlVnAeBgpNdz3Sg66DMixAGbICCpJU4q1lQzRfNqx6IEU9RC1IDLLliEwdW",
      "content-type": "application/json"
    }
  );

  ValueNotifier<GraphQLClient> client = ValueNotifier(
    GraphQLClient(
      cache: GraphQLCache(),
      link: httpLink,
    ),
  );

  GraphQLClient clientToQuery() {
    return GraphQLClient(link: httpLink, cache: GraphQLCache());
  }
}
