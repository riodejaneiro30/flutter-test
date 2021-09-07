import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class VideoPlayerMovie extends StatefulWidget {
  final String url;
  const VideoPlayerMovie({Key? key, required this.url}) : super(key: key);

  @override
  _VideoPlayerMovieState createState() => _VideoPlayerMovieState();
}

class _VideoPlayerMovieState extends State<VideoPlayerMovie> {
  late YoutubePlayerController _controller;
  @override
  void initState() {
    super.initState();
    _controller = YoutubePlayerController(
      initialVideoId: widget.url,
      flags: YoutubePlayerFlags(
        mute: false,
        autoPlay: false,
        loop: false,
        disableDragSeek: true,
      ),
    );
  }

  @override
  void dispose() {
    // Ensure disposing of the VideoPlayerController to free up resources.
    _controller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return YoutubePlayer(
      controller: _controller,
      showVideoProgressIndicator: true,
      onReady: () {},
    );
  }
}
