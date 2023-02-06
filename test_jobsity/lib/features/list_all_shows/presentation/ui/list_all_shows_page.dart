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

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      ref.read(listAllShowsStoreProvider.notifier).getAllShows();
    });
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(listAllShowsStoreProvider);
    final store = ref.read(listAllShowsStoreProvider.notifier);

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
                  'All Shows',
                  style:
                      title.copyWith(fontSize: 24, fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(
                width: 12,
              ),
              Expanded(
                child: Material(
                  elevation: 4,
                  color: descriptionColor.withOpacity(0.1),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 12),
                    child: Expanded(
                      child: TextField(
                        onChanged: (value) {
                          if (value.length >= 3) {
                            store.searchShow(query: value);
                          } else if (value.isEmpty) {
                            store.clearSearchedShows();
                            store.getAllShows();
                          }
                        },
                        cursorColor: primaryColor,
                        keyboardType: TextInputType.text,
                        style: title.copyWith(fontSize: 12),
                        decoration: InputDecoration(
                          hintText: 'Search shows',
                          isDense: true,
                          contentPadding: const EdgeInsets.fromLTRB(
                            10,
                            10,
                            10,
                            0,
                          ),
                          suffixIcon: const Icon(
                            Icons.search,
                            color: descriptionColor,
                          ),
                          hintStyle: title.copyWith(fontSize: 12),
                          fillColor: Colors.transparent,
                          filled: true,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide: BorderSide.none,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          _buildBody(state, store),
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
      ),
    );
  }

  _buildBody(ListAllShowsState state, ListAllShowsStore store) {
    if (state is LoadingListAllShowsState) {
      return const Expanded(
        child: Center(
          child: CircularProgressIndicator(),
        ),
      );
    } else if (state is SuccessListAllShowsState) {
      return Expanded(
        child: LazyLoadScrollView(
          onEndOfPage: state.isSearch ? () {} : () => store.getNextPage(),
          scrollOffset: 100,
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
                id: show.id,
                image: show.image ?? 'https://via.placeholder.com/140x190',
                name: show.name ?? 'No name',
                rating: show.rating ?? 0,
              );
            },
          ),
        ),
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
