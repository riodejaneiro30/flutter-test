import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:moviedb/core/models/async_state.dart';
import 'package:moviedb/core/models/movie.dart';
import 'package:moviedb/core/services/movie_service.dart';

final popularMoviesViewModelProvider =
    StateNotifierProvider<PopularMoviesViewModel, AsyncState<List<Movie>>>(
        (ref) => PopularMoviesViewModel(ref.read(movieServiceProvider)));

class PopularMoviesViewModel extends StateNotifier<AsyncState<List<Movie>>> {
  final MovieService _movieService;
  PopularMoviesViewModel(this._movieService) : super(Initial([])) {
    loadData();
  }

  loadData() async {
    state = Loading(state.data);
    try {
      var movies = await _movieService.getPopularMovie(1);
      state = Success(movies);
    } catch (exception) {
      state = Error('Something went wrong', state.data);
    }
  }
}
