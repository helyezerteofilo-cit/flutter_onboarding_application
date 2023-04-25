
class Repository{
  final String name;
  final String url;

  Repository ({
    required this.name,
    required this.url,
  });

  factory Repository.fromGraphQL(Map<String, dynamic> json){
    return Repository(
      name: json['name'], 
      url: json['url'],
      );
  }
}