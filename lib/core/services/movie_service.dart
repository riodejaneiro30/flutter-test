import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:moviedb/core/common/constants.dart';
import 'package:moviedb/core/models/movie.dart';
import 'package:moviedb/core/models/movie_detail.dart';
import 'package:moviedb/core/models/actor.dart';
import 'package:moviedb/core/models/video_response.dart';
import 'package:moviedb/core/providers/dio_provider.dart';

final movieServiceProvider =
    Provider((ref) => MovieService(ref.read(dioProvider)));

class MovieService {
  final Dio _dio;

  MovieService(this._dio);

  Future<List<Movie>> getPopularMovie(int page) async {
    List<Movie> movies = [];
    var response = await _dio.get(
        '${API_URL}discover/movie?api_key=${API_KEY}&language=en-US&sort_by=popularity.desc&include_adult=true&include_video=false&page=1&with_watch_monetization_types=flatrate');

    if (response.data.length > 0) {
      if (response.data['results'].length > 0) {
        for (var movieRes in response.data['results']) {
          Movie newMovie = new Movie(
            movieRes['id'],
            movieRes['title'],
            double.parse(movieRes['vote_average'].toString()),
            'https://www.themoviedb.org/t/p/w300${movieRes['poster_path']}',
            'https://www.themoviedb.org/t/p/w780${movieRes['backdrop_path']}',
          );
          movies.add(newMovie);
        }
      }
    }

    return movies;
  }

  Future<List<Movie>> getUpcoming(int page, int pageSize) async {
    List<Movie> movies = [];
    var response = await _dio.get(
        '${API_URL}movie/upcoming?api_key=${API_KEY}&language=en-US&page=1');

    if (response.data.length > 0) {
      if (response.data['results'].length > 0) {
        for (var movieRes in response.data['results']) {
          Movie newMovie = new Movie(
              movieRes['id'],
              movieRes['title'],
              double.parse(movieRes['vote_average'].toString()),
              'https://www.themoviedb.org/t/p/w300${movieRes['poster_path']}',
              'https://www.themoviedb.org/t/p/w780${movieRes['backdrop_path']}');
          movies.add(newMovie);
          if (movies.length == pageSize) {
            break;
          }
        }
      }
    }

    return movies;
  }

  Future<MovieDetail> getMovieById(int id) async {
    try {
      var response =
          await _dio.get('${API_URL}movie/$id?api_key=$API_KEY&language=en-US');
      return MovieDetail.fromJson(response.data);
    } catch (err) {
      throw (err);
    }
  }

  Future<VideoResponse> getVideoById(int id) async {
    try {
      var response = await _dio
          .get('${API_URL}movie/${id}/videos?api_key=$API_KEY&language=en-US');
      return VideoResponse.fromJson(response.data);
    } catch (err) {
      throw (err);
    }
  }

  Future<List<Actor>> getCastById(int id) async {
    try {
      var response = await _dio
          .get('${API_URL}movie/${id}/credits?api_key=$API_KEY&language=en-US');
      List<Actor> tmp = [];
      for (dynamic data in response.data["cast"]) {
        if (tmp.length > 4) break;
        tmp.add(Actor.fromJson(data));
      }
      return tmp;
    } catch (err) {
      throw (err);
    }
  }
}
