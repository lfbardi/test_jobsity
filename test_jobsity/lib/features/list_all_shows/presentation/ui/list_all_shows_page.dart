import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';
import 'package:test_jobsity/core/design_system/colors.dart';
import 'package:test_jobsity/features/list_all_shows/presentation/store/list_all_shows_state.dart';
import 'package:test_jobsity/features/list_all_shows/presentation/store/list_all_shows_store.dart';
import 'package:test_jobsity/features/list_all_shows/presentation/ui/widgets/show_card.dart';

import '../../../../core/design_system/text_styles.dart';

class ListAllShowsPage extends ConsumerStatefulWidget {
  const ListAllShowsPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _ListAllShowsPageState();
}

class _ListAllShowsPageState extends ConsumerState<ListAllShowsPage> {
  @override
  void initState() {
    super.initState();

    ref.read(listAllShowsStoreProvider.notifier).getAllShows();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(listAllShowsStoreProvider);
    final store = ref.read(listAllShowsStoreProvider.notifier);

    if (state is LoadingListAllShowsState) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    } else if (state is SuccessListAllShowsState) {
      return Column(
        children: [
          const SizedBox(
            height: 20,
          ),
          Text(
            'All Shows',
            style: title.copyWith(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: 20,
          ),
          Expanded(
            child: LazyLoadScrollView(
              onEndOfPage: () => store.getNextPage(),
              scrollOffset: 100,
              child: GridView.builder(
                padding: const EdgeInsets.all(20),
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
                    image: show.image,
                    name: show.name,
                    rating: show.rating,
                  );
                },
              ),
            ),
          ),
          if (store.endOfListAchieved)
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Center(
                child: Text(
                  'End of list',
                  style:
                      title.copyWith(fontSize: 24, fontWeight: FontWeight.bold),
                ),
              ),
            ),
        ],
      );
    } else if (state is ErrorListAllShowsState) {
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
              onPressed: () => store.getAllShows(),
              child: Text('Try again', style: whiteTitle),
            ),
          ],
        ),
      );
    }

    return const SizedBox.shrink();
  }
}
