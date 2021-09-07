import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:moviedb/core/models/actor.dart';
import 'package:moviedb/core/models/movie_detail.dart';
import 'package:moviedb/core/services/movie_service.dart';
import 'package:moviedb/detail/list_cast_view_model.dart';
import 'package:moviedb/detail/movie_detail_view_model.dart';

import '../../mock/mock_model.dart';
import '../detail_movie/detail_movie_view_model_test.mocks.dart';

@GenerateMocks([MovieService])
void main() {
  final mockMovieService = MockMovieService();
  test('ListActorViewModel Success Test', () async {
    when(mockMovieService.getCastById(1)).thenAnswer((_) => Future.delayed(
        Duration(milliseconds: 100), () => Future.value(mockListActor)));

    final container = ProviderContainer(
      overrides: [movieServiceProvider.overrideWithValue(mockMovieService)],
    );

    final viewModel = container.listen(listActorViewModelProvider);

    container.read(listActorViewModelProvider.notifier).loadDataById(1);

    expect(viewModel.read(), TypeMatcher<AsyncLoading>());
    await Future.delayed(Duration(milliseconds: 200));
    expect(viewModel.read(), TypeMatcher<AsyncValue<List<Actor>>>());
    viewModel.close();
  });

  test('ListActorViewModel Error Test', () async {
    when(mockMovieService.getCastById(1)).thenAnswer((_) => Future.delayed(
        Duration(milliseconds: 100),
        () => throw Exception("Something went wrong")));

    final container = ProviderContainer(
      overrides: [movieServiceProvider.overrideWithValue(mockMovieService)],
    );

    final viewModel = container.listen(listActorViewModelProvider);

    container.read(listActorViewModelProvider.notifier).loadDataById(1);

    expect(viewModel.read(), TypeMatcher<AsyncLoading>());
    await Future.delayed(Duration(milliseconds: 200));
    expect(viewModel.read(), TypeMatcher<AsyncError>());
    viewModel.close();
  });
}
