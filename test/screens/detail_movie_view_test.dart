import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:moviedb/core/services/movie_service.dart';
import 'package:moviedb/detail/components/video_player.dart';
import 'package:moviedb/detail/list_cast_view_model.dart';
import 'package:moviedb/detail/movie_detail.dart';
import 'package:moviedb/detail/movie_detail_view_model.dart';
import 'package:moviedb/detail/video_trailer_view_model.dart';
import 'package:network_image_mock/network_image_mock.dart';

import '../mock/fake_app.dart';
import '../mock/mock_model.dart';
import 'detail_movie_view_test.mocks.dart';

@GenerateMocks([
  DetailMovieViewModel,
  VideoTrailerViewModel,
  ListActorViewModel,
  MovieService
], customMocks: [
  MockSpec<NavigatorObserver>(
      as: #MockNavigatorObserver, returnNullOnMissingStub: true)
])
void main() {
  final mockMovieService = MockMovieService();
  when(mockMovieService.getMovieById(1)).thenAnswer((_) => Future.delayed(
      Duration(milliseconds: 100), () => Future.value(mockMovieDetail)));
  when(mockMovieService.getCastById(1)).thenAnswer((_) => Future.delayed(
      Duration(milliseconds: 100), () => Future.value(mockListActor)));
  when(mockMovieService.getVideoById(1)).thenAnswer((_) => Future.delayed(
      Duration(milliseconds: 100), () => Future.value(mockVideoResponse)));

  testWidgets('Home Screen test', (WidgetTester tester) async {
    final mockObserver = MockNavigatorObserver();
    final screen = MovieDetailScreen();
    // await mockNetworkImagesFor(
    //     () => tester.runAsync(() => tester.pumpWidget(FakeMyApp(
    //         navigatorObserver: mockObserver,
    //         homeScreen: NavigatorScreen(
    //             screenToGo: ProviderScope(overrides: [
    //               detailMovieViewModelProvider.overrideWithProvider(
    //                   StateNotifierProvider.autoDispose(
    //                       (ref) => DetailMovieViewModel(mockMovieService))),
    //               listActorViewModelProvider.overrideWithProvider(
    //                   StateNotifierProvider.autoDispose(
    //                       (ref) => ListActorViewModel(mockMovieService))),
    //               videoTrailerViewModelProvider.overrideWithProvider(
    //                   StateNotifierProvider.autoDispose(
    //                       (ref) => VideoTrailerViewModel(mockMovieService)))
    //             ], child: screen),
    //             arguments: 1)))));

    await mockNetworkImagesFor(
        () => tester.runAsync(() => tester.pumpWidget(MaterialApp(
              home: Navigator(
                onGenerateRoute: (_) {
                  return MaterialPageRoute<Widget>(
                    builder: (_) => ProviderScope(overrides: [
                      detailMovieViewModelProvider.overrideWithProvider(
                          StateNotifierProvider.autoDispose(
                              (ref) => DetailMovieViewModel(mockMovieService))),
                      listActorViewModelProvider.overrideWithProvider(
                          StateNotifierProvider.autoDispose(
                              (ref) => ListActorViewModel(mockMovieService))),
                      videoTrailerViewModelProvider.overrideWithProvider(
                          StateNotifierProvider.autoDispose(
                              (ref) => VideoTrailerViewModel(mockMovieService)))
                    ], child: screen),
                    settings: RouteSettings(arguments: 1),
                  );
                },
              ),
            ))));

    await tester.pump();

    expect(find.text("Sinopsis"), findsOneWidget);
  });
}
