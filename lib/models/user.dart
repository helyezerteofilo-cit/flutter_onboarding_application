
import 'user_repository.dart';

class User {
  final String name;
  final String bio;
  final String avatarUrl;
  final List<Repository> repositories;

  User({
    required this.name,
    required this.bio,
    required this.avatarUrl,
    required this.repositories,
  });

  factory User.fromGraphQL(Map<String, dynamic> json){
    return User(
      name: json['name'], 
      bio: json['bio'], 
      avatarUrl: json['avatarUrl'],
      repositories: (json['repositories']['nodes'] as List<dynamic>).map((repo) => Repository.fromGraphQL(repo)).toList(),
      );
  }
}