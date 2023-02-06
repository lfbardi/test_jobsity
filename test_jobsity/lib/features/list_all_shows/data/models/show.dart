import 'package:test_jobsity/features/list_all_shows/data/models/schedule.dart';

class Show {
  int id;
  String? name;
  List<String>? genres;
  num? rating;
  String? image;
  String? summary;
  Schedule? schedule;

  Show({
    required this.id,
    required this.name,
    required this.genres,
    required this.rating,
    required this.image,
    required this.summary,
    required this.schedule,
  });

  factory Show.fromMap(Map<String, dynamic> map) {
    return Show(
      id: map['id'] ?? 0,
      name: map['name'] ?? '',
      genres: List<String>.from(map['genres'] ?? []),
      rating: map['rating']['average'] ?? 0,
      image: map['image']['original'] ?? '',
      summary: map['summary'] ?? '',
      schedule: Schedule.fromMap(map['schedule'] ?? {}),
    );
  }

  factory Show.fromSearchMap(Map<String, dynamic> map) {
    return Show(
      id: map['show']['id'] ?? 0,
      name: map['show']['name'] ?? '',
      genres: List<String>.from(map['show']['genres'] ?? []),
      rating: map['show']['rating']['average'] ?? 0,
      image: map['show']['image']['original'] ?? '',
      summary: map['show']['summary'] ?? '',
      schedule: Schedule.fromMap(map['show']['schedule'] ?? {}),
    );
  }
}
