class Movie {
  final int id;
  final String title;
  final double rating;
  final String poster;
  final String backdrop;

  Movie(this.id, this.title, this.rating, this.poster, this.backdrop);

  Movie.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        title = json['title'],
        rating = json['rating'],
        poster = json['poster'],
        backdrop = json['backdrop'];
}