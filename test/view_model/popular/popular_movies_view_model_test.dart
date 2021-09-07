import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:moviedb/core/models/async_state.dart';
import 'package:moviedb/core/models/movie.dart';
import 'package:moviedb/core/services/movie_service.dart';
import 'package:moviedb/movie/widgets/popular/popular_movies_view_model.dart';

import '../../mock/mock_model.dart';
import '../../screens/detail_movie_view_test.mocks.dart';

@GenerateMocks([MovieService])
void main() {
  final mockMovieService = MockMovieService();
  // test('PopularMovieViewModel Success Test', () async {
  //   when(mockMovieService.getPopularMovie(1)).thenAnswer((_) => Future.delayed(
  //       Duration(milliseconds: 100), () => Future.value(mockListMovies)));
  //
  //   final container = ProviderContainer(
  //     overrides: [movieServiceProvider.overrideWithValue(mockMovieService)],
  //   );
  //
  //   final viewModel = container.listen(popularMoviesViewModelProvider);
  //   container.read(popularMoviesViewModelProvider.notifier).loadData();
  //
  //   expect(viewModel.read(), TypeMatcher<Loading>());
  //   await Future.delayed(Duration(milliseconds: 200));
  //   expect(viewModel.read(), TypeMatcher<AsyncData<List<Movie>>>());
  //   viewModel.close();
  // });

  test('PopularMovieViewModel Error Test', () async {
    when(mockMovieService.getPopularMovie(2000)).thenAnswer((_) => Future.delayed(
        Duration(milliseconds: 100),
            () => throw Exception("Something went wrong")));

    final container = ProviderContainer(
      overrides: [movieServiceProvider.overrideWithValue(mockMovieService)],
    );

    final viewModel = container.listen(popularMoviesViewModelProvider);
    container.read(popularMoviesViewModelProvider.notifier).loadData();

    expect(viewModel.read(), TypeMatcher<Loading>());
    await Future.delayed(Duration(milliseconds: 200));
    expect(viewModel.read(), TypeMatcher<Error>());
    viewModel.close();
  });
}