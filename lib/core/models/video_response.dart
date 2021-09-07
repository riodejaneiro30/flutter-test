import 'package:moviedb/core/models/video_trailer.dart';

class VideoResponse {
  final int id;
  final List<VideoTrailer> videos;

  VideoResponse(this.id, this.videos);

  VideoResponse.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        videos = List<VideoTrailer>.from(json['results']
            .map((value) => VideoTrailer.fromJson(value))
            .toList());
}
