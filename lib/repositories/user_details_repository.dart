import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

import '../models/user.dart';


abstract class UserDetailsRepository{
  Future<User> getUserDataByUsername(String username);
}


class UserDetailsRepositoryImp implements UserDetailsRepository{

  final String _baseUrl = 'https://api.github.com/graphql';
  final String _personalToken = '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';
  
  @override
  Future<User> getUserDataByUsername(String username)  async{
    await initHiveForFlutter();
    final HttpLink httpLink = HttpLink(_baseUrl);
    final AuthLink authLink = AuthLink(getToken: () async => 'Bearer $_personalToken');

    final Link link = authLink.concat(httpLink);
    
    final ValueNotifier<GraphQLClient> client = ValueNotifier(
      GraphQLClient(
        link: link,
        cache: GraphQLCache(store: HiveStore())
      )
    );

    const String query = r'''
      query GetUser(\$username: String!){
        user(login: \$username){
          name
          bio
          email
          avatarUrl
          repositories(last: 10){
            nodes {
              name
              description
              url
            }
          }
        }
      }''';

    final WatchQueryOptions options = WatchQueryOptions(
      document: gql(query),
      variables: {'username': username},
      );

    final QueryResult result = await client.value.query(options);

    if (result.hasException){
      throw result.exception!;
    }

    final Map<String, dynamic> userData = result.data!['user'];

    return User.fromGraphQL(userData);

  }

}