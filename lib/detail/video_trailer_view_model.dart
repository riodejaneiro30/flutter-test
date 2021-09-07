import 'package:moviedb/core/services/movie_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:moviedb/core/models/video_response.dart';

final videoTrailerViewModelProvider = StateNotifierProvider.autoDispose<
    VideoTrailerViewModel, AsyncValue<VideoResponse>>((ref) {
  return VideoTrailerViewModel(ref.watch(movieServiceProvider));
});

class VideoTrailerViewModel extends StateNotifier<AsyncValue<VideoResponse>> {
  final MovieService _movieService;

  VideoTrailerViewModel(this._movieService) : super(AsyncLoading());

  void loadDataById(int id) async {
    state = AsyncLoading();
    try {
      VideoResponse videoResponse = await _movieService.getVideoById(id);
      state = AsyncData(videoResponse);
    } catch (err) {
      state = AsyncError(err);
    }
  }
}
