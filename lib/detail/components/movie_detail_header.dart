import 'package:flutter/material.dart';
import 'package:moviedb/core/common/functions.dart';
import 'package:moviedb/core/models/movie_detail.dart';

class MovieDetailHeader extends StatelessWidget {
  final MovieDetail movie;
  const MovieDetailHeader({
    Key? key,
    required this.movie,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        Image.network(
          'https://www.themoviedb.org/t/p/w1280${movie.backdrop}',
          fit: BoxFit.cover,
          height: 360,
          width: double.infinity,
        ),
        Container(
          height: 180,
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: FractionalOffset.center,
                  end: FractionalOffset.bottomCenter,
                  colors: [
                Colors.black.withOpacity(0.5),
                Colors.black.withOpacity(0.9),
              ],
                  stops: [
                0.0,
                1.0
              ])),
        ),
        Positioned(
          bottom: 0,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Container(
                  padding: EdgeInsets.all(20),
                  width: MediaQuery.of(context).size.width * 0.6,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        movie.title,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 21,
                            fontWeight: FontWeight.w600),
                      ),
                      Wrap(
                        spacing: 4,
                        children: List.generate(
                            movie.genres.length,
                            (index) => Text(
                                  "● ${movie.genres[index].name}",
                                  style: TextStyle(
                                      fontSize: 13,
                                      color: hexToColor("#DEDDDF")),
                                )),
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.star,
                            color: hexToColor("#F99601"),
                            size: 14,
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            "${movie.rating}/10",
                            style: TextStyle(
                                color: hexToColor("#777777"),
                                fontSize: 13,
                                fontWeight: FontWeight.w400),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 6,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.thumb_up_alt_outlined,
                            color: hexToColor("#A4A3A9"),
                            size: 14,
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            "${movie.voteCount} Users",
                            style: TextStyle(
                                color: hexToColor("#777777"),
                                fontSize: 13,
                                fontWeight: FontWeight.w400),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      InkWell(
                        child: Container(
                          width: double.infinity,
                          padding: EdgeInsets.symmetric(vertical: 6),
                          decoration: BoxDecoration(
                              color: hexToColor("#E82626"),
                              borderRadius: BorderRadius.circular(8)),
                          child: Center(child: Text("Watch Now")),
                        ),
                      )
                    ],
                  )),
              Container(
                width: MediaQuery.of(context).size.width * 0.4,
                padding: EdgeInsets.all(20),
                child: Align(
                  alignment: Alignment.centerRight,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.network(
                      'https://www.themoviedb.org/t/p/w1280${movie.poster}',
                      fit: BoxFit.fitHeight,
                      height: 170,
                    ),
                  ),
                ),
              )
            ],
          ),
        )
      ],
    );
  }
}
