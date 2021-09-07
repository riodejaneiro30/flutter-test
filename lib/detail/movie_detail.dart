import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:moviedb/core/models/actor.dart';
import 'package:moviedb/core/models/movie_detail.dart';
import 'package:moviedb/core/models/video_response.dart';
import 'package:moviedb/core/providers/firebase_analytic_provider.dart';
import 'package:moviedb/detail/components/movie_detail_header.dart';
import 'package:moviedb/detail/components/video_player.dart';
import 'package:moviedb/detail/list_cast_view_model.dart';
import 'package:moviedb/detail/movie_detail_view_model.dart';
import 'package:moviedb/detail/video_trailer_view_model.dart';

class MovieDetailScreen extends StatelessWidget {
  const MovieDetailScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final id = ModalRoute.of(context)!.settings.arguments as int;
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) async {
      context.read(detailMovieViewModelProvider.notifier).loadDataById(id);
      context.read(listActorViewModelProvider.notifier).loadDataById(id);
      context.read(videoTrailerViewModelProvider.notifier).loadDataById(id);

      await context.read(analyticProvider).logEvent(name: "detail_screen");
    });

    return Scaffold(
      backgroundColor: Colors.black,
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return [
            SliverAppBar(
              backgroundColor: Colors.black,
              expandedHeight: 360.0,
              centerTitle: true,
              pinned: true,
              actions: [
                Padding(
                  padding: const EdgeInsets.only(right: 16),
                  child: Icon(Icons.favorite),
                )
              ],
              flexibleSpace: FlexibleSpaceBar(
                background: Consumer(builder: (context, watch, child) {
                  final state = watch(detailMovieViewModelProvider);

                  return state.when(data: (MovieDetail? movie) {
                    return MovieDetailHeader(
                      movie: movie!,
                    );
                  }, loading: () {
                    return CircularProgressIndicator();
                  }, error: (e, s) {
                    return Text(e.toString());
                  });
                }),
              ),
            ),
          ];
        },
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 20,
                ),
                Text(
                  "Sinopsis",
                  style: TextStyle(fontSize: 21, fontWeight: FontWeight.w600),
                ),
                SizedBox(
                  height: 10,
                ),
                Consumer(builder: (context, watch, child) {
                  final state = watch(detailMovieViewModelProvider);
                  return state.when(data: (MovieDetail? movie) {
                    return Text(movie!.sinopsis);
                  }, loading: () {
                    return CircularProgressIndicator();
                  }, error: (e, s) {
                    return Text(e.toString());
                  });
                }),
                SizedBox(
                  height: 20,
                ),
                Text(
                  "Trailer",
                  style: TextStyle(fontSize: 21, fontWeight: FontWeight.w600),
                ),
                SizedBox(
                  height: 10,
                ),
                Consumer(builder: (context, watch, child) {
                  final state = watch(videoTrailerViewModelProvider);
                  return state.when(data: (VideoResponse? videos) {
                    String url = videos!.videos
                        .firstWhere((element) => element.site == "YouTube")
                        .key;
                    return VideoPlayerMovie(url: url);
                  }, loading: () {
                    return CircularProgressIndicator();
                  }, error: (e, s) {
                    return Text(e.toString());
                  });
                }),
                SizedBox(
                  height: 34,
                ),
                Text(
                  "Cast",
                  style: TextStyle(fontSize: 21, fontWeight: FontWeight.w600),
                ),
                Consumer(builder: (context, watch, child) {
                  final state = watch(listActorViewModelProvider);
                  return state.when(data: (List<Actor>? actors) {
                    return Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: List.generate(4, (index) {
                        if (index > actors!.length - 1) {
                          return Expanded(child: Container());
                        }
                        return Expanded(
                            child: Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              AspectRatio(
                                aspectRatio: 1,
                                child: Container(
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(4),
                                    child: actors[index].urlPhoto != null
                                        ? Image.network(
                                            "https://www.themoviedb.org/t/p/w300/${actors[index].urlPhoto}",
                                            fit: BoxFit.cover,
                                          )
                                        : Container(
                                            color: Colors.grey,
                                          ),
                                  ),
                                ),
                              ),
                              Text(
                                actors[index].name,
                                style: TextStyle(
                                    fontSize: 12, fontWeight: FontWeight.w800),
                              )
                            ],
                          ),
                        ));
                      }),
                    );
                  }, loading: () {
                    return CircularProgressIndicator();
                  }, error: (e, s) {
                    return Text(e.toString());
                  });
                })
              ],
            ),
          ),
        ),
      ),
    );
  }
}
