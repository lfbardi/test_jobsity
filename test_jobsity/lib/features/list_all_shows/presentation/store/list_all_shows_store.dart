import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:test_jobsity/features/list_all_shows/data/list_all_shows_datasource.dart';
import 'package:test_jobsity/features/list_all_shows/data/list_all_shows_repository.dart';
import 'package:test_jobsity/features/list_all_shows/data/models/show.dart';
import 'package:test_jobsity/features/list_all_shows/presentation/store/list_all_shows_state.dart';

import '../../../../core/tv_maze_dio_provider.dart';

final listAllShowsDatasource =
    Provider.autoDispose<ListAllShowsDatasource>((ref) {
  return ListAllShowsDatasourceImpl(dio: ref.read(tvMazeDio));
});

final listAllShowsRepository =
    Provider.autoDispose<ListAllShowsRepository>((ref) {
  return ListAllShowsRepositoryImpl(
    datasource: ref.read(listAllShowsDatasource),
  );
});

final listAllShowsStoreProvider =
    StateNotifierProvider.autoDispose<ListAllShowsStore, ListAllShowsState>(
        (ref) {
  return ListAllShowsStore(
    listAllShowsRepository: ref.read(listAllShowsRepository),
  );
});

class ListAllShowsStore extends StateNotifier<ListAllShowsState> {
  final ListAllShowsRepository listAllShowsRepository;

  ListAllShowsStore({required this.listAllShowsRepository})
      : super(InitialListAllShowsState());

  final pageSize = 250;
  int currentPage = 0;
  bool endOfListAchieved = false;
  List<Show> shows = [];
  List<Show> searchedShows = [];

  getAllShows({int? page}) async {
    state = LoadingListAllShowsState();

    final getAllShowsEither = await listAllShowsRepository.getAllShows(
      page: page,
    );

    getAllShowsEither.fold(
      (failure) {
        if (failure.errorMessage == 'End of List') {
          endOfListAchieved = true;
          state = SuccessListAllShowsState(shows: shows);
          return;
        }

        state = ErrorListAllShowsState(errorMessage: failure.errorMessage);
      },
      (shows) {
        this.shows.addAll(shows);
        state = SuccessListAllShowsState(shows: this.shows);
      },
    );
  }

  clearSearchedShows() {
    shows.clear();
  }

  searchShow({required String query}) async {
    state = LoadingListAllShowsState();

    final getAllShowsEither = await listAllShowsRepository.searchShow(
      query: query,
    );

    getAllShowsEither.fold(
      (failure) {
        state = ErrorListAllShowsState(errorMessage: failure.errorMessage);
      },
      (shows) {
        this.shows.clear();
        this.shows.addAll(shows);
        state = SuccessListAllShowsState(shows: this.shows, isSearch: true);
      },
    );
  }

  getNextPage() async {
    currentPage++;

    final getAllShowsEither = await listAllShowsRepository.getAllShows(
      page: currentPage,
    );

    getAllShowsEither.fold(
      (failure) {
        if (failure.errorMessage == 'End of List') {
          endOfListAchieved = true;
          state = SuccessListAllShowsState(shows: shows);
          return;
        }

        state = ErrorListAllShowsState(errorMessage: failure.errorMessage);
      },
      (shows) {
        this.shows.addAll(shows);
        state = SuccessListAllShowsState(shows: this.shows);
      },
    );
  }
}
