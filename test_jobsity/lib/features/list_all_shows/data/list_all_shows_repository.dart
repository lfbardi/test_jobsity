import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:test_jobsity/features/list_all_shows/data/models/show.dart';

import '../../../core/error/exceptions.dart';
import './list_all_shows_datasource.dart';

import '../../../core/error/failure.dart';

abstract class ListAllShowsRepository {
  Future<Either<Failure, List<Show>>> getAllShows({
    required int? page,
  });
}

class ListAllShowsRepositoryImpl implements ListAllShowsRepository {
  final ListAllShowsDatasource datasource;

  ListAllShowsRepositoryImpl({
    required this.datasource,
  });

  @override
  Future<Either<Failure, List<Show>>> getAllShows({
    required int? page,
  }) async {
    try {
      final response = await datasource.getAllShows(
        page: page ?? 0,
      );
      return Right(response);
    } on ServerException catch (e) {
      return Left(
        ServerFailure(errorMessage: e.message),
      );
    } on DioError catch (_) {
      return Left(
        ServerFailure(),
      );
    } catch (e) {
      return Left(
        ServerFailure(),
      );
    }
  }
}
