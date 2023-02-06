import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:test_jobsity/features/list_all_shows/data/models/show.dart';
import 'package:test_jobsity/features/show_details/data/models/episode.dart';

import '../../../core/error/exceptions.dart';

import '../../../core/error/failure.dart';
import 'show_details_datasource.dart';

abstract class ShowDetailsRepository {
  Future<Either<Failure, Show>> getShowDetails({
    required int id,
  });

  Future<Either<Failure, List<Episode>>> getShowEpisodes({
    required int id,
  });
}

class ShowDetailsRepositoryImpl implements ShowDetailsRepository {
  final ShowDetailsDatasource datasource;

  ShowDetailsRepositoryImpl({
    required this.datasource,
  });

  @override
  Future<Either<Failure, Show>> getShowDetails({required int id}) async {
    try {
      final response = await datasource.getShowDetails(
        id: id,
      );
      return Right(response);
    } on ServerException catch (e) {
      return Left(
        ServerFailure(errorMessage: e.message),
      );
    } on DioError catch (_) {
      return Left(
        ServerFailure(errorMessage: 'Error getting show details'),
      );
    }
  }

  @override
  Future<Either<Failure, List<Episode>>> getShowEpisodes({
    required int id,
  }) async {
    try {
      final response = await datasource.getShowEpisodes(
        id: id,
      );
      return Right(response);
    } on ServerException catch (e) {
      return Left(
        ServerFailure(errorMessage: e.message),
      );
    } on DioError catch (_) {
      return Left(
        ServerFailure(errorMessage: 'Error getting show seasons'),
      );
    }
  }
}
