import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:test_jobsity/core/design_system/colors.dart';

import '../../../../core/design_system/text_styles.dart';
import '../../../list_all_shows/presentation/ui/list_all_shows_page.dart';
import '../store/home_store.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(homeStoreProvider);
    final store = ref.read(homeStoreProvider.notifier);

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
        children: const [
          ListAllShowsPage(),
          Center(
            child: Text('Favorites'),
          ),
          Center(
            child: Text('Profile'),
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
                ),
                GButton(
                  icon: Icons.favorite,
                  text: 'Favorites',
                  textStyle: tabText,
                ),
                GButton(
                  icon: Icons.person,
                  text: 'Profile',
                  textStyle: tabText,
                ),
              ],
              selectedIndex: 0,
              onTabChange: (index) {
                store.setPageIndex(page: index);
              },
            ),
          ),
        ),
      ),
    );
  }
}
