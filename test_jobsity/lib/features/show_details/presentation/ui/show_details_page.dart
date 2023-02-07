import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:test_jobsity/core/design_system/colors.dart';
import 'package:test_jobsity/core/design_system/text_styles.dart';
import 'package:test_jobsity/features/favorites_shows/presentation/store/favorites_show_store.dart';
import 'package:test_jobsity/features/list_all_shows/presentation/store/list_all_shows_store.dart';
import 'package:test_jobsity/features/show_details/presentation/store/show_details_state.dart';

import '../../../../core/utils/remove_html_tags_from_string.dart';
import '../store/show_details_store.dart';
import 'widgets/seasons_list_builder.dart';

class ShowDetailsPage extends ConsumerStatefulWidget {
  const ShowDetailsPage({super.key, required this.showId});

  final int showId;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _ShowDetailsPageState();
}

class _ShowDetailsPageState extends ConsumerState<ShowDetailsPage> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      final storeDetails = ref.read(showDetailsStoreProvider.notifier);
      final storeFavorites = ref.read(favoritesShowsStoreProvider.notifier);
      storeDetails.getShowDetails(id: widget.showId);
      storeDetails.isFavorite = storeFavorites.verifyItsFavorite(widget.showId);
    });
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(showDetailsStoreProvider);
    final storeDetails = ref.read(showDetailsStoreProvider.notifier);

    if (state is ErrorShowDetailsState) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Text(
                state.errorMessage,
                style:
                    title.copyWith(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: primaryColor,
              ),
              onPressed: () => storeDetails.getShowDetails(id: widget.showId),
              child: Text('Try again', style: whiteTitle),
            ),
          ],
        ),
      );
    }

    return Material(
      child: SafeArea(
        child: Container(
          color: backgroundColor,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        Navigator.pop(context, () {
                          ref
                              .read(favoritesShowsStoreProvider.notifier)
                              .getMyFavoritesShows();
                          ref
                              .read(listAllShowsStoreProvider.notifier)
                              .getAllShows();
                        });
                      },
                      icon: const Icon(
                        Icons.arrow_back_ios,
                        color: primaryColor,
                      ),
                    ),
                    const Spacer(),
                    _buildTitle(state),
                    const Spacer(),
                    _buildFavoriteButton(state, storeDetails),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                _buildMainInfoShow(state),
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Summary',
                      style: title.copyWith(color: primaryColor),
                    ),
                  ),
                ),
                _buildSummary(state),
                const SizedBox(height: 20),
                _buildSeasonsList(state),
                const SizedBox(height: 100),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _buildFavoriteButton(ShowDetailsState state, ShowDetailsStore storeDetails) {
    if (state is SuccessShowDetailsState) {
      return IconButton(
        onPressed: () {
          setState(() {
            storeDetails.isFavorite
                ? storeDetails.removeFavoriteShow(state.show!.id)
                : storeDetails.addFavoriteShow(state.show!);
          });
        },
        icon: Icon(
          storeDetails.isFavorite ? Icons.favorite : Icons.favorite_border,
          color: storeDetails.isFavorite ? Colors.red : descriptionColor,
        ),
      );
    }
    return const SizedBox.shrink();
  }

  _buildSeasonsList(state) {
    if (state is SuccessShowDetailsState) {
      return SeasonsListBuilder(seasons: state.seasons!);
    }
    return const SizedBox.shrink();
  }

  _buildTitle(ShowDetailsState state) {
    if (state is LoadingShowDetailsState) {
      return const SizedBox(
        height: 10,
        width: 10,
        child: CircularProgressIndicator(),
      );
    } else if (state is SuccessShowDetailsState) {
      return Text(
        state.show!.name ?? 'No name',
        style: title.copyWith(color: primaryColor),
      );
    }
    return const SizedBox.shrink();
  }

  _buildSummary(ShowDetailsState state) {
    if (state is LoadingShowDetailsState) {
      return const SizedBox(
        height: 20,
        width: 20,
        child: CircularProgressIndicator(),
      );
    } else if (state is SuccessShowDetailsState) {
      return Padding(
        padding: const EdgeInsets.only(left: 20, right: 20),
        child: Text(
          removeAllHtmlTags(state.show!.summary ?? 'No summary'),
          style: title.copyWith(fontSize: 12),
          textAlign: TextAlign.justify,
        ),
      );
    }
    return const SizedBox.shrink();
  }

  _buildMainInfoShow(ShowDetailsState state) {
    if (state is LoadingShowDetailsState) {
      return const SizedBox(
        height: 30,
        width: 30,
        child: CircularProgressIndicator(),
      );
    } else if (state is SuccessShowDetailsState) {
      return Padding(
        padding: const EdgeInsets.only(left: 20, right: 20),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 200,
              width: 140,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: CachedNetworkImage(
                  fit: BoxFit.cover,
                  imageUrl: state.show!.image ??
                      'https://via.placeholder.com/140x200',
                ),
              ),
            ),
            const SizedBox(width: 20),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Schedule',
                  style: title.copyWith(color: primaryColor),
                ),
                Text(
                  'Days: ${state.show!.schedule?.days?.join('\n')}\nTime: ${state.show!.schedule?.time}',
                  style: title.copyWith(fontSize: 12),
                ),
                Text(
                  'No network',
                  style: title.copyWith(fontSize: 12),
                ),
                const SizedBox(height: 8),
                Text(
                  'Genres',
                  style: title.copyWith(color: primaryColor),
                ),
                Text(
                  state.show!.genres?.join('\n') ?? 'No genres',
                  style: title.copyWith(fontSize: 12),
                ),
              ],
            )
          ],
        ),
      );
    }
    return const SizedBox.shrink();
  }
}
