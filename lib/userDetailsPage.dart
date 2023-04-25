import 'package:flutter/material.dart';
import 'package:flutter_application_2/bloc/userDetailsBloc.dart';
import 'package:flutter_application_2/repositories/userDetailsRepository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher_string.dart';


class UserDetailsPage extends StatefulWidget {
  final String username;
  const UserDetailsPage({super.key, required this.username});

  @override
  State<UserDetailsPage> createState() => _UserDetailsPageState();
}

class _UserDetailsPageState extends State<UserDetailsPage> {

  late final UserDetailsBloc bloc;
  final userDetailsRepositoryImp = UserDetailsRepositoryImp();

  @override
  void initState() {
    super.initState();
    bloc = UserDetailsBloc(repositoryImp: userDetailsRepositoryImp);
    bloc.add(GetDataEvent(username: widget.username));
  }

  @override
  void dispose(){
    super.dispose();
    bloc.close();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("User"),
      ),
      body: Center(
        child: Container(
          padding: const EdgeInsets.all(8.0),
          child: BlocBuilder<UserDetailsBloc, UserState>(
            bloc: bloc,
            builder: (context, state) {
              if(state is UserStateLoading){
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              else if(state is UserStateError){
                return Center(
                  child: Text(state.message)
                  );
              }
              else if(state is UserStateLoaded){
                final user = state.data;
                return SingleChildScrollView(
                  child: Container(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        SizedBox(
                          width: 120,
                          height: 120,
                          child: CircleAvatar(
                            backgroundImage: NetworkImage(user.avatarUrl),
                            radius: 50,
                          ),
                        ),
                        const SizedBox(height: 10,),
                        Text(
                          user.name,
                          style: Theme.of(context).textTheme.headlineMedium,
                        ),
                        const SizedBox(height: 10,),
                        Text(
                          user.bio,
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                        const SizedBox(height: 30,),
                        Text("Last ${user.repositories.length} repositories:",
                          style: const TextStyle(fontSize: 15,fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 10,),
                        SizedBox(
                          width: MediaQuery.of(context).size.width,
                          height: 400,
                          child: ListView.builder(
                            itemCount: user.repositories.length,
                            itemBuilder: (BuildContext context, index) {
                              final name = user.repositories[index].name;
                              final url = user.repositories[index].url;
                
                              return Card(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                                child: GestureDetector(
                                  child: ListTile(
                                    title: Text(name),
                                    onTap: (){
                                      launchUrlString(url);
                                    },
                                  ),
                                ),
                              );
                            })
                            ),
                      ]),
                  ),
                );
              }
              else{
                return const Center(
                  child: Text("Por favor insira um usuário válido."),
                );
              }
                
            },
          ),
        )
        )
    );
  }
}