class SearchResult {
  final List<Company> companies;
  final List<Post> posts;

  const SearchResult({
    required this.companies,
    required this.posts,
  });

  factory SearchResult.fromJson(Map<String, dynamic> json) {
    return SearchResult(
      companies: (json['companies'] as List)
          .map((company) => Company.fromJson(company))
          .toList(),
      posts:
          (json['posts'] as List).map((post) => Post.fromJson(post)).toList(),
    );
  }
}

class Company {
  final int id;
  final String title;
  final String photo;
  final String website;

  const Company({
    required this.id,
    required this.title,
    required this.photo,
    required this.website,
  });

  factory Company.fromJson(Map<String, dynamic> json) {
    return Company(
      id: json['id'],
      title: json['title'] ?? '',
      photo: json['photo'] ?? '',
      website: json['website'] ?? '',
    );
  }
}

class Post {
  final int id;
  final String type;
  final String photo;
  final String typeText;

  const Post({
    required this.id,
    required this.type,
    required this.photo,
    required this.typeText,
  });

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      id: json['id'],
      type: json['type'] ?? '',
      photo: json['photo'] ?? '',
      typeText: json['type_text'] ?? '',
    );
  }
}
