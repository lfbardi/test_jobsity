import 'package:test_jobsity/features/list_all_shows/data/models/show.dart';

abstract class ListAllShowsState {}

class InitialListAllShowsState extends ListAllShowsState {}

class LoadingListAllShowsState extends ListAllShowsState {}

class SuccessListAllShowsState extends ListAllShowsState {
  final List<Show> shows;
  bool isSearch;
  SuccessListAllShowsState({
    required this.shows,
    this.isSearch = false,
  });
}

class ErrorListAllShowsState extends ListAllShowsState {
  String errorMessage;

  ErrorListAllShowsState({required this.errorMessage});
}
