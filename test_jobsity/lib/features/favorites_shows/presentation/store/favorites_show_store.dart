import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:test_jobsity/features/list_all_shows/data/models/show.dart';
import '../../data/favorite_shows_local_datasource.dart';
import '../../data/favorite_shows_repository.dart';
import 'favorites_show_state.dart';

final favoriteShowsLocalDatasource =
    Provider.autoDispose<FavoriteShowsLocalDatasource>((ref) {
  return FavoriteShowsLocalDatasourceImpl();
});

final favoritesShowsRepository = Provider<FavoriteShowsRepository>((ref) {
  return FavoriteShowsRepositoryImpl(
    localDatasource: ref.read(favoriteShowsLocalDatasource),
  );
});

final favoritesShowsStoreProvider =
    StateNotifierProvider.autoDispose<FavoritesShowsStore, FavoritesShowsState>(
        (ref) {
  return FavoritesShowsStore(
    favoritesShowsRepository: ref.read(favoritesShowsRepository),
  );
});

class FavoritesShowsStore extends StateNotifier<FavoritesShowsState> {
  final FavoriteShowsRepository favoritesShowsRepository;

  FavoritesShowsStore({required this.favoritesShowsRepository})
      : super(InitialFavoritesShowsState());

  List<Show> myFavoriteShows = [];

  getMyFavoritesShows() async {
    final getAllShowsEither =
        await favoritesShowsRepository.getMyFavoriteShows();

    getAllShowsEither.fold(
      (failure) {
        state = ErrorFavoritesShowsState(errorMessage: failure.errorMessage);
      },
      (favoriteShows) {
        if (favoriteShows.isEmpty) {
          state = EmptyFavoritesShowsState();
        } else {
          myFavoriteShows = favoriteShows;
          sortByAToZ(favoriteShows);
        }
      },
    );
  }

  deleteFromFavoritesShow(int id) async {
    final deleteFavoriteShowEither =
        await favoritesShowsRepository.removeFavoriteShow(id);

    deleteFavoriteShowEither.fold(
      (failure) {
        state = ErrorFavoritesShowsState(errorMessage: failure.errorMessage);
      },
      (wasDeleted) {
        if (wasDeleted) {
          getMyFavoritesShows();
        } else {
          state = ErrorFavoritesShowsState(errorMessage: 'Error deleting show');
        }
      },
    );
  }

  addFavoriteShow(Show show) async {
    final addFavoriteShowEither =
        await favoritesShowsRepository.addFavoriteShow(show);

    addFavoriteShowEither.fold(
      (failure) {
        state = ErrorFavoritesShowsState(errorMessage: failure.errorMessage);
      },
      (wasFavorited) {
        if (wasFavorited) {
          getMyFavoritesShows();
        } else {
          state = ErrorFavoritesShowsState(
              errorMessage: 'Error adding favorite show');
        }
      },
    );
  }

  bool verifyItsFavorite(int id) {
    final isFavorite = myFavoriteShows.any((element) => element.id == id);
    return isFavorite;
  }

  sortByAToZ(List<Show> shows) {
    final sortedShows = [...shows];
    sortedShows.sort((a, b) => a.name!.compareTo(b.name!));
    state = SuccessFavoritesShowsState(shows: sortedShows);
  }

  sortByZToA(List<Show> shows) {
    final sortedShows = [...shows];
    sortedShows.sort((a, b) => -a.name!.compareTo(b.name!));
    state = SuccessFavoritesShowsState(shows: sortedShows);
  }
}
