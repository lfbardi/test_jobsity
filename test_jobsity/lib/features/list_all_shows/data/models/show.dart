class Show {
  int id;
  String url;
  String name;
  String type;
  String language;
  List<String> genres;
  num rating;
  String image;
  String summary;

  Show({
    required this.id,
    required this.url,
    required this.name,
    required this.type,
    required this.language,
    required this.genres,
    required this.rating,
    required this.image,
    required this.summary,
  });

  factory Show.fromMap(Map<String, dynamic> map) {
    return Show(
      id: map['id'] ?? 0,
      url: map['url'] ?? '',
      name: map['name'] ?? '',
      type: map['type'] ?? '',
      language: map['language'] ?? '',
      genres: List<String>.from(map['genres'] ?? []),
      rating: map['rating']['average'] ?? 0,
      image: map['image']['original'] ?? '',
      summary: map['summary'] ?? '',
    );
  }
}
