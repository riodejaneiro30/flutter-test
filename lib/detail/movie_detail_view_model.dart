import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:moviedb/core/models/movie_detail.dart';
import 'package:moviedb/core/services/movie_service.dart';

final detailMovieViewModelProvider = StateNotifierProvider.autoDispose<
    DetailMovieViewModel, AsyncValue<MovieDetail>>((ref) {
  return DetailMovieViewModel(ref.watch(movieServiceProvider));
});

class DetailMovieViewModel extends StateNotifier<AsyncValue<MovieDetail>> {
  final MovieService _movieService;

  DetailMovieViewModel(this._movieService) : super(AsyncLoading());

  void loadDataById(int id) async {
    state = AsyncLoading();
    try {
      MovieDetail movieDetail = await _movieService.getMovieById(id);
      state = AsyncData(movieDetail);
    } catch (err) {
      state = AsyncError(err);
    }
  }
}
