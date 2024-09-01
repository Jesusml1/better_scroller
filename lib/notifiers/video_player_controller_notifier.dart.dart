import 'package:better_scroller/models/video/video.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:video_player/video_player.dart';

class VideoPlayerControllerNotifier
    extends AutoDisposeNotifier<Map<int, VideoPlayerController>> {
  @override
  Map<int, VideoPlayerController> build() {
    ref.onDispose(() {
      state.forEach((_, controller) => controller.dispose());
    });
    return {};
  }

  void initializeControllers(int index, List<Video> videos) async {
    // calculate of indices to keep loaded
    final start = (index - 2).clamp(0, videos.length - 1);
    final end = (index + 2).clamp(0, videos.length - 1);

    // dispose controllers that are aout of range
    state.forEach((i, controller) {
      if (i < start || i > end) {
        controller.dispose();
      }
    });

    // filter out disposed controllers from state
    state.removeWhere((i, _) => i < start || i > end);

    // load controllers in new range
    for (int i = start; i <= end; i++) {
      if (!state.containsKey(i)) {
        final controller =
            VideoPlayerController.networkUrl(Uri.parse(videos[i].url));
        await controller.initialize();
        await controller.setLooping(true);
        if (i == 0) {
          await controller.play();
        }
        state = {...state, i: controller};
      }
    }
  }

  void playVideo(int index) {
    final controller = state[index];
    if (controller != null && !controller.value.isPlaying) {
      controller.play();
    }
  }

  void pauseVideo(int index) {
    final controller = state[index];
    if (controller != null && controller.value.isPlaying) {
      controller.pause();
    }
  }

  void resetVideo(int index) {
    final controller = state[index];
    if (controller != null) {
      controller.seekTo(Duration.zero);
      controller.pause();
    }
  }

  VideoPlayerController? getController(int index) {
    return state[index];
  }

  // @override
  // void dispose(){
  //   state.forEach((_, controller) => controller.dispose());
  //   super.dispose();
  // }
}
