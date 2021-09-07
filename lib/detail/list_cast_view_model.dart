import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:moviedb/core/models/actor.dart';
import 'package:moviedb/core/services/movie_service.dart';

final listActorViewModelProvider = StateNotifierProvider.autoDispose<
    ListActorViewModel, AsyncValue<List<Actor>>>((ref) {
  return ListActorViewModel(ref.watch(movieServiceProvider));
});

class ListActorViewModel extends StateNotifier<AsyncValue<List<Actor>>> {
  final MovieService _movieService;

  ListActorViewModel(this._movieService) : super(AsyncLoading());

  void loadDataById(int id) async {
    state = AsyncLoading();
    try {
      List<Actor> videoResponse = await _movieService.getCastById(id);
      state = AsyncData(videoResponse);
    } catch (err) {
      state = AsyncError(err);
    }
  }
}
