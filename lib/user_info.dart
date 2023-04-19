import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';


class UserInfo extends StatelessWidget {
  
  final String username;
  
  const UserInfo({required this.username});

  @override
  Widget build(BuildContext context) {
    return Query(
      options: QueryOptions(
        document: gql('''
          query GetUser(\$username: String!){
            user(login: \$username){
              name
              bio
              email
              avatarUrl
              repositories(last: 10){
                nodes {
                  name
                  url
                }
              }
            }
          }'''),
          variables: {'username':username,},
          
          ), 
    
      builder: (QueryResult result, {FetchMore? fetchMore, VoidCallback? refetch}){
        if(result.hasException){
          return Text(result.exception.toString(),style: TextStyle(fontSize: 20));
        }

        if(result.isLoading){
          return const Text('Carregando...');
        }

        final userData = result.data?['user'];
        final List<dynamic> repositories = userData['repositories']['nodes'];
        final List<String> repositoryNames = [];
        final List<String> repositoryUrls = [];

        for (final repository in repositories){
          repositoryNames.add(repository['name']);
          repositoryUrls.add(repository['url']);
        }

        return Scaffold(
          appBar: AppBar(
            leading: const BackButton(),
            backgroundColor: Colors.blue,
            title: const Text('User Details'),
          ),

          body: SingleChildScrollView(
            child: Center(
              child: Container(
                padding: const EdgeInsets.all(8.0),
                child: Column(children: [
                  SizedBox(
                    width: 120,
                    height: 120,
                    child: CircleAvatar(
                      backgroundImage: NetworkImage(userData['avatarUrl']),
                      radius: 50,
                    ),
                  ),
                  const SizedBox(height: 20,),
                  Text(
                    '${userData['name'] ?? 'Não informado'}',
                    style: Theme.of(context).textTheme.headlineMedium,
                    ),
                  const SizedBox(height: 10,),
                  Text(
                    '${userData['bio'] ?? 'Não informado'}',
                    style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  const SizedBox(height: 30,),
                  const Text("Last 10 repositories:",
                  style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10,),
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: 400,
                    child: ListView.builder(
                      itemCount: repositoryNames.length,
                      itemBuilder: (BuildContext context, index) {
                        final name = repositoryNames[index];
                        final url = repositoryUrls[index];
                  
                        return Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                          child: ListTile(
                            title: Text(name),
                          ),
                        );
                      }
                    ),
                  ),
                  const SizedBox(height: 10,),
                ]),
              ),
            ),
          ),
          
        );
      } 
      
      );
      
  }
}