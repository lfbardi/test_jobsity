import 'package:dio/dio.dart';
import 'package:test_jobsity/core/error/exceptions.dart';

import 'models/show.dart';

abstract class ListAllShowsDatasource {
  Future<List<Show>> getAllShows({
    required int page,
  });
  Future<List<Show>> searchShow({
    required String query,
  });
}

class ListAllShowsDatasourceImpl implements ListAllShowsDatasource {
  final Dio dio;

  ListAllShowsDatasourceImpl({
    required this.dio,
  });

  @override
  Future<List<Show>> getAllShows({
    required int page,
  }) async {
    final response = await dio.get(
      '/shows?page=$page',
    );

    if (response.statusCode == 404) {
      throw ServerException(message: 'End of List');
    }

    return (response.data as List).map((show) => Show.fromMap(show)).toList();
  }

  @override
  Future<List<Show>> searchShow({required String query}) async {
    try {
      final response = await dio.get(
        '/search/shows?q=$query',
      );

      return (response.data as List)
          .map((show) => Show.fromSearchMap(show))
          .toList();
    } catch (e) {
      throw ServerException(message: 'Error searching show');
    }
  }
}
