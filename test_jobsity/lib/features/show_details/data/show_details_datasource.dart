import 'package:dio/dio.dart';
import 'package:test_jobsity/features/list_all_shows/data/models/show.dart';
import 'package:test_jobsity/features/show_details/data/models/episode.dart';

abstract class ShowDetailsDatasource {
  Future<Show> getShowDetails({
    required int id,
  });

  Future<List<Episode>> getShowEpisodes({
    required int id,
  });
}

class ShowDetailsDatasourceImpl implements ShowDetailsDatasource {
  final Dio dio;

  ShowDetailsDatasourceImpl({
    required this.dio,
  });

  @override
  Future<Show> getShowDetails({required int id}) async {
    final response = await dio.get(
      '/shows/$id',
    );

    return Show.fromMap(response.data);
  }

  @override
  Future<List<Episode>> getShowEpisodes({required int id}) async {
    final response = await dio.get(
      '/shows/$id/episodes',
    );

    return (response.data as List)
        .map((season) => Episode.fromMap(season))
        .toList();
  }
}
