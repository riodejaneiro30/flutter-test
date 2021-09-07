import 'package:moviedb/core/models/genre.dart';

class MovieDetail {
  final int id;
  final String title;
  final double rating;
  final String poster;
  final String backdrop;
  final String sinopsis;
  final int voteCount;
  final List<Genre> genres;

  MovieDetail(this.id, this.title, this.rating, this.poster, this.backdrop,
      this.sinopsis, this.voteCount, this.genres);

  MovieDetail.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        title = json['title'],
        rating = json['vote_average'],
        poster = json['poster_path'],
        backdrop = json['backdrop_path'],
        sinopsis = json['overview'],
        voteCount = json['vote_count'],
        genres = List<Genre>.from(
            json['genres'].map((dynamic e) => Genre.fromJson(e)).toList());
}
