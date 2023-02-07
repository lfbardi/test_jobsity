import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:test_jobsity/core/design_system/colors.dart';
import 'package:test_jobsity/features/favorites_shows/presentation/store/favorites_show_store.dart';

import '../../../../core/design_system/text_styles.dart';
import '../../../favorites_shows/presentation/ui/favorites_shows_page.dart';
import '../../../list_all_shows/presentation/store/list_all_shows_store.dart';
import '../../../list_all_shows/presentation/ui/list_all_shows_page.dart';
import '../store/home_store.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(homeStoreProvider);
    final homeStore = ref.read(homeStoreProvider.notifier);

    final listAllStore = ref.read(listAllShowsStoreProvider.notifier);
    final favoritesStore = ref.read(favoritesShowsStoreProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: backgroundColor,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CachedNetworkImage(
              placeholder: (context, string) {
                return const SizedBox(
                  height: 36,
                  width: 36,
                  child: CircularProgressIndicator(),
                );
              },
              imageUrl: 'https://static.tvmaze.com/images/tvm-header-logo.png',
              height: 36,
            )
          ],
        ),
      ),
      backgroundColor: backgroundColor,
      body: IndexedStack(
        index: state,
        children: [
          ListAllShowsPage(),
          FavoritesShowsPage(),
          Center(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Text(
                'Sorry, didn\'t manage time to do this page :(',
                style: title.copyWith(fontSize: 20),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        margin: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
        decoration: const BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.all(Radius.circular(24)),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8),
            child: GNav(
              rippleColor: descriptionColor,
              hoverColor: descriptionColor2,
              haptic: true,
              gap: 8,
              activeColor: primaryColor,
              iconSize: 24,
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
              duration: const Duration(milliseconds: 400),
              tabBackgroundColor: Colors.black,
              color: headerColor,
              tabs: [
                GButton(
                  icon: Icons.home,
                  text: 'Home',
                  textStyle: tabText,
                  onPressed: () {
                    listAllStore.getAllShows();
                  },
                ),
                GButton(
                  icon: Icons.favorite,
                  text: 'Favorites',
                  textStyle: tabText,
                  onPressed: () {
                    favoritesStore.getMyFavoritesShows();
                  },
                ),
                GButton(
                  icon: Icons.person,
                  text: 'Persons',
                  textStyle: tabText,
                ),
              ],
              selectedIndex: 0,
              onTabChange: (index) {
                homeStore.setPageIndex(page: index);
              },
            ),
          ),
        ),
      ),
    );
  }
}
