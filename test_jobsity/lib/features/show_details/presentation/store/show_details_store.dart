import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:test_jobsity/features/show_details/data/models/season.dart';

import '../../../../core/tv_maze_dio_provider.dart';
import '../../../list_all_shows/data/models/show.dart';
import '../../data/models/episode.dart';
import '../../data/show_details_datasource.dart';
import '../../data/show_details_repository.dart';
import 'show_details_state.dart';

final showDetailsDatasource =
    Provider.autoDispose<ShowDetailsDatasource>((ref) {
  return ShowDetailsDatasourceImpl(dio: ref.read(tvMazeDio));
});

final showDetailsRepository =
    Provider.autoDispose<ShowDetailsRepository>((ref) {
  return ShowDetailsRepositoryImpl(
    datasource: ref.read(showDetailsDatasource),
  );
});

final showDetailsStoreProvider =
    StateNotifierProvider.autoDispose<ShowDetailsStore, ShowDetailsState>(
        (ref) {
  return ShowDetailsStore(
    showDetailsRepository: ref.read(showDetailsRepository),
  );
});

class ShowDetailsStore extends StateNotifier<ShowDetailsState> {
  final ShowDetailsRepository showDetailsRepository;

  ShowDetailsStore({required this.showDetailsRepository})
      : super(InitialShowDetailsState());

  getShowDetails({required int id}) async {
    state = LoadingShowDetailsState();

    Show? showData;
    List<Season>? seasons;

    final getShowDetailsEither = await showDetailsRepository.getShowDetails(
      id: id,
    );

    final getShowSeasonsEither = await showDetailsRepository.getShowEpisodes(
      id: id,
    );

    getShowDetailsEither.fold(
      (failure) {
        state = ErrorShowDetailsState(errorMessage: failure.errorMessage);
      },
      (show) {
        showData = show;
      },
    );

    getShowSeasonsEither.fold(
      (failure) {
        state = ErrorShowDetailsState(errorMessage: failure.errorMessage);
      },
      (episodes) {
        seasons = separeEpisodesInSeasons(episodes);
      },
    );

    state = SuccessShowDetailsState(
      show: showData,
      seasons: seasons,
    );
  }

  List<Season> separeEpisodesInSeasons(List<Episode> episodes) {
    List<Season> seasons = [];

    for (var i = 0; i < episodes.length; i++) {
      if (seasons.isEmpty) {
        seasons.add(
          Season(
            id: i,
            number: episodes[i].season,
            episodes: [episodes[i]],
          ),
        );
      } else {
        bool seasonExists = false;
        for (Season season in seasons) {
          if (season.number == episodes[i].season) {
            season.episodes.add(episodes[i]);
            seasonExists = true;
          }
        }
        if (!seasonExists) {
          seasons.add(
            Season(
              id: i,
              number: episodes[i].season,
              episodes: [episodes[i]],
            ),
          );
        }
      }
    }

    return seasons;
  }
}
