class Episode {
  final int id;
  final String name;
  final int season;
  final int number;
  final String summary;
  final String? image;

  Episode({
    required this.id,
    required this.name,
    required this.season,
    required this.number,
    required this.summary,
    required this.image,
  });

  factory Episode.fromMap(Map<String, dynamic> json) {
    return Episode(
      id: json['id'],
      name: json['name'] ?? 'No Name',
      season: json['season'],
      number: json['number'],
      summary: json['summary'] ?? 'No Summary',
      image: json['image'] != null
          ? json['image']['medium']
          : 'https://via.placeholder.com/150',
    );
  }
}
