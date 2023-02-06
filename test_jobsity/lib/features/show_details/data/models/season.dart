import 'episode.dart';

class Season {
  final int id;
  final int? number;
  final List<Episode> episodes;

  Season({
    required this.id,
    required this.number,
    required this.episodes,
  });

  factory Season.fromMap(Map<String, dynamic> json) {
    return Season(
      id: json['id'],
      number: json['number'] ?? 0,
      episodes: List<Episode>.from(
        json['episodes'].map((x) => Episode.fromMap(x)),
      ),
    );
  }
}
