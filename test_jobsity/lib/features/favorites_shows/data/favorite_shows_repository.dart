import 'package:dartz/dartz.dart';
import 'package:test_jobsity/features/list_all_shows/data/models/show.dart';

import '../../../core/error/exceptions.dart';

import '../../../core/error/failure.dart';
import 'favorite_shows_local_datasource.dart';

abstract class FavoriteShowsRepository {
  Future<Either<Failure, List<Show>>> getMyFavoriteShows();
  Future<Either<Failure, bool>> addFavoriteShow(Show show);
  Future<Either<Failure, bool>> removeFavoriteShow(int id);
}

class FavoriteShowsRepositoryImpl implements FavoriteShowsRepository {
  final FavoriteShowsLocalDatasource localDatasource;

  FavoriteShowsRepositoryImpl({
    required this.localDatasource,
  });

  @override
  Future<Either<Failure, List<Show>>> getMyFavoriteShows() async {
    try {
      final response = await localDatasource.getMyFavoriteShows();
      return Right(response);
    } on HiveException catch (e) {
      return Left(
        LocalHiveFailure(errorMessage: e.message),
      );
    }
  }

  @override
  Future<Either<Failure, bool>> addFavoriteShow(Show show) async {
    try {
      await localDatasource.addFavoriteShow(show);
      return const Right(true);
    } on HiveException catch (e) {
      return Left(
        LocalHiveFailure(errorMessage: e.message),
      );
    }
  }

  @override
  Future<Either<Failure, bool>> removeFavoriteShow(int id) async {
    try {
      await localDatasource.removeFavoriteShow(id);
      return const Right(true);
    } on HiveException catch (e) {
      return Left(
        LocalHiveFailure(errorMessage: e.message),
      );
    }
  }
}
