import 'package:flutter_riverpod/flutter_riverpod.dart';

final mainTabViewModelProvider =
    StateNotifierProvider.autoDispose<MainTabViewModel, int>(
        (_) => MainTabViewModel());

class MainTabViewModel extends StateNotifier<int> {
  MainTabViewModel() : super(0);

  setTab(int index) {
    state = index;
  }
}
