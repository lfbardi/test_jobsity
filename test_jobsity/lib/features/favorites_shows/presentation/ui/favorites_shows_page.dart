import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:test_jobsity/core/design_system/colors.dart';
import 'package:test_jobsity/features/list_all_shows/presentation/ui/widgets/show_card.dart';

import '../../../../core/design_system/text_styles.dart';
import '../store/favorites_show_state.dart';
import '../store/favorites_show_store.dart';

class FavoritesShowsPage extends ConsumerStatefulWidget {
  const FavoritesShowsPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _FavoritesShowsPageState();
}

class _FavoritesShowsPageState extends ConsumerState<FavoritesShowsPage> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      ref.read(favoritesShowsStoreProvider.notifier).getMyFavoritesShows();
    });
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(favoritesShowsStoreProvider);
    final store = ref.read(favoritesShowsStoreProvider.notifier);

    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20),
      child: Column(
        children: [
          const SizedBox(
            height: 20,
          ),
          Row(
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'My Favorites',
                  style:
                      title.copyWith(fontSize: 24, fontWeight: FontWeight.bold),
                ),
              ),
              const Spacer(),
              IconButton(
                onPressed: () {
                  if (state is SuccessFavoritesShowsState) {
                    setState(() {
                      store.sortByAToZ(state.shows);
                    });
                  }
                },
                icon: const Icon(
                  Icons.sort_by_alpha,
                  color: primaryColor,
                ),
              ),
              const Spacer(),
              IconButton(
                onPressed: () {
                  if (state is SuccessFavoritesShowsState) {
                    setState(() {
                      store.sortByZToA(state.shows);
                    });
                  }
                },
                icon: const Icon(
                  Icons.sort_by_alpha,
                  color: primaryColor,
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          _buildBody(state, store),
        ],
      ),
    );
  }

  _buildBody(FavoritesShowsState state, FavoritesShowsStore store) {
    if (state is LoadingFavoritesShowsState) {
      return const Expanded(
        child: Center(
          child: CircularProgressIndicator(),
        ),
      );
    } else if (state is EmptyFavoritesShowsState) {
      return Expanded(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'You don\'t have any favorite show yet',
                style: title.copyWith(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: descriptionColor,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                'Go to the list of shows and add your favorites',
                style: title.copyWith(
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                  color: descriptionColor,
                ),
              ),
            ],
          ),
        ),
      );
    } else if (state is SuccessFavoritesShowsState) {
      return Expanded(
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 200,
            childAspectRatio: 2 / 3,
            crossAxisSpacing: 20,
            mainAxisSpacing: 20,
          ),
          itemCount: state.shows.length,
          itemBuilder: (context, index) {
            final show = state.shows[index];
            return ShowCard(
              show: show,
            );
          },
        ),
      );
    } else if (state is ErrorFavoritesShowsState) {
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
              onPressed: () => store.getMyFavoritesShows(),
              child: Text('Try again', style: whiteTitle),
            ),
          ],
        ),
      );
    }
    return const SizedBox.shrink();
  }
}
