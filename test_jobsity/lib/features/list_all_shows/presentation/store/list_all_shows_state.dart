import 'package:test_jobsity/features/list_all_shows/data/models/show.dart';

abstract class ListAllShowsState {}

class InitialListAllShowsState extends ListAllShowsState {}

class LoadingListAllShowsState extends ListAllShowsState {}

class SuccessListAllShowsState extends ListAllShowsState {
  final List<Show> shows;
  SuccessListAllShowsState({
    required this.shows,
  });
}

class ErrorListAllShowsState extends ListAllShowsState {
  String errorMessage;

  ErrorListAllShowsState({required this.errorMessage});
}
