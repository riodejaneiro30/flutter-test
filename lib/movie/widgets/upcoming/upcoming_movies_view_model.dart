import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:moviedb/core/models/async_state.dart';
import 'package:moviedb/core/models/movie.dart';
import 'package:moviedb/core/services/movie_service.dart';

final upcomingMoviesViewModelProvider =
    StateNotifierProvider<UpcomingMoviesViewModel, AsyncState<List<Movie>>>(
        (ref) => UpcomingMoviesViewModel(ref.read(movieServiceProvider)));

class UpcomingMoviesViewModel extends StateNotifier<AsyncState<List<Movie>>> {
  final MovieService _movieService;

  UpcomingMoviesViewModel(this._movieService) : super(Initial([])) {
    loadData();
  }

  void loadData() async {
    state = new Loading(state.data);
    try{
      var movies = await _movieService.getUpcoming(1, 5);
      state = new Success(movies);
    }catch(exception){
      state = new Error('Something went wrong', state.data);
    }
  }
}
