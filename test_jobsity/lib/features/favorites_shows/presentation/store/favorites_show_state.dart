import 'package:test_jobsity/features/list_all_shows/data/models/show.dart';

abstract class FavoritesShowsState {}

class InitialFavoritesShowsState extends FavoritesShowsState {}

class LoadingFavoritesShowsState extends FavoritesShowsState {}

class SuccessFavoritesShowsState extends FavoritesShowsState {
  final List<Show> shows;
  bool isSearch;
  SuccessFavoritesShowsState({
    required this.shows,
    this.isSearch = false,
  });
}

class ErrorFavoritesShowsState extends FavoritesShowsState {
  String errorMessage;

  ErrorFavoritesShowsState({required this.errorMessage});
}

class EmptyFavoritesShowsState extends FavoritesShowsState {}
