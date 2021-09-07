import 'package:moviedb/core/models/actor.dart';
import 'package:moviedb/core/models/movie.dart';
import 'package:moviedb/core/models/movie_detail.dart';
import 'package:moviedb/core/models/video_response.dart';

import 'mock_response_from_api.dart';

final mockMovieDetail = MovieDetail.fromJson(dummyDetailMovieRestApi);

final mockVideoResponse = VideoResponse.fromJson(dummyDetailMovieRestApi);

final mockListActor = List<Actor>.from(
    dummyCastRestApi["cast"]!.map((e) => Actor.fromJson(e)).toList());

final mockListMovies = List<Movie>.from(
    dummyMovieRestApi["results"]!.map((e) => Movie.fromJson(e)).toList());
