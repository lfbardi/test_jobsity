import 'dart:convert';

import 'package:hive/hive.dart';
import 'package:test_jobsity/core/error/exceptions.dart';

import '../../list_all_shows/data/models/show.dart';

abstract class FavoriteShowsLocalDatasource {
  Future<List<Show>> getMyFavoriteShows();
  Future<void> addFavoriteShow(Show show);
  Future<void> removeFavoriteShow(int id);
}

class FavoriteShowsLocalDatasourceImpl implements FavoriteShowsLocalDatasource {
  FavoriteShowsLocalDatasourceImpl();

  final String favoriteShowsBoxName = 'favorite_shows';

  @override
  Future<List<Show>> getMyFavoriteShows() async {
    try {
      Box box = await Hive.openBox(favoriteShowsBoxName);
      List<Show> favoriteShows = [];
      for (var show in box.values) {
        favoriteShows.add(Show.fromHiveMap(jsonDecode(show)));
      }
      return favoriteShows;
    } catch (e) {
      throw HiveException(message: 'Error getting favorite shows');
    }
  }

  @override
  Future<void> addFavoriteShow(Show show) async {
    try {
      Box box = await Hive.openBox(favoriteShowsBoxName);
      await box.put(show.id, jsonEncode(show.toMap()));
    } catch (e) {
      throw HiveException(message: 'Error adding favorite show');
    }
  }

  @override
  Future<void> removeFavoriteShow(int id) async {
    try {
      Box box = await Hive.openBox(favoriteShowsBoxName);
      await box.delete(id);
    } catch (e) {
      throw HiveException(message: 'Error removing favorite show');
    }
  }
}
