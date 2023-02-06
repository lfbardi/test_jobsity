import '../../../list_all_shows/data/models/show.dart';
import '../../data/models/season.dart';

abstract class ShowDetailsState {}

class InitialShowDetailsState extends ShowDetailsState {}

class LoadingShowDetailsState extends ShowDetailsState {}

class SuccessShowDetailsState extends ShowDetailsState {
  final Show? show;
  final List<Season>? seasons;
  SuccessShowDetailsState({
    required this.show,
    required this.seasons,
  });
}

class ErrorShowDetailsState extends ShowDetailsState {
  String errorMessage;

  ErrorShowDetailsState({required this.errorMessage});
}
