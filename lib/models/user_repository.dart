
class Repository{
  final String name;
  final String description;
  final String url;

  Repository ({
    required this.name,
    required this.description,
    required this.url,
  });

  factory Repository.fromGraphQL(Map<String, dynamic> json){
    return Repository(
      name: json['name'], 
      description: json['description'], 
      url: json['url'],
      );
  }
}