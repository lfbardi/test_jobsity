import 'package:flutter_riverpod/flutter_riverpod.dart';

final homeStoreProvider =
    StateNotifierProvider.autoDispose<HomeShowsStore, int>((ref) {
  return HomeShowsStore();
});

class HomeShowsStore extends StateNotifier<int> {
  HomeShowsStore() : super(0);

  void setPageIndex({required int page}) async {
    state = page;
  }
}
