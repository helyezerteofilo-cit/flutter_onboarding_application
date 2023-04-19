import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

import 'login_page.dart';

void main() async{
  await initHiveForFlutter();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    
    final HttpLink httpLink = HttpLink('https://api.github.com/graphql');
    final AuthLink authLink = AuthLink(
      getToken: () async => 'Bearer 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'
      );
    final Link link = authLink.concat(httpLink);
    ValueNotifier<GraphQLClient> client = ValueNotifier(
      GraphQLClient(
        link: link,
        cache: GraphQLCache(store: HiveStore())
      )
    );

    return GraphQLProvider(
      client: client,
      child: MaterialApp(
        theme: ThemeData(
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        
        home: LoginPage(),
      ),
    );
  }
}

