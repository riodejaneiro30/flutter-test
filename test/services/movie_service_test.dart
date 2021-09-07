import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart';
import 'package:moviedb/core/common/constants.dart';
import 'package:moviedb/core/models/actor.dart';
import 'package:moviedb/core/models/movie.dart';
import 'package:moviedb/core/models/movie_detail.dart';
import 'package:moviedb/core/models/video_response.dart';
import 'package:moviedb/core/providers/dio_provider.dart';
import 'package:moviedb/core/services/movie_service.dart';

import '../mock/mock_response_from_api.dart';

void main() {
  final mockDioProvider = Dio();
  final dioAdapter = DioAdapter(dio: mockDioProvider);
  mockDioProvider.httpClientAdapter = dioAdapter;
  test("Get Movie Detail By Id Success test", () async {
    const path = '${API_URL}movie/1?api_key=$API_KEY&language=en-US';
    dioAdapter.onGet(
      path,
      (request) => request.reply(200, dummyDetailMovieRestApi),
    );
    final container = ProviderContainer(
      overrides: [dioProvider.overrideWithValue(mockDioProvider)],
    );

    final service = container.read(movieServiceProvider);

    MovieDetail movieDetail = await service.getMovieById(1);
    expect(movieDetail, TypeMatcher<MovieDetail>());
  });

  test("Get Movie Detail By Id Error test", () async {
    const path = '${API_URL}movie/200?api_key=$API_KEY&language=en-US';
    dioAdapter.onGet(
      path,
          (request) => request.reply(400, {'message': 'Error'}),
    );
    final container = ProviderContainer(
      overrides: [dioProvider.overrideWithValue(mockDioProvider)],
    );

    final service = container.read(movieServiceProvider);

    expect(service.getMovieById(1000), throwsException);
  });

  test("Get Video Trailer By Id Success test", () async {
    const path = '${API_URL}movie/1/videos?api_key=$API_KEY&language=en-US';
    dioAdapter.onGet(
      path,
      (request) => request.reply(200, dummyVideoTrailerRestApi),
    );
    final container = ProviderContainer(
      overrides: [dioProvider.overrideWithValue(mockDioProvider)],
    );

    final service = container.read(movieServiceProvider);

    VideoResponse videoResponse = await service.getVideoById(1);
    expect(videoResponse, TypeMatcher<VideoResponse>());
  });

  test("Get Video Trailer By Id Error test", () async {
    const path = '${API_URL}movie/2000/videos?api_key=$API_KEY&language=en-US';
    dioAdapter.onGet(
      path,
          (request) => request.reply(400, {'message': 'Error'}),
    );
    final container = ProviderContainer(
      overrides: [dioProvider.overrideWithValue(mockDioProvider)],
    );

    final service = container.read(movieServiceProvider);

    expect(service.getVideoById(2000), throwsException);
  });

  test("Get Cast By Id Success test", () async {
    const path = '${API_URL}movie/1/credits?api_key=$API_KEY&language=en-US';
    dioAdapter.onGet(
      path,
      (request) => request.reply(200, dummyCastRestApi),
    );
    final container = ProviderContainer(
      overrides: [dioProvider.overrideWithValue(mockDioProvider)],
    );

    final service = container.read(movieServiceProvider);

    List<Actor> listActor = await service.getCastById(1);
    expect(listActor, TypeMatcher<List<Actor>>());
  });

  test("Get Cast By Id Error test", () async {
    const path = '${API_URL}movie/2000/credits?api_key=$API_KEY&language=en-US';
    dioAdapter.onGet(
      path,
          (request) => request.reply(400, {'message': 'Error'}),
    );
    final container = ProviderContainer(
      overrides: [dioProvider.overrideWithValue(mockDioProvider)],
    );

    final service = container.read(movieServiceProvider);

    expect(service.getCastById(2000), throwsException);
  });

  test("Get Popular Movies Success test", () async {
    const path = '${API_URL}discover/movie?api_key=$API_KEY&language=en-US&sort_by=popularity.desc&include_adult=true&include_video=false&page=1&with_watch_monetization_types=flatrate';
    dioAdapter.onGet(
      path,
          (request) => request.reply(200, dummyMovieRestApi),
    );
    final container = ProviderContainer(
      overrides: [dioProvider.overrideWithValue(mockDioProvider)],
    );

    final service = container.read(movieServiceProvider);

    List<Movie> listMovie = await service.getPopularMovie(1);

    expect(listMovie.length, dummyMovieRestApi["results"]!.length);
    expect(listMovie, TypeMatcher<List<Movie>>());
  });

  // test("Get Popular Movies Error test", () async {
  //   const path = '${API_URL}discover/movie?api_key=${API_KEY}&language=en-US&sort_by=popularity.desc&include_adult=true&include_video=false&page=5000&with_watch_monetization_types=flatrate';
  //   dioAdapter.onGet(
  //     path,
  //         (request) => request.reply(400, {'message': 'Error'}),
  //   );
  //   final container = ProviderContainer(
  //     overrides: [dioProvider.overrideWithValue(mockDioProvider)],
  //   );
  //
  //   final service = container.read(movieServiceProvider);
  //
  //   expect(service.getPopularMovie(5000), throwsException);
  // });

  test("Get Upcoming Movies Success With PageSize Less Than Data test", () async {
    const path = '${API_URL}movie/upcoming?api_key=${API_KEY}&language=en-US&page=1';
    dioAdapter.onGet(
      path,
          (request) => request.reply(200, dummyMovieRestApi),
    );
    final container = ProviderContainer(
      overrides: [dioProvider.overrideWithValue(mockDioProvider)],
    );

    final service = container.read(movieServiceProvider);

    List<Movie> listMovie = await service.getUpcoming(1, 2);

    expect(listMovie.length, 2);
    expect(listMovie, TypeMatcher<List<Movie>>());
  });

  test("Get Upcoming Movies Success With PageSize Not Less Than Data test", () async {
    const path = '${API_URL}movie/upcoming?api_key=${API_KEY}&language=en-US&page=1';
    dioAdapter.onGet(
      path,
          (request) => request.reply(200, dummyMovieRestApi),
    );
    final container = ProviderContainer(
      overrides: [dioProvider.overrideWithValue(mockDioProvider)],
    );

    final service = container.read(movieServiceProvider);

    List<Movie> listMovie = await service.getUpcoming(1, 5);

    expect(listMovie.length, dummyMovieRestApi["results"]!.length);
    expect(listMovie, TypeMatcher<List<Movie>>());
  });

  // test("Get Upcoming Movies Error test", () async {
  //   const path = '${API_URL}movie/upcoming?api_key=${API_KEY}&language=en-US&page=5000';
  //   dioAdapter.onGet(
  //     path,
  //         (request) => request.reply(400, {'message': 'Error'}),
  //   );
  //   final container = ProviderContainer(
  //     overrides: [dioProvider.overrideWithValue(mockDioProvider)],
  //   );
  //
  //   final service = container.read(movieServiceProvider);
  //
  //   expect(service.getUpcoming(5000, 50), throwsException);
  // });
}
